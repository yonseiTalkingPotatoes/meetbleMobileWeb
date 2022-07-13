import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  final double radius;
  final double radiusRatio;
  final Color backgroundStrokeColor;
  final double backgroundStrokeWidth;

  BackgroundPainter({
    required this.radius,
    required this.radiusRatio,
    this.backgroundStrokeColor = const Color(0xFF000000),
    this.backgroundStrokeWidth = 0.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final outBorder = Paint()
      ..color = backgroundStrokeColor
      ..strokeWidth = backgroundStrokeWidth
      ..style = PaintingStyle.stroke; //important set stroke style

    canvas.translate(radius, radius);
    canvas.drawCircle(Offset(0, 0), radius, outBorder);
    canvas.drawCircle(Offset(0, 0), radius * radiusRatio, outBorder);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}