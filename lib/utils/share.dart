// ignore_for_file: avoid_print

import 'imports.dart';

void shareContent(Barcode value) async {
  final shareText = fetchData(value);
  await Share.share(shareText);
}

void shareQRImage(ScreenshotController controller,  BuildContext context) async {
  final image = await controller.capture();
  if (image != null) {
    final directory = await getApplicationDocumentsDirectory();
    print("File directory is $directory");
    String fileName = DateFormat('yyyyMMddTHHmmss').format(DateTime.now());
    final imagePath = await File('${directory.path}/$fileName.png').create();
    await imagePath.writeAsBytes(image);
    // ignore: deprecated_member_use
    await Share.shareFiles([imagePath.path], text: 'Check this QR Code ...');
  }
}

void shareApp() {
  Share.share(
    subject: 'QR Hub App',
    'QR Hub - Steps to download:\n\n'
    '1. Click the link and go to the releases page of the GitHub repository.\n'
    '2. Check out the assets of the latest version of the app.\n'
    '3. Click the APK file in the assets and download the app.\n\n'
    'Link: https://github.com/venkatbalajim/QR_Hub/releases/latest',
  );
}
