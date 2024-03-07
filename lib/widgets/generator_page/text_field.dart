import '../../utils/imports.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final Function(String) onDataChanged;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.textController,
    required this.onDataChanged,
    required this.hintText, 
    required this.keyboardType,
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
        contextMenuBuilder: (context, editableTextState) {
          return AdaptiveTextSelectionToolbar(
            anchors: editableTextState.contextMenuAnchors,
            children: editableTextState.contextMenuButtonItems
                .map((ContextMenuButtonItem buttonItem) {
              return CupertinoButton(
                minSize: 50,
                borderRadius: const BorderRadius.all(Radius.circular(0)),
                color: Colors.grey[800],
                onPressed: buttonItem.onPressed,
                padding: const EdgeInsets.all(10.0),
                pressedOpacity: 0.7,
                child: SizedBox(
                  width: 80,
                  child: Text(
                    CupertinoTextSelectionToolbarButton.getButtonLabel(context, buttonItem),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }).toList(),
          );
        },
        cursorColor: Theme.of(context).colorScheme.primary,
        controller: widget.textController,
        onChanged: (data) {
          widget.onDataChanged; 
        },
        focusNode: _focusNode,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
