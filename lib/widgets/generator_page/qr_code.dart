import '../../utils/imports.dart';

class GeneratedQRCode extends StatelessWidget {
  final String qrData;
  const GeneratedQRCode({super.key, required this.qrData});

  @override
  build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: QrImageView(
        data: qrData,
        gapless: false,
        size: 200,
        version: QrVersions.auto,
      ),
    );
  }
}
