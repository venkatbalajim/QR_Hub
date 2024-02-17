import '../../utils/imports.dart';

class DataTypeButton extends StatefulWidget {
  final IconData iconName;
  final String datatypeName;
  final VoidCallback onPressed;
  const DataTypeButton({
    super.key, required this.iconName, 
    required this.datatypeName, required this.onPressed
  });

  @override
  State<DataTypeButton> createState() => _DataTypeButtonState();
}

class _DataTypeButtonState extends State<DataTypeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.only(
          left: 20
        ),
        height: 50,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.blue[900]!,
            width: 2,
          )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(widget.iconName, size: 25, color: Colors.blue[900],),
            const SizedBox(width: 20,),
            Text(
              widget.datatypeName, 
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue[900]
              ),
            )
          ],
        ),
      ),
    );
  }
}
