import '../../utils/imports.dart';

// Widget to display URL
class TextWidget extends StatelessWidget {
  final String? text;
  final BarcodeType type;
  const TextWidget({Key? key, this.text, required this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Uri? url;
    if (text != null) {
      try {
        String query = Uri.encodeFull(text!);
        url = Uri.parse('https://www.google.com/search?q=$query');
      // ignore: empty_catches
      } catch (e) {}
    }
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(13, 71, 161, 1),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(text!,
            style: const TextStyle(fontSize: 18, color: Color.fromRGBO(13, 71, 161, 1)),
          ),
        ),
        const SizedBox(height: 20,),
        TextIconButton(
          onPressed: () async {
            if (url != null && await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          },
        )
      ],
    );
  }
}
