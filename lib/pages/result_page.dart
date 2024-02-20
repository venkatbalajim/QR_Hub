import '../utils/imports.dart';

class ResultPage extends StatefulWidget {
  final BarcodeCapture value;
  final Function() screenClose;

  const ResultPage({super.key, required this.value, required this.screenClose});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  dynamic result = '';
  String scannedDate = '';
  String scannedTime = '';
  String dataType = '';
  late Barcode value; 

  @override
  void initState() {
    super.initState();
    parseData();
  }

  void parseData() {
    List<Barcode> fetchData = widget.value.barcodes;
    if (fetchData.isNotEmpty) {
      value = fetchData.first;
      result = value.rawValue;
      Validation validation = Validation();
      scannedDate = validation.formatDate(DateTime.now());
      scannedTime = validation.formatTime(DateTime.now());
      dataType = validation.getDataType(value.type);
    } else {
      result = '';
      scannedDate = '';
      scannedTime = '';
      dataType = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    parseData();
    // ignore: deprecated_member_use
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                widget.screenClose();
                Navigator.popUntil(context, (route) => route.settings.name == '/scanner');
              }, icon: const Icon(
                Icons.qr_code_scanner
              )
            ),
            automaticallyImplyLeading: false,
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue[900],
            title: const Text(
              "Scan Result", 
              style: TextStyle(
                fontSize: 18, 
              )
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  copyToClipboard(context, value);
                }, 
                icon: const Icon(
                  Icons.copy
                )
              ),
              IconButton(
                onPressed: () {
                  shareContent(value);
                }, 
                icon: const Icon(
                  Icons.share
                )
              )
            ],
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(13, 71, 161, 1),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 300,
                      height: 50,
                      child: Text('$scannedDate, $scannedTime, $dataType', 
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      )
                    ),
                    const SizedBox(height: 20),
                    ResultContainer(data: value),
                  ],
                ),
              )
            ],
          ),
        )
      ), 
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.settings.name == '/');
        return true;
      },
    );
  }
}
