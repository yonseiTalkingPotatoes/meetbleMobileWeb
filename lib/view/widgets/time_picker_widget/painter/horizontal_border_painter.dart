import 'package:flutter/material.dart';

class HorizontalBorderPainter extends CustomPainter {
  final double radius;
  final bool isAmSelected;
  final bool isPmSelected;
  final TextStyle offHorizontalBorderTimeTextStyle;
  final TextStyle onHorizontalBorderTimeTextStyle;
  final Color horizontalBorderColor;
  final double horizontalBorderWidth;
  final double textPadding;

  HorizontalBorderPainter({
    required this.isAmSelected,
    required this.isPmSelected,
    required this.radius,
    this.offHorizontalBorderTimeTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      color: Color(0xFF000000),
      fontSize: 8,
    ),
    this.onHorizontalBorderTimeTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      color: Color(0xFF000000),
      fontSize: 8,
    ),
    this.horizontalBorderColor = const Color(0xFF868686),
    this.horizontalBorderWidth = 1,
    required this.textPadding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final border = Paint()
      ..color = horizontalBorderColor
      ..strokeWidth = horizontalBorderWidth
      ..style = PaintingStyle.stroke; //important set stroke style

    canvas.translate(radius, radius);
    final _path = Path()
      ..moveTo(-radius, 0)
      ..lineTo(radius, 0);
    canvas.drawPath(_path, border);

    final amTextSpan = TextSpan(
      text: "12 AM",
      style: isAmSelected
          ? onHorizontalBorderTimeTextStyle
          : offHorizontalBorderTimeTextStyle,
    );

    final pmTextSpan = TextSpan(
      text: "12 PM",
      style: isPmSelected
          ? onHorizontalBorderTimeTextStyle
          : offHorizontalBorderTimeTextStyle,
    );

    final amTextPainter = TextPainter(
      text: amTextSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    amTextPainter.layout();
    amTextPainter.paint(canvas, Offset(-radius + textPadding, 0));

    final pmTextPainter = TextPainter(
      text: pmTextSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    pmTextPainter.layout();
    pmTextPainter.paint(canvas, Offset(radius - 24 - textPadding, -12));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
