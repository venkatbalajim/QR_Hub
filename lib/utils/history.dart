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

  List<dynamic> toList() {
    return [
      scannedDate,
      scannedTime,
      dataType,
      qrCodeData,
    ];
  }

  factory QRCodeData.fromList(List<dynamic> list) {
    return QRCodeData(
      scannedDate: list[0] ?? '',
      scannedTime: list[1] ?? '',
      dataType: list[2] ?? '',
      qrCodeData: list[3] ?? const Barcode(),
    );
  }
}

class QRCodeHistoryManager {
  static const _key = 'qr_scan_history';

  Future<List<QRCodeData>> getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_key);
    if (historyJson != null) {
      final List<List<dynamic>> historyList =
          (json.decode(historyJson) as List).cast<List<dynamic>>();
      return historyList
          .map((item) => QRCodeData.fromList(item))
          .toList(growable: true);
    }
    return [];
  }

  Future<void> addToHistory(QRCodeData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final history = await getHistory();
    history.add(data);
    final historyJson = json.encode(history.map((item) => item.toList()).toList());
    prefs.setString(_key, historyJson);
  }

  Future<void> saveHistory(List<QRCodeData> history) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final historyJson = json.encode(history.map((item) => item.toList()).toList());
    prefs.setString(_key, historyJson);
  }
}
