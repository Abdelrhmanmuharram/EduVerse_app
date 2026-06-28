import 'package:edusync_app/feature/students/attendance/widgets/scanner_border_painter.dart';
import 'package:flutter/material.dart';

class ScannerOverlay extends StatelessWidget {
  final bool isSuccess;
  const ScannerOverlay({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(.65),
              BlendMode.srcOut,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: 260,
              height: 260,
              child: CustomPaint(
                painter: ScannerBorderPainter(isSuccess: isSuccess),
              ),
            ),
          ),

          Positioned(
            bottom: 140,
            left: 0,
            right: 0,
            child: Column(
              children: const [
                Text(
                  "Scan Attendance QR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Place the QR code inside the frame",
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
