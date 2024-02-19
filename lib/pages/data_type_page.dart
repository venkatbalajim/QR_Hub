import '../utils/imports.dart';

class DataTypePage extends StatefulWidget {
  const DataTypePage({super.key});

  @override
  State<DataTypePage> createState() => _DataTypePageState();
}

class _DataTypePageState extends State<DataTypePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            foregroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: const Text('Select type of QR Code', style: TextStyle(fontSize: 18)),
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.all(30),
            children: [
              Align(
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CardButton(
                      buttonName: 'Text',
                      iconName: Icons.text_fields,
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const GeneratorPage(qrCodeType: 'Text',),
                          ),
                        );
                      },
                    ),
                    CardButton(
                      buttonName: 'URL',
                      iconName: Icons.link,
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const GeneratorPage(qrCodeType: 'URL',),
                          ),
                        );
                      },
                    ),
                    CardButton(
                      buttonName: 'Geo',
                      iconName: Icons.location_on_rounded,
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const GeneratorPage(qrCodeType: 'Geo',),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              Align(
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CardButton(
                      buttonName: 'Phone',
                      iconName: Icons.phone,
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const GeneratorPage(qrCodeType: 'Phone',),
                          ),
                        );
                      },
                    ),
                    CardButton(
                      buttonName: 'Wifi',
                      iconName: Icons.wifi,
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const GeneratorPage(qrCodeType: 'Wifi',),
                          ),
                        );
                      },
                    ),
                    CardButton(
                      buttonName: 'Event',
                      iconName: Icons.calendar_month_outlined,
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const GeneratorPage(qrCodeType: 'Event',),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              Align(
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CardButton(
                      buttonName: 'vCard',
                      iconName: Icons.person,
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const GeneratorPage(qrCodeType: 'vCard',),
                          ),
                        );
                      },
                    ),
                    CardButton(
                      buttonName: 'Email',
                      iconName: Icons.mail_outline,
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const GeneratorPage(qrCodeType: 'Email',),
                          ),
                        );
                      },
                    ),
                    CardButton(
                      buttonName: 'SMS',
                      iconName: Icons.sms,
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const GeneratorPage(qrCodeType: 'SMS',),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ), 
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.settings.name == '/');
        return true;
      }
    );
  }
}
