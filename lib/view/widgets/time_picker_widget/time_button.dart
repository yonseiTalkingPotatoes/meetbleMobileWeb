import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeButton extends StatelessWidget {
  final bool isSelected;
  final String buttonText;
  final GestureTapCallback onTap;
  const TimeButton({Key? key, required this.isSelected, required this.buttonText, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Container(
          height: 22,
          padding: EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF9ACBF8) : Color(0xFFE5E5E5).withOpacity(0.45),
            borderRadius: BorderRadius.circular(61),
            border: Border.all(
              width: 1,
              color: isSelected ? Color(0xFF9ACBF8) : Color(0xFF000000).withOpacity(0.45),
            )
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: isSelected ? Color(0xFF1563D7) : Color(0xFF000000).withOpacity(0.45)
            ),
          ),
        ),
      ),
    );
  }
}
