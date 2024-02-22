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
            color: Theme.of(context).colorScheme.primary,
            size: 40,
          ),
        ),
        Text(
          buttonName,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
