import 'package:flutter/material.dart';

class ScannerBorderPainter extends CustomPainter {
  final bool isSuccess;
  ScannerBorderPainter({required this.isSuccess});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isSuccess ? Colors.green : const Color(0xff2962FF)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const r = 30.0;
    canvas.drawLine(const Offset(0, r), const Offset(0, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(r, 0), paint);

    canvas.drawLine(Offset(size.width - r, 0), Offset(size.width, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, r), paint);
    canvas.drawLine(Offset(0, size.height - r), Offset(0, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(r, size.height), paint);
    canvas.drawLine(
      Offset(size.width - r, size.height),
      Offset(size.width, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(size.width, size.height - r),
      Offset(size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
