import 'package:flutter/material.dart';
import 'package:score_app/config/color_config.dart';

///加载Dialog
class LoadingDialog extends Dialog {
  static showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => new LoadingDialog(),
    );
  }

  static dismissLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: 90,
          height: 90,
          decoration: ShapeDecoration(
            color: ColorConfig.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "loading",
                  style: TextStyle(color: ColorConfig.textBlack, fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
