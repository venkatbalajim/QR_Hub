import 'imports.dart';

class QRCodeData {
  String scannedDate;
  String scannedTime;
  String dataType;
  String qrCodeData; 

  QRCodeData({
    required this.scannedDate,
    required this.scannedTime,
    required this.dataType,
    required this.qrCodeData,
  });

  Map<String, dynamic> toJson() {
    return {
      'scan_date': scannedDate,
      'scan_time': scannedTime,
      'qr_code_type': dataType,
      'qr_code_data': qrCodeData,
    };
  }

  factory QRCodeData.fromJson(Map<String, dynamic> json) {
    return QRCodeData(
      scannedDate: json['scan_date'] ?? '',
      scannedTime: json['scan_time'] ?? '',
      dataType: json['qr_code_type'] ?? '',
      qrCodeData: json['qr_code_data'] ?? '',
    );
  }
}

class QRCodeHistoryManager {
  static const _key = 'qr_scan_history';

  Future<List<QRCodeData>> getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_key);
    if (historyJson != null) {
      final List<Map<String, dynamic>> historyList =
          (json.decode(historyJson) as List).cast<Map<String, dynamic>>();
      final List<Map<String, dynamic>> castedHistoryList =
          historyList.map((item) {
        return item.cast<String, dynamic>();
      }).toList(growable: false);

      return castedHistoryList
          .map((item) => QRCodeData.fromJson(item))
          .toList(growable: true);
    }
    return [];
  }

  Future<void> addToHistory(QRCodeData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final history = await getHistory();
    history.add(data);
    final historyJson =
        json.encode(history.map((item) => item.toJson()).toList());
    prefs.setString(_key, historyJson);
  }

  Future<void> saveHistory(List<QRCodeData> history) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final historyJson =
        json.encode(history.map((item) => item.toJson()).toList());
    prefs.setString(_key, historyJson);
  }
}
