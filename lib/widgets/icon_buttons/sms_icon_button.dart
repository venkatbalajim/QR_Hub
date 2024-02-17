import '../../utils/imports.dart';

class SmsIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SmsIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            Icons.sms,
            color: Colors.blue[900],
            size: 40,
          ),
        ),
        Text(
          'Send SMS',
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