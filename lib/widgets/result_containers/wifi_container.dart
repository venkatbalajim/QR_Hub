import '../../utils/imports.dart';

// Widget to display Wifi details
class WifiWidget extends StatelessWidget {
  final String name;
  final String? password;
  final String? encryption;
  final BarcodeType type;
  const WifiWidget({super.key, 
    required this.name, this.password, 
    this.encryption, required this.type
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
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("SSID: $name", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 5),
                Text("Password: $password", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 5),
                Text("Encryption: $encryption", style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        WifiIconButton(
          onPressed: () async {
            AppSettings.openAppSettings(type: AppSettingsType.wifi);
          },
        ),
      ],
    );
  }
}
