// ignore_for_file: avoid_print

import '../../utils/imports.dart';

class GeneratedQRCode extends StatelessWidget {
  final dynamic qrData;
  const GeneratedQRCode({super.key, required this.qrData});

  @override
  build(BuildContext context) {
    print('Data in the QR Code is $qrData');
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
