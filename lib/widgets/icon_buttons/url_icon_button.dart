import '../../utils/imports.dart';

class UrlIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UrlIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            Icons.open_in_browser,
            color: Colors.blue[900],
            size: 40,
          ),
        ),
        Text(
          'Open Link',
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
