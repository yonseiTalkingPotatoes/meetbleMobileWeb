import 'package:flutter/material.dart';
import 'dart:math' as math;

class ArcPainter extends CustomPainter {
  final double radius;
  final double radiusRatio;
  final bool isSelected;
  final int time;
  final TextStyle offTimeTextStyle;
  final TextStyle onTimeTextStyle;
  final Color selectedInsideBorderColor;
  final Color defaultInsideBorderColor;
  final double borderWidth;
  final double textPadding;

   ArcPainter({
    required this.time,
    required this.isSelected,
    required this.radius,
    required this.radiusRatio,
    this.offTimeTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      color: Color(0xFF000000),
      fontSize: 8,
    ),
    this.onTimeTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      color: Color(0xFF000000),
      fontSize: 8,
    ),
    this.borderWidth = 0.7,
    this.selectedInsideBorderColor = const Color(0xFF000000),
    this.defaultInsideBorderColor = const Color(0xFFC4C4C4),
    required this.textPadding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double pieRatio = 15 * math.pi / 180;

    final border = Paint()
      ..color = defaultInsideBorderColor
      //..color = isSelected ? selectedInsideBorderColor : defaultInsideBorderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke; //important set stroke style


    canvas.translate(radius, radius);
    final _path = Path()
      ..moveTo(- radius * radiusRatio * math.cos(time * pieRatio),  - radius * radiusRatio * math.sin(time * pieRatio))
      ..arcToPoint(Offset( - radius * radiusRatio * math.cos((time+1) * pieRatio),  - radius * radiusRatio * math.sin((time+1) * pieRatio)),
          radius: Radius.circular(radius * radiusRatio))
      ..lineTo( - radius * math.cos((time+1) * pieRatio),  - radius * math.sin((time+1) * pieRatio))
      ..arcToPoint(Offset( - radius * math.cos(time * pieRatio),  - radius * math.sin(time * pieRatio)),
          radius: Radius.circular(radius), clockwise: false)
      ..lineTo( - radius * radiusRatio * math.cos(time * pieRatio),  - radius * radiusRatio * math.sin(time * pieRatio));
    canvas.drawPath(_path, border);

    if(time != 5 && time != 11 && time != 17 && time != 23) {
      final textSpan = TextSpan(
        text: (time + 1).toString(),
        style: isSelected ? onTimeTextStyle : offTimeTextStyle,
      );

      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      double extraRadius = time < 9 ? 0.85 : 0.7;
      double extraRotate = time < 9 ? 5 : 5.5;
      if(textPadding < radius) {
        canvas.translate( - (radius - textPadding) * math.cos((time + extraRadius) * pieRatio),  - (radius - textPadding) * math.sin((time + extraRadius) * pieRatio));
      }
      else {
        canvas.translate( - radius * math.cos((time + extraRadius) * pieRatio),  - radius * math.sin((time + extraRadius) * pieRatio));

      }
      canvas.rotate((time - extraRotate) * pieRatio);
      textPainter.paint(canvas, Offset(0,0));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}