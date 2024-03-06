import '../../utils/imports.dart';

// ignore: non_constant_identifier_names
void SnackBarWidget(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: 300,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
    ),
  );
}
