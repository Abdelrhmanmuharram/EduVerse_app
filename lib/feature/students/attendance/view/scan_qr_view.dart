import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../widgets/scanner_overlay.dart';

class ScanQrView extends StatefulWidget {
  static const routeName = '/scan-qr';

  const ScanQrView({super.key});

  @override
  State<ScanQrView> createState() => _ScanQrViewState();
}

class _ScanQrViewState extends State<ScanQrView> {
  final controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: false,
  );
  bool scanned = false;
  bool isSuccess = false;
  bool isProcessing = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const scanSize = 260.0;
    final scanWindow = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanSize,
      height: scanSize,
    );
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            fit: BoxFit.cover,
            scanWindow: scanWindow,
            onDetect: (capture) async {
              if (scanned) return;
              final value = capture.barcodes.first.rawValue;
              if (value == null) return;
              print('HERE====> $value');
              scanned = true;

              setState(() {
                isSuccess = true;
              });
              controller.stop();
              await Future.delayed(const Duration(milliseconds: 700));
              if (!mounted) return;
              Navigator.pop(context, value);
            },
          ),
          ScannerOverlay(isSuccess: isSuccess),
          AnimatedOpacity(
            opacity: isSuccess ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.95),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 70),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
