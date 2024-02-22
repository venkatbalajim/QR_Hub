import '../../utils/imports.dart';

// Widget to display URL
class TextWidget extends StatelessWidget {
  final String? text;
  final BarcodeType type;
  const TextWidget({super.key, this.text, required this.type});
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
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(text!,
            style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        const SizedBox(height: 20,),
        CustomIconButton(
          onPressed: () async {
            if (url != null && await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          },
          buttonName: 'Web Search',
          iconName: Icons.search,
        )
      ],
    );
  }
}
