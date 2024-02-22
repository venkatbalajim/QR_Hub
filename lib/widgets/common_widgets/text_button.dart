import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final String buttonName;
  final VoidCallback onPressed;
  const CustomTextButton({super.key, required this.buttonName, required this.onPressed});

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
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
        ),
        side: MaterialStateProperty.all(
          const BorderSide(color: Colors.transparent)
        ),
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
