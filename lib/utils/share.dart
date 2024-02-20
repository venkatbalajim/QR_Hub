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
