import '../../utils/imports.dart';

// Widget to display URL
class URLWidget extends StatelessWidget {
  final String? link;
  final BarcodeType type;
  const URLWidget({super.key, this.link, required this.type});
  @override
  Widget build(BuildContext context) {
    Uri? url;
    if (link != null) {
      try {
        url = Uri.parse(link!);
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
          child: Text(link!,
            style: const TextStyle(fontSize: 18, color: Color.fromRGBO(13, 71, 161, 1)),
          ),
        ),
        const SizedBox(height: 20,),
        CustomIconButton(
          onPressed: () async {
            if (url != null && await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          },
          buttonName: 'Open Link',
          iconName: Icons.open_in_browser,
        )
      ],
    );
  }
}
