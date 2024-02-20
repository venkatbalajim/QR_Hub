import '../../utils/imports.dart';

class GeoIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GeoIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            Icons.location_on_rounded,
            color: Colors.blue[900],
            size: 40,
          ),
        ),
        Text(
          'Show Map',
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
