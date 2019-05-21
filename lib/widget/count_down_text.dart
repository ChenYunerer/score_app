import 'dart:async';

import 'package:flutter/material.dart';
import 'package:score_app/config/color_config.dart';

///倒计时Text
class CountDownText extends StatefulWidget {
  CountDownTextState countDownTextState;

  startCountDown() {
    countDownTextState.startCountDown();
  }

  reset() {
    countDownTextState.reset();
  }

  bool isActive() {
    return countDownTextState.isActive();
  }

  cancel() {
    countDownTextState.cancel();
  }

  @override
  State<StatefulWidget> createState() {
    countDownTextState = CountDownTextState();
    return countDownTextState;
  }
}

class CountDownTextState extends State<CountDownText> {
  static final String defaultStr = "验证码";
  String textStr = defaultStr;
  int seconds = 60;
  Timer timer;

  @override
  void dispose() {
    cancel();
    super.dispose();
  }

  startCountDown() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        reset();
        return;
      }
      seconds--;
      textStr = '验证码($seconds)';
      setState(() {});
    });
  }

  reset() {
    if (!isActive()) {
      return;
    }
    timer.cancel();
    textStr = defaultStr;
    seconds = 60;
    setState(() {});
  }

  bool isActive() {
    return timer == null ? false : timer.isActive;
  }

  cancel() {
    if (isActive()) {
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text("$textStr", style: TextStyle(color: ColorConfig.white));
  }
}
