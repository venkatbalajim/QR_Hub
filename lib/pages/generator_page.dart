// Temporarily not for media and document files. 

import '../utils/imports.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({Key? key}) : super(key: key);

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  
  final qrDataController = TextEditingController();
  late String qrData;
  bool showQrCode = false;
  bool isEditMode = true;

  @override
  void initState() {
    super.initState();
    qrData = '';
  }

  void toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
      showQrCode = !showQrCode; 
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50,),
                    const PageTitle(title: 'QR Code Generator'),
                    const SizedBox(height: 50,),
                    if (isEditMode) 
                      CustomTextField(
                        textController: qrDataController,
                        onDataChanged: (data) {
                          setState(() {
                            qrData = data;
                          });
                        },
                      ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: 200,
                      child: CustomButton(
                        buttonName: isEditMode ? "Generate QR Code" : "Edit the Data", 
                        onPressed: toggleEditMode,
                      ),
                    ),
                    const SizedBox(height: 30,),
                    if (showQrCode)
                    GeneratedQRCode(qrData: qrData),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.settings.name == '/');
        return true;
      },
    );
  }
}
