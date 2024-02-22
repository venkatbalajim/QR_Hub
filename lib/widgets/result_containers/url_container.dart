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
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(link!,
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
          buttonName: 'Open Link',
          iconName: Icons.open_in_browser,
        )
      ],
    );
  }
}
