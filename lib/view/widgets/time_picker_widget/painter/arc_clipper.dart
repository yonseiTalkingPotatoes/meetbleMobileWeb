import 'package:flutter/material.dart';
import 'dart:math' as math;

class ArcClipper extends CustomClipper<Path>{
  final int time;
  final double radius;
  final double radiusRatio;
  final int startPoint;
  final bool isSelected;

   ArcClipper({
    required this.time,
    required this.radius,
    this.radiusRatio = 2/3,
    required this.startPoint,
    required this.isSelected,
  });


  @override
  Path getClip(Size size){
    final double startAngle = math.pi / 2 * startPoint;
    const double angleRatio= 1/24;

    Offset center = Offset(radius, radius);
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    Path path = Path()
    // set the "current point"
      ..moveTo(center.dx, center.dy)
      ..arcTo(rect, startAngle + (math.pi * 2) * angleRatio * time, (math.pi * 2) * angleRatio, false);
    return path;
  }

  @override
  bool shouldReclip(oldCliper) => false;
}