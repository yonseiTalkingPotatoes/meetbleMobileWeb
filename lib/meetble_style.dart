import 'package:flutter/material.dart';

const List<Color> statusColor = [
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

  final TextStyle _activeCalanderTextStyle = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Color(0xFF000000),
  );

  final TextStyle _defaultCalanderTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF000000).withOpacity(0.3),
  );

  final TextStyle _weekdayCalanderTextStyle = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: Color(0xFF000000),
  );

  final TextStyle _weekendCalanderTextStyle = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: Color(0xFF000000),
  );

  MeetbleStyle(this.mediaQueryData) {
    // Design based on 375 X 667 : Iphone 8
    _meetbleThemeData = ThemeData(
      fontFamily: 'Nunito',
      primaryColor: const Color(0xFFF7CA59),
      splashColor: const Color(0xFFF7CA59),
      scaffoldBackgroundColor: const Color(0xFFF7CA59),
      brightness: Brightness.light,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: "Inter",
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          fontSize: 23,
          color: Color(0xFF000000),
          overflow: TextOverflow.ellipsis,
        ),
        bodyLarge: TextStyle(
          fontFamily: "Inter",
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Color(0xFF000000),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      colorScheme: const ColorScheme.light(
        background: Colors.white,
      ),
    );
  }
}
