// ignore_for_file: avoid_print

import '../utils/imports.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  MobileScannerController cameraController = MobileScannerController(returnImage: true);
  final QRCodeHistoryManager historyManager = QRCodeHistoryManager();
  List<QRCodeData> historyList = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final historyManager = QRCodeHistoryManager();
    final history = await historyManager.getHistory();
    setState(() {
      historyList = history;
    });
  }

  BarcodeType qrCodeType(String dataType) {
    BarcodeType type;
    switch (dataType) {
      case 'Event':
        type = BarcodeType.calendarEvent;
        break;
      case 'Email':
        type = BarcodeType.email;
        break;
      case 'Geo':
        type = BarcodeType.geo;
        break;
      case 'Phone':
        type = BarcodeType.phone;
        break;
      case 'SMS':
        type = BarcodeType.sms;
        break;
      case 'URL':
        type = BarcodeType.url;
        break;
      case 'vCard':
        type = BarcodeType.contactInfo;
        break;
      case 'Wi-fi':
        type = BarcodeType.wifi;
        break;
      default:
        type = BarcodeType.unknown;
    }
    return type;
  }

  Widget buildIconBasedOnType(String dataType) {
    IconData iconData;
    switch (dataType) {
      case 'Event':
        iconData = Icons.event;
        break;
      case 'Email':
        iconData = Icons.email_outlined;
        break;
      case 'Geo':
        iconData = Icons.location_on_rounded;
        break;
      case 'Phone':
        iconData = Icons.phone;
        break;
      case 'SMS':
        iconData = Icons.sms;
        break;
      case 'URL':
        iconData = Icons.link;
        break;
      case 'vCard':
        iconData = Icons.person;
        break;
      case 'Wi-fi':
        iconData = Icons.wifi;
        break;
      default:
        iconData = Icons.text_fields;
    }
    return Icon(iconData, color: Theme.of(context).colorScheme.primary);
  }

  @override
  Widget build(BuildContext context) {

    void deleteItemFromHistory(int index) async {
      List<QRCodeData> storedHistory = await historyManager.getHistory();
      storedHistory.removeAt(index);
      await historyManager.saveHistory(storedHistory);
      setState(() {historyList.removeAt(index);});
    }

    void clearHistory() async {
      List<QRCodeData> storedHistory = await historyManager.getHistory();
      storedHistory.clear();
      await historyManager.saveHistory(storedHistory);
      setState(() {
        historyList = [];
      });
    }

    return SafeArea(
      // ignore: deprecated_member_use
      child: WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.blue[900],
              foregroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  if (historyList.isEmpty) {
                    SnackBarWidget(context, 'Currently there is no history.');
                  } else {
                    downloadHistory(context, historyList);
                  }
                }, 
                icon: const Icon(
                  Icons.download, size: 25,
                )
              ),
              title: const Text(
                'QR Scanner History',
                style: TextStyle(fontSize: 18),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    if (historyList.isEmpty) {
                      SnackBarWidget(context, 'Currently there is no history.');
                    } else {
                      clearHistory();
                    }
                  }, 
                  icon: const Icon(
                    Icons.delete_forever, size: 25,
                  )
                )
              ],
              centerTitle: true,
              automaticallyImplyLeading: false,
          ),
          body: historyList.isEmpty ? 
            Center(
              child: Text('No History', style: Theme.of(context).textTheme.labelSmall),
            ) : ListView.builder(
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      final reversedIndex = historyList.length - 1 - index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          onTap: () {
                            showQRDataDialog(context, historyList[reversedIndex]);
                          },
                          leading: buildIconBasedOnType(historyList[reversedIndex].dataType),
                          title: Text(historyList[reversedIndex].dataType),
                          subtitle: Text('Date: ${historyList[reversedIndex].scannedDate}\nTime: ${historyList[reversedIndex].scannedTime}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteItemFromHistory(reversedIndex);
                            },
                          ),
                        ),
                      );
                    },
                  )
        ), 
        onWillPop: () async {
          Navigator.popUntil(context, (route) => route.settings.name == '/');
          return true;
        }
      )
    );
  }
}

void showQRDataDialog(BuildContext context, QRCodeData data) {

  String contentData = '''
Date: ${data.scannedDate}
Time: ${data.scannedTime}

${data.qrCodeData}
''';

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("${data.dataType} QR Code"),
        content: Text(contentData),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  copyToClipboard(context, contentData);
                }, 
                icon: Icon(Icons.copy, color: Theme.of(context).colorScheme.primary,)
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                icon: Icon(Icons.close, color: Theme.of(context).colorScheme.primary,)
              ),
            ],
          )
        ],
      );
    },
  );
}
