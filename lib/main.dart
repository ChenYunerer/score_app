import 'package:flutter/material.dart';
import 'package:score_app/config/color_config.dart';
import 'package:score_app/page/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '搜谱',
      theme: ThemeData(
        primaryColor: ColorConfig.main_theme,
        backgroundColor: ColorConfig.background,
        accentColor: ColorConfig.gray,
        textTheme: TextTheme(
          body1: TextStyle(color: ColorConfig.textDefault, fontSize: 16.0),
        ),
        iconTheme: IconThemeData(
          color: ColorConfig.main_theme,
          size: 35.0,
        ),
      ),
      home: SplashPage(),
    );
  }
}
