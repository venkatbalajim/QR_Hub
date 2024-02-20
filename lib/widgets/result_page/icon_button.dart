import '../../utils/imports.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonName;
  final IconData iconName;

  const CustomIconButton({
    super.key, required this.onPressed, 
    required this.buttonName, required this.iconName
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            iconName,
            color: Colors.blue[900],
            size: 40,
          ),
        ),
        Text(
          buttonName,
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
