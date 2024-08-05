import 'package:flutter/material.dart';
// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:camera/camera.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../constant/constant.dart';

void main() {
  runApp(QRCodeApp());
}

class QRCodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QRCodePage(),
    );
  }
}

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  CameraController? _controller;
  late List<CameraDescription> cameras;
  int _cameraIndex = 0;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller =
        CameraController(cameras[_cameraIndex], ResolutionPreset.high);
    await _controller!.initialize();
    setState(() {});
  }

  // Future<void> _scanBarcode() async {
  //   try {
  //     final result = await BarcodeScanner.scan();
  //     if (result.type == ResultType.Barcode) {
  //       print("Scanned data: ${result.rawContent}");
  //     }
  //   } catch (e) {
  //     print("Error scanning barcode: $e");
  //   }
  // }

  Future<void> _toggleCamera() async {
    if (_controller != null) {
      await _controller!.dispose();
    }
    _cameraIndex = (_cameraIndex + 1) % cameras.length;
    _initializeCamera();
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
      _controller?.setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () {
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => StartPage(),
        //     ),
        //     (route) => false);
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('QR Code Scanner'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
          ),
        ),
        // body: Stack(
        //   children: [
        //     CameraPreview(_controller!),
        //     Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             ElevatedButton(
        //               onPressed: () {},
        //               child: Text('Scan QR Code'),
        //             ),
        //             SizedBox(height: 16),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 IconButton(
        //                   onPressed: _toggleCamera,
        //                   icon: Icon(Icons.switch_camera),
        //                 ),
        //                 IconButton(
        //                   onPressed: _toggleFlash,
        //                   icon:
        //                       Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        body: MobileScanner(onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;

          for (var barcode in barcodes) {
            Constant.value_path = barcode.rawValue!;
          }

          // for (var i = 1; i < 10; i++) {
          //   print('ini $i');
          // }

          print('SCANNINGGGG');
          if (Constant.value_path != '') {
            Navigator.pushReplacementNamed(context, Constant.value_path);
          }
        }),
      ),
    );
  }
}
