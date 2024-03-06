
import 'imports.dart';

// Light theme 
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: TextTheme(
    headlineMedium: TextStyle(fontSize: 50, color: Colors.blue[900]),
    headlineSmall: TextStyle(fontSize: 17, color: Colors.grey[600]),
    labelSmall: TextStyle(
      fontSize: 15, color: Colors.blue[900], fontWeight: FontWeight.w400
    ),
    labelMedium: TextStyle(
      fontSize: 18, color: Colors.amber[900], fontWeight: FontWeight.w500
    ),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue[900]!),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      side: MaterialStateProperty.all(
        const BorderSide(color: Color.fromRGBO(13, 71, 161, 1), width: 2)
      ),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      foregroundColor: MaterialStateProperty.all(Colors.blue[900]),
      fixedSize: MaterialStateProperty.all(const Size(120,40)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  ),
  dialogTheme: const DialogTheme(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.white,
  ),
  datePickerTheme: DatePickerThemeData(
    cancelButtonStyle: ButtonStyle(
      shape: MaterialStateProperty.all(LinearBorder.none),
      fixedSize: MaterialStateProperty.all(const Size(80, 25)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
    ),
    confirmButtonStyle: ButtonStyle(
      shape: MaterialStateProperty.all(LinearBorder.none),
      fixedSize: MaterialStateProperty.all(const Size(40, 25)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
    ),
  ),
  timePickerTheme: TimePickerThemeData(
    cancelButtonStyle: ButtonStyle(
      shape: MaterialStateProperty.all(LinearBorder.none),
      fixedSize: MaterialStateProperty.all(const Size(80, 25)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
    ),
    confirmButtonStyle: ButtonStyle(
      shape: MaterialStateProperty.all(LinearBorder.none),
      fixedSize: MaterialStateProperty.all(const Size(40, 25)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
    ),
  )
);

// Dark theme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: TextTheme(
    headlineMedium: const TextStyle(fontSize: 40, color: Colors.cyan),
    headlineSmall: TextStyle(fontSize: 17, color: Colors.grey[500]),
    labelSmall: TextStyle(
      fontSize: 15, color: Colors.grey[500], fontWeight: FontWeight.w400
    ),
    labelMedium: TextStyle(
      fontSize: 18, color: Colors.amber[900], fontWeight: FontWeight.w500
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.cyan,
    brightness: Brightness.dark,
  ),
  drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[900]),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      side: MaterialStateProperty.all(
        const BorderSide(color: Colors.cyan, width: 2)
      ),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      foregroundColor: MaterialStateProperty.all(Colors.cyan),
      fixedSize: MaterialStateProperty.all(const Size(120,40)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    )
  ),
  dialogTheme: DialogTheme(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.grey[900],
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.grey[900],
    cancelButtonStyle: ButtonStyle(
      shape: MaterialStateProperty.all(LinearBorder.none),
      fixedSize: MaterialStateProperty.all(const Size(80, 25)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
    ),
    confirmButtonStyle: ButtonStyle(
      shape: MaterialStateProperty.all(LinearBorder.none),
      fixedSize: MaterialStateProperty.all(const Size(40, 25)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
    )
  ),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: Colors.grey[900],
    cancelButtonStyle: ButtonStyle(
      shape: MaterialStateProperty.all(LinearBorder.none),
      fixedSize: MaterialStateProperty.all(const Size(80, 25)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
    ),
    confirmButtonStyle: ButtonStyle(
      shape: MaterialStateProperty.all(LinearBorder.none),
      fixedSize: MaterialStateProperty.all(const Size(40, 25)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
    )
  )
);

class ThemeProvider with ChangeNotifier {
  bool _isNightModeEnabled = false;

  bool get isNightModeEnabled => _isNightModeEnabled;

  ThemeProvider() {
    _loadNightModeStatus();
  }

  void toggleTheme() async {
    _isNightModeEnabled = !_isNightModeEnabled;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('nightMode', _isNightModeEnabled);
  }

  void _loadNightModeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isNightModeEnabled = prefs.getBool('nightMode') ?? false;
    notifyListeners();
  }
}
