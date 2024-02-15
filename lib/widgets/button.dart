import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String buttonName;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.buttonName, required this.onPressed});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onPressed();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.blue[900]
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        fixedSize: MaterialStateProperty.all(
          const Size.fromWidth(200)
        )
      ),
      child: Text(
        widget.buttonName,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400
        ),
      ),
    );
  }
}
