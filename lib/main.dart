import 'utils/imports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner & Generator',
      initialRoute: '/',
      routes: {
        '/generator': (context) => const GeneratorPage(),
        '/scanner': (context) => const ScannerPage(),
        '/qrcodetype': (context) => const DataTypePage(),
      },
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
