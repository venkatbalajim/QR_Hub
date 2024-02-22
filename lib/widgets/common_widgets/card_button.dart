import '../../utils/imports.dart';

class CardButton extends StatefulWidget {
  final IconData iconName;
  final String buttonName;
  final VoidCallback onPressed;
  const CardButton({
    super.key, required this.iconName, 
    required this.buttonName, required this.onPressed
  });

  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 80,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(widget.iconName, size: 35, color: Theme.of(context).colorScheme.primary,),
            Text(
              widget.buttonName, 
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400
              ),
            )
          ],
        ),
      ),
    );
  }
}
