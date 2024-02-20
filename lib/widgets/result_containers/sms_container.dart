import '../../utils/imports.dart';

class SMSWidget extends StatelessWidget {

  final String? phoneNumber;
  final String? message;
  final BarcodeType type;

  const SMSWidget({super.key, this.phoneNumber, this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    debugPrint("$phoneNumber, $message");
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(phoneNumber!, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text(message!, style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SmsIconButton(
              onPressed: () async {
                Uri url = Uri.parse('sms:$phoneNumber?body=$message');           
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              }
            ),
            const SizedBox(width: 30,),
            if (phoneNumber != null)
            PhoneIconButton(onPressed: () async {
              if (phoneNumber != null) {
                Uri? url = Uri(path: phoneNumber, scheme: 'tel');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              }
            }),
            const SizedBox(width: 30,),
            if (phoneNumber != null)
            ContactInfoIconButton(onPressed: () async {
              ContactHandler contactHandler = ContactHandler();
              await contactHandler.openCreateContactMethod(
                null, null, null, null, null, phoneNumber, null
              );
            })
          ],
        )
      ],
    );
  }
}
