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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu, 
                    color: Theme.of(context).colorScheme.primary,
                  )
                );
              }
            )
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "QR Hub",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'All in One QR Scanner and Generator',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ],
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
          drawer: const AppDrawer(),
        ),
      ),
    );
  }
}
