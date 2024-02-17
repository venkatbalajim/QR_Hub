import '../../utils/imports.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final Function(String) onDataChanged;

  const CustomTextField({
    super.key,
    required this.textController,
    required this.onDataChanged,
    required this.hintText,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: TextField(
        cursorColor: Colors.blue[900],
        controller: widget.textController,
        onChanged: (data) {
          widget.onDataChanged; 
        },
        focusNode: _focusNode,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(13, 71, 161, 1),
              width: 2,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(13, 71, 161, 1),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
