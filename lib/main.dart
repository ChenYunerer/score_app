import 'package:flutter/material.dart';
import 'package:score_app/config/color_config.dart';
import 'package:score_app/page/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: ColorConfig.red,
        backgroundColor: ColorConfig.background,
        accentColor: ColorConfig.gray,
        textTheme: TextTheme(
          body1: TextStyle(color: ColorConfig.textDefault, fontSize: 16.0),
        ),
        iconTheme: IconThemeData(
          color: ColorConfig.red,
          size: 35.0,
        ),
      ),
      home: SplashPage(),
    );
  }
}
