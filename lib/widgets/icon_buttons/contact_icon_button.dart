import '../../utils/imports.dart';

class ContactInfoIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContactInfoIconButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            Icons.person_add_alt_1,
            color: Colors.blue[900],
            size: 40,
          ),
        ),
        Text(
          'Add Contact',
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
