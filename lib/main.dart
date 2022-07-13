import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meetble/view/screens/create_screens/create_screen00.dart';
import 'package:meetble/view/screens/create_screens/create_screen01.dart';
import 'package:meetble/view/screens/create_screens/create_screen02.dart';
import 'package:meetble/view/screens/home_screen.dart';
import 'package:meetble/view_model/create_screens_view_model.dart';
import 'package:provider/provider.dart';

import 'meetble_style.dart';

void main() {
  print("Start");
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=> CreateScreensViewModel(),),
        ],
        child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("MyApp");
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
          //home: HomeScreen(),
          home: CreateScreen02(),
        )
    );
  }
}