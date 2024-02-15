// ignore_for_file: avoid_print

import '../utils/imports.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {

  MobileScannerController cameraController = MobileScannerController();
  bool screenOpened = false;
  double zoom = 0.0;

  @override
  void initState() {
    super.initState();
    screenClosed();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    final pickedFile = await ImagePicker()
                    .pickImage(source: ImageSource.gallery);
                    final imagePath = pickedFile?.path;
                    if (imagePath != null) {
                      cameraController.analyzeImage(imagePath);
                    }
                  }, 
                  icon: const Icon(
                    Icons.image_outlined,
                  )
                ),
                const SizedBox(width: 20,),
                IconButton(
                  onPressed: () {
                    cameraController.toggleTorch();
                  }, 
                  icon: const Icon(
                    Icons.flash_on_rounded,
                  )
                ),
                const SizedBox(width: 20,),
                IconButton(
                  onPressed: () {
                    cameraController.switchCamera();
                  }, 
                  icon: const Icon(
                    Icons.flip_camera_android,
                  )
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              MobileScanner(
                controller: cameraController,
                onDetect: foundBarcode,
              ),
              QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.6),),
            ],
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    zoom = zoomOut(zoom);
                  });
                  cameraController.setZoomScale(zoomOut(zoom));
                },
                icon: const Icon(Icons.zoom_out, size: 30, color: Colors.white),
              ),
              const SizedBox(height: 16),
              IconButton(
                onPressed: () {
                  setState(() {
                    zoom = zoomIn(zoom);
                  });
                  cameraController.setZoomScale(zoomIn(zoom));
                },
                icon: const Icon(Icons.zoom_in, size: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ), 
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.isFirst);
        return true;
      }
    );
  }

  void foundBarcode(BarcodeCapture barcode) {
    print(barcode);
    if (!screenOpened) {
      final BarcodeCapture code = barcode;
      screenOpened = true;
      ValueNotifier<TorchState> torchStatus = cameraController.torchState;
      if (torchStatus.value == TorchState.on) cameraController.toggleTorch();
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=> ResultPage(value: code, screenClose: screenClosed)
        )).then((value) => print(value));
    }
  }

  void screenClosed() {
    screenOpened = false;
  }

  double zoomOut(double zoom) {
    if (zoom > 0.0) zoom -= 0.1;
    return zoom;
  }

  double zoomIn(double zoom) {
    if (zoom < 1.0) zoom += 0.1;
    return zoom;
  }

}
