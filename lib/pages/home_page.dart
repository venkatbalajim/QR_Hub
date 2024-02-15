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
                  child: PageTitle(title: "All in One QR Scanner and Generator")
                ),
                const SizedBox(height: 200),
                CustomButton(
                  onPressed: () => Navigator.pushNamed(context, '/scanner'),
                  buttonName: 'Scan QR Code',
                ),
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: () => Navigator.pushNamed(context, '/generator'),
                  buttonName: 'Generate QR Code',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
