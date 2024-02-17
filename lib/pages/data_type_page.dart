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
              DataTypeButton(
                datatypeName: 'Text',
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
              const SizedBox(height: 15,),
              DataTypeButton(
                datatypeName: 'URL',
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
              const SizedBox(height: 15,),
              DataTypeButton(
                datatypeName: 'Geo',
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
              const SizedBox(height: 15,),
              DataTypeButton(
                datatypeName: 'Phone',
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
              const SizedBox(height: 15,),
              DataTypeButton(
                datatypeName: 'Wifi',
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
              const SizedBox(height: 15,),
              DataTypeButton(
                datatypeName: 'Event',
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
              const SizedBox(height: 15,),
              DataTypeButton(
                datatypeName: 'vCard',
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
              const SizedBox(height: 15,),
              DataTypeButton(
                datatypeName: 'Email',
                iconName: Icons.email_outlined,
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => const GeneratorPage(qrCodeType: 'Email',),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15,),
              DataTypeButton(
                datatypeName: 'SMS',
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
        )
      ), 
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.settings.name == '/');
        return true;
      }
    );
  }
}
