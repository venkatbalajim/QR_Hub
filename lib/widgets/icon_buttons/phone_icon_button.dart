import '../../utils/imports.dart';

class PhoneIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PhoneIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            Icons.phone,
            color: Colors.blue[900],
            size: 40,
          ),
        ),
        Text(
          'Call',
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