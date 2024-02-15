import '../../utils/imports.dart';

// Widget to display Phone Numbers
class PhoneWidget extends StatelessWidget {
  final String? link;
  final BarcodeType type;
  const PhoneWidget({Key? key, this.link, required this.type}) : super(key: key);
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PhoneIconButton(
              onPressed: () async {
                if (url != null && await canLaunchUrl(url)) {
                  await launchUrl(url);
                } 
              }
            ),
            const SizedBox(width: 30,),
            ContactInfoIconButton(onPressed: () async {
              ContactHandler contactHandler = ContactHandler();
              await contactHandler.openCreateContactMethod(
                null, null, null, null, null, link, null
              );
            })
          ],
        ),
      ]
    );
  }
}
