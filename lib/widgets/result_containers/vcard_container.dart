// ignore_for_file: avoid_print

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
    super.key,
    this.name,
    this.title,
    this.organization,
    this.emails,
    this.addresses,
    this.phones,
    this.urls,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    print("$name, $title, $organization, $emails, $addresses, $phones, $urls");
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
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
              const Text('Title:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              Text(
                title ?? '',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text('Organization:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              Text(
                organization ?? '',
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
            if (phones != null && phones!.isNotEmpty)
            CustomIconButton(
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
              buttonName: 'Add Contact',
              iconName: Icons.person_add_alt_1,
            ),
            const SizedBox(width: 30,),
            if (phones != null && phones!.isNotEmpty)
            CustomIconButton(
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
              },
              buttonName: 'Call',
              iconName: Icons.phone,
            ),
            const SizedBox(width: 30,),
            if (addresses != null && addresses!.isNotEmpty)
            CustomIconButton(
              onPressed: () async {
                final mapUrl = Uri.parse(
                  'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(addresses!.first.addressLines.first)}'
                );
                if (await canLaunchUrl(mapUrl)) {
                  await launchUrl(mapUrl);
                } 
              },
              buttonName: 'Show Map',
              iconName: Icons.location_on_rounded,
            ),
          ],
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (urls != null && urls!.isNotEmpty)
            CustomIconButton(
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
              buttonName: 'Open Link',
              iconName: Icons.open_in_browser,
            ),
            const SizedBox(width: 30,),
            if (emails != null && emails!.isNotEmpty)
            CustomIconButton(
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
              },
              buttonName: 'Send Email',
              iconName: Icons.email_outlined,
            ),
            const SizedBox(width: 30,),
            if (phones != null && phones!.isNotEmpty)
            CustomIconButton(
              onPressed: () async {
                String? phone = phones?.first.number;
                Uri url = Uri.parse('sms:$phone');           
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              buttonName: 'Send SMS',
              iconName: Icons.sms,
            ),
          ],
        ),
      ],
    );
  }
}
