import '../utils/imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 300,
                  child: Text(
                    "All in One QR Scanner and Generator",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )
                ),
                const SizedBox(height: 200),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CardButton(
                      onPressed: () => Navigator.pushNamed(context, '/scanner'),
                      iconName: Icons.qr_code_scanner,
                      buttonName: 'Scan',
                    ),
                    const SizedBox(width: 20),
                    CardButton(
                      onPressed: () => Navigator.pushNamed(context, '/qrcodetype'),
                      iconName: Icons.create,
                      buttonName: 'Create',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
