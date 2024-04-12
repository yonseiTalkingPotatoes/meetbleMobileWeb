import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meetble/view/screens/home_screen.dart';
import 'package:meetble/view_model/create_screens_view_model.dart';
import 'package:meetble/view_model/join_screens_view_model.dart';
import 'package:meetble/view_model/result_screen_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'fluro_router.dart';
import 'meetble_style.dart';

void main() {
  setPathUrlStrategy();
  FRouter.setupRouter();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => CreateScreensViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => JoinScreensViewModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => ResultScreenViewModel(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        theme: MeetbleStyle(const MediaQueryData()).meetbleThemeData,
        initialRoute: '/',
        onGenerateRoute: FRouter.router.generator,
        routes: {
          '/': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
