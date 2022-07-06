import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeetbleStyle {
  final MediaQueryData mediaQueryData;
  late final ThemeData _meetbleThemeData;

  get meetbleThemeData => _meetbleThemeData;

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