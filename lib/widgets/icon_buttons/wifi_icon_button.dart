import '../../utils/imports.dart';

class WifiIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const WifiIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            Icons.wifi,
            color: Colors.blue[900],
            size: 40,
          ),
        ),
        Text(
          'Connect',
          style: TextStyle(
            color: Colors.blue[900],
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
