import 'package:flutter/material.dart';
import 'package:front_end/foundation/theme/colors.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'feature/landing_page/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "FlutterGardeo",
      theme: ThemeData(
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 14.5,
            letterSpacing: 0.15,
          color: AppColor.heading6,

            bodyText1: TextStyle(
            color: AppColor. bodyColor1,fontSize: 14,),
          ),
          caption: TextStyle(fontSize: 11,color: AppColor.CaptionColor),
        ),
      ),

      home: LandingPage(),
    );
  }
}