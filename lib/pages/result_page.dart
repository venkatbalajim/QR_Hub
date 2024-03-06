import '../utils/imports.dart';

class ResultPage extends StatefulWidget {
  final Barcode value;
  final Uint8List? image;
  final Function()? screenClose;
  final String? scannedDate;
  final String? scannedTime;
  final String? dataType;

  const ResultPage({
    super.key, 
    required this.value, this.screenClose, 
    this.scannedDate, this.scannedTime, 
    this.dataType, required this.image
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  dynamic result = '';
  String displayDate = '';
  String displayTime = '';
  String displayDataType = '';
  late Barcode value; 

  @override
  void initState() {
    super.initState();
    value = widget.value;
    parseData();
  }

  void parseData() {
    Barcode fetchData = widget.value;
    value = fetchData;
    result = value.rawValue;
    Validation validation = Validation();
    displayDate = widget.scannedDate ?? validation.formatDate(DateTime.now());
    displayTime = widget.scannedTime ?? validation.formatTime(DateTime.now());
    displayDataType = validation.getDataType(value.type);
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
                widget.screenClose!();
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
                  copyToClipboard(context, fetchData(value));
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
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 300,
                      height: 50,
                      child: Text('$displayDate, $displayTime, $displayDataType', 
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      )
                    ),
                    const SizedBox(height: 20),
                    ResultContainer(data: value),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: Image.memory(widget.image!),
                    )
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
