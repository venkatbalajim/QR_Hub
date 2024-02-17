import '../../utils/imports.dart';

class TextIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TextIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            Icons.search,
            color: Colors.blue[900],
            size: 40,
          ),
        ),
        Text(
          'Web Search',
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