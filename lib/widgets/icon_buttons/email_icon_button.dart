import '../../utils/imports.dart';

class EmailIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EmailIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            Icons.email_outlined,
            color: Colors.blue[900],
            size: 40,
          ),
        ),
        Text(
          'Send Email',
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
