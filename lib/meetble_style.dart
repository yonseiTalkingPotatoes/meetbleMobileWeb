import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const List<Color> STATUS_COLOR = [
  Color(0xFF9ACBF8),
  Color(0xFFFFDA7C),
  Color(0xFFFF9494),
];

class MeetbleStyle {
  final MediaQueryData mediaQueryData;
  late final ThemeData _meetbleThemeData;

  get meetbleThemeData => _meetbleThemeData;
  get activeCalanderTextStyle => _activeCalanderTextStyle;
  get defaultCalanderTextStyle => _defaultCalanderTextStyle;
  get weekdayCalanderTextStyle => _weekdayCalanderTextStyle;
  get weekendCalanderTextStyle => _weekendCalanderTextStyle;

  TextStyle _activeCalanderTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Color(0xFF000000),
  );

  TextStyle _defaultCalanderTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Color(0xFF000000).withOpacity(0.3),
  );

  TextStyle _weekdayCalanderTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: Color(0xFF000000),
  );

  TextStyle _weekendCalanderTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: Color(0xFF000000),
  );

  MeetbleStyle(this.mediaQueryData){
    // Design based on 375 X 667 : Iphone 8
    _meetbleThemeData = ThemeData(
      fontFamily: 'Nunito',
      primaryColor: Color(0xFFF7CA59),
      backgroundColor: Color(0xFFFFFFFF),
      splashColor: Color(0xFFF7CA59),
      scaffoldBackgroundColor: Color(0xFFF7CA59),
      brightness: Brightness.light,
      textTheme: TextTheme(
        /// Start Screen Text
        headlineLarge: TextStyle(
            fontFamily: "Inter",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontSize: 23,
            color: Color(0xFF000000),
            overflow: TextOverflow.ellipsis,
        ),
        bodyText1: TextStyle(
          fontFamily: "Inter",
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Color(0xFF000000),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}