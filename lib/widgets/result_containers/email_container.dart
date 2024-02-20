import '../../utils/imports.dart';

class EmailWidget extends StatelessWidget {

  final BarcodeType type;
  final String? email;
  final String? emailType;
  final String? subject;
  final String? body;

  const EmailWidget({
    super.key, this.email, this.emailType, 
    this.subject, this.body, required this.type
  });

  @override
  Widget build(BuildContext context) {
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
                Text(email!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(subject!, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 5),
                Text(body!, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        if (email != null)
        EmailIconButton(
          onPressed: () async {
            Uri url = Uri.parse(
              'mailto:$email?subject=$subject&body=$body'
            );            
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              throw 'Could not launch $url';
            }
          }
        )
      ],
    );
  }
}
