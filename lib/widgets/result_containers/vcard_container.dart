import '../../utils/imports.dart';

// Widget to display vCard details 
class VCardWidget extends StatelessWidget {
  final BarcodeType type;
  final String? name;
  final String? title;
  final String? organization;
  final List<Email>? emails;
  final List<Address>? addresses;
  final List<Phone>? phones;
  final List<String>? urls;

  const VCardWidget({
    Key? key,
    this.name,
    this.title,
    this.organization,
    this.emails,
    this.addresses,
    this.phones,
    this.urls,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(13, 71, 161, 1),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name ?? '',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Title: $title",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "Organization: $organization",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              if (emails != null && emails!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Emails:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: emails!.length,
                      itemBuilder: (context, index) {
                        return Text(emails![index].address ?? '');
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              if (addresses != null && addresses!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Addresses:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: addresses!.length,
                      itemBuilder: (context, index) {
                        String addressString = addresses![index].addressLines.join(', ');
                        return Text(addressString);
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              if (phones != null && phones!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phones:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: phones!.length,
                      itemBuilder: (context, index) {
                        return Text(phones![index].number ?? '');
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 16,),
              if (urls != null && urls!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Websites:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: urls!.length,
                      itemBuilder: (context, index) {
                        return Text(urls![index]);
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ContactInfoIconButton(
              onPressed: () async {
                ContactHandler contactHandler = ContactHandler();
                await contactHandler.openCreateContactMethod(
                  name,
                  title,
                  organization,
                  emails?.isNotEmpty == true ? emails![0].address : null,
                  addresses?.isNotEmpty == true ? addresses![0].addressLines.join(', ') : null,
                  phones?.isNotEmpty == true ? phones![0].number : null,
                  urls?.isNotEmpty == true ? urls![0] : null,
                );
              },
            ),
            const SizedBox(width: 30,),
            PhoneIconButton(
              onPressed: () async {
                Uri? url;
                if (phones?.first.number != null) {
                  try {
                    url = Uri(path: phones?.first.number, scheme: 'tel');
                  // ignore: empty_catches
                  } catch (e) {}
                }
                if (url != null && await canLaunchUrl(url)) {
                  await launchUrl(url);
                } 
              }
            ),
            const SizedBox(width: 30,),
            GeoIconButton(
              onPressed: () async {
                final mapUrl = Uri.parse(
                  'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(addresses!.first.addressLines.first)}'
                );
                if (await canLaunchUrl(mapUrl)) {
                  await launchUrl(mapUrl);
                } 
              }
            ),
          ],
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UrlIconButton(
              onPressed: () async {
                Uri? url;
                if (urls?.first != null) {
                  try {
                    String? link = urls?.first;
                    url = Uri.parse("https://$link");
                  // ignore: empty_catches
                  } catch (e) {}
                }
                if (url != null && await canLaunchUrl(url)) {
                  await launchUrl(url);
                } 
              },
            ),
            const SizedBox(width: 30,),
            EmailIconButton(
              onPressed: () async {
                String email = emails!.first.address ?? '';
                Uri url = Uri.parse(
                  'mailto:$email'
                );            
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              }
            ),
            const SizedBox(width: 30,),
            SmsIconButton(
              onPressed: () async {
                String? phone = phones?.first.number;
                Uri url = Uri.parse('sms:$phone');           
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              }
            ),
          ],
        ),
      ],
    );
  }
}
