import '../../utils/imports.dart';

class CalendarEventIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CalendarEventIconButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            Icons.event,
            color: Colors.blue[900],
            size: 40,
          ),
        ),
        Text(
          'Add Event',
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