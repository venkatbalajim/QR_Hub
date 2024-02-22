import '../../utils/imports.dart';

// Widget to display Phone Numbers
class PhoneWidget extends StatelessWidget {
  final String? link;
  final BarcodeType type;
  const PhoneWidget({super.key, this.link, required this.type});
  @override
  Widget build(BuildContext context) {
    Uri? url;
    if (link != null) {
      try {
        url = Uri(path: link, scheme: 'tel');
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (link != null)
            CustomIconButton(
              onPressed: () async {
                if (url != null && await canLaunchUrl(url)) {
                  await launchUrl(url);
                } 
              }, 
              buttonName: 'Call',
              iconName: Icons.phone,
            ),
            const SizedBox(width: 30,),
            if (link != null)
            CustomIconButton(
              onPressed: () async {
                ContactHandler contactHandler = ContactHandler();
                await contactHandler.openCreateContactMethod(
                  null, null, null, null, null, link, null
                );
              },
              buttonName: 'Add Contact',
              iconName: Icons.person_add_alt_1,
            )
          ],
        ),
      ]
    );
  }
}
