// ignore_for_file: avoid_print, use_build_context_synchronously

import 'imports.dart';

Future<void> downloadQRCode(
  ScreenshotController screenshotController,
  BuildContext context
) async {
  try {
    await Future.delayed(const Duration(seconds: 1));
    Uint8List? image = await screenshotController.capture();

    if (image != null) {
      String dateTime = DateFormat('yyyyMMddTHHmmss').format(DateTime.now());
      final result = await ImageGallerySaver.saveImage(
        image, name: 'QR_Code_$dateTime',
      );

      if (result != null && result['isSuccess']) {
        SnackBarWidget(context, 'QR Code saved successfully');
      } else {
        SnackBarWidget(context, 'Failed to save QR Code image');
      }
    } else {
      SnackBarWidget(context, 'Failed to capture the QR Code');
    }
  } catch (e) {
    print(e.toString());
    SnackBarWidget(context, 'Sorry, something went wrong.');
  }
}
