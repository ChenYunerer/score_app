import 'dart:async';

import 'package:flutter/material.dart';
import 'package:score_app/config/color_config.dart';
import 'package:score_app/page/main_page.dart';

var poetryTitle = "月夜听卢子顺弹琴";
var poetryLine1 = "闲夜坐明月，幽人弹素琴。";
var poetryLine2 = "忽闻悲风调，宛若寒松吟。";
var poetryLine3 = "白雪乱纤手，绿水清虚心。";
var poetryLine4 = "钟期久已没，世上无知音。";
var devInfo = "搜谱 v3 developed by yuner.fun";

///启动页
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _go2MainPage(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: buildPoetryWidget(),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Text(
                devInfo,
                style: TextStyle(fontSize: 13, color: ColorConfig.textBlack),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///中间的诗词
  Widget buildPoetryWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          poetryTitle,
          style: TextStyle(fontSize: 22, color: ColorConfig.textBlack),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
          child: Text(
            poetryLine1,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
          child: Text(
            poetryLine2,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
          child: Text(
            poetryLine3,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
          child: Text(
            poetryLine4,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

  ///跳转到主页面
  _go2MainPage(BuildContext context) {
    new Timer(const Duration(milliseconds: 2000), () {
      try {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
                builder: (BuildContext context) => new MainPage()),
            (Route route) => route == null);
      } catch (e) {}
    });
  }
}
