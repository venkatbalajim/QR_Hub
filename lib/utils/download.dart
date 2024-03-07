// ignore_for_file: avoid_print, use_build_context_synchronously

import 'imports.dart';

Future<void> downloadQRCode(
  ScreenshotController screenshotController,
  BuildContext context
) async {

  final mobileAndroidInfo = await DeviceInfoPlugin().androidInfo;
  int? androidVersion = int.tryParse(mobileAndroidInfo.version.release);
  Permission storagePermission = Permission.storage;
  if (androidVersion != null && androidVersion > 12) {
    storagePermission = Permission.manageExternalStorage;
  }

  try {
    await Future.delayed(const Duration(seconds: 1));
    Uint8List? image = await screenshotController.capture();

    if (image != null) {
      if (await storagePermission.isGranted) {
        String downloadDir = (await DownloadsPath.downloadsDirectory())!.path;
        String appFolderName = "QR Hub";
        String downloadFolder = "QR Codes";
        String fileName = DateFormat('yyyyMMddTHHmmss').format(DateTime.now());
        Directory directory = Directory('$downloadDir/$appFolderName/$downloadFolder');
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
        }
        String filePath =  "${directory.path}/$fileName.jpg";
        await File(filePath).writeAsBytes(image)
          .then((value) => SnackBarWidget(context, 'File downloaded successfully.\nFile directory: Download/QR Hub/QR Codes'));
      } else if (await storagePermission.isDenied) {
        await storagePermission.request();
        if (await storagePermission.isGranted) {
          SnackBarWidget(context, 'Permission granted. Click the download button again.');
        }
      } else if (await storagePermission.isPermanentlyDenied) {
        SnackBarWidget(context, 'Storage Permission Denied. So, unable to download the history.');
      }
    } else {
      SnackBarWidget(context, 'Sorry, cannot able to fetch QR code image.');
    }
  } catch (e) {
    print(e.toString());
    SnackBarWidget(context, 'Sorry, unable to download QR Code.');
  }
}

Future<void> downloadHistory(BuildContext context, List<QRCodeData> historyList) async {

  final mobileAndroidInfo = await DeviceInfoPlugin().androidInfo;
  int? androidVersion = int.tryParse(mobileAndroidInfo.version.release);
  Permission storagePermission = Permission.storage;
  if (androidVersion != null && androidVersion > 12) {
    storagePermission = Permission.manageExternalStorage;
  }
  
  if (await storagePermission.isGranted) {
    String downloadDir = (await DownloadsPath.downloadsDirectory())!.path;
    print(downloadDir);
    try {
      StringBuffer fileContent = StringBuffer();
      for (var data in historyList) {
        fileContent.writeln('Date: ${data.scannedDate}');
        fileContent.writeln('Time: ${data.scannedTime}');
        fileContent.writeln(data.qrCodeData);
        fileContent.writeln('\n');
      }
      String appFolderName = "QR Hub";
      Directory directory = Directory('$downloadDir/$appFolderName/History');
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      String fileName = DateFormat('yyyyMMddTHHmmss').format(DateTime.now());
      String filePath =  "${directory.path}/$fileName.txt";
      print(filePath);
      await File(filePath).writeAsString(fileContent.toString())
        .then((value) => SnackBarWidget(context, 'File downloaded successfully.\nFile directory: Download/QR Hub/History'));
    } catch (e) {
      print(e.toString());
      SnackBarWidget(context, 'Sorry, unable to download history.');
    }
  } else if (await storagePermission.isDenied) {
    await storagePermission.request();
    if (await storagePermission.isGranted) {
      SnackBarWidget(context, 'Permission granted. Click the download button again.');
    }
  } else if (await storagePermission.isPermanentlyDenied) {
    SnackBarWidget(context, 'Storage Permission Denied. So, unable to download the history.');
  }
}
