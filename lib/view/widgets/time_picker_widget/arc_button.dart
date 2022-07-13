import 'package:flutter/material.dart';
import 'package:meetble/view/widgets/time_picker_widget/painter/arc_clipper.dart';

class ArcButton extends StatelessWidget {
  final bool isSelected;
  final int time;
  final Color selectedColor;
  final Color defaultColor;
  final double radius;
  final int startPoint;
  final GestureTapCallback onTap;


  const ArcButton({
    Key? key,
    required this.isSelected,
    required this.time,
    this.defaultColor = const Color(0xFFF1F1F1),
    this.selectedColor = const Color(0xFF9ACBF8),
    required this.radius,
    this.startPoint = 0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ArcClipper(
          time: time,
          radius: radius,
          startPoint: startPoint,
          isSelected: isSelected,
      ),
      child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                color: isSelected ? selectedColor : defaultColor,
            ),
          )
      ),
    );
  }
}