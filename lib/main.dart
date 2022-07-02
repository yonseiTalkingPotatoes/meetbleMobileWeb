import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meetble/view/screens/home_screen.dart';

import 'meetble_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        splitScreenMode: false,
        designSize: const Size(320, 568),
    builder: (context, _) => MaterialApp(
    builder: (context, child) => MediaQuery(
    data: MediaQuery.of(context).copyWith(
    textScaleFactor: 1.0,
    ),
    child: child!,
    ),
    debugShowCheckedModeBanner: false,
    title: 'Meetble',
    theme: MeetbleStyle(MediaQueryData()).meetbleThemeData,
    home: HomeScreen(),
    )
    );
  }
}