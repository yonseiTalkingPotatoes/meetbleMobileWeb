import 'package:flutter/material.dart';
import 'package:meetble/view/widgets/time_picker_widget/painter/arc_clipper.dart';
import '../../../data/model/user_schedule_model.dart';
import '../../../meetble_style.dart';

class ArcButton extends StatelessWidget {
  final bool isSelected;
  final List<TimeStatusModel>? timeStatusList;
  final int time;
  final Color selectedColor;
  final Color defaultColor;
  final double radius;
  final int startPoint;
  final GestureTapCallback onTap;

  const ArcButton({
    Key? key,
    required this.isSelected,
    this.timeStatusList,
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
            color: !isSelected
                ? defaultColor
                : timeStatusList == null
                    ? selectedColor
                    : statusColor[timeStatusList!
                        .firstWhere((timeStatus) => timeStatus.time == time)
                        .statusCode],
          ),
        ),
      ),
    );
  }
}
