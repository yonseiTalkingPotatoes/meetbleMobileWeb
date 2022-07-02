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
      backgroundColor: Color(0xFFFFFFFF),
      splashColor: Color(0xFFF7CA59),
      scaffoldBackgroundColor: Color(0xFFF7CA59),
      brightness: Brightness.light,
      textTheme: TextTheme(
        /// Start Screen Text
        headlineLarge: TextStyle(
            fontFamily: "Nunito",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w900,
            fontSize: 32,
            color: Color(0xFF000000),
            overflow: TextOverflow.ellipsis,
        ),
        /// Text Button
        /// ex) '서비스 문의하기'
        headlineSmall: TextStyle(
            fontFamily: "Nunito",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: Color(0xFF5C5C5C),
            overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}