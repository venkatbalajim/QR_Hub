import 'utils/imports.dart';

void main() {
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
    return MaterialApp(
      title: 'QR Hub',
      debugShowCheckedModeBanner: false,
      routes: {
        '/generator':(context) => const GeneratorPage(),
        '/scanner':(context) => const ScannerPage(),
        '/qrcodetype':(context) => const DataTypePage(),
      },
      theme: Provider.of<ThemeProvider>(context).isNightModeEnabled
          ? darkTheme
          : lightTheme,
      home: const HomePage(),
    );
  }
}
