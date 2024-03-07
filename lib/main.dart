import 'utils/imports.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _requestPermissions();

    return MaterialApp(
      title: 'QR Hub',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/generator':(context) => const GeneratorPage(),
        '/scanner':(context) => const ScannerPage(),
        '/qrcodetype':(context) => const DataTypePage(),
        '/history': (context) => const HistoryPage(),
      },
      theme: Provider.of<ThemeProvider>(context).isNightModeEnabled
          ? darkTheme
          : lightTheme,
      home: const HomePage(),
    );
  }

  Future<void> _requestPermissions() async {
    final mobileAndroidInfo = await DeviceInfoPlugin().androidInfo;
    int? androidVersion = int.tryParse(mobileAndroidInfo.version.release);
    if (androidVersion != null && androidVersion <= 12) {
      await [Permission.camera,Permission.storage,].request();
    } else {
      await [Permission.camera,Permission.manageExternalStorage,].request();
    }
  }
}
