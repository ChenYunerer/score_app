import 'package:flutter/material.dart';
import 'package:score_app/config/color_config.dart';

typedef OnNegativeButtonClickCallBack = void Function(BuildContext context);
typedef OnPositiveButtonClickCallBack = void Function(BuildContext context);

class TipDialog extends Dialog {
  String tip;
  String negativeButtonStr;
  String positiveButtonStr;
  bool showNegativeButton;
  bool showPositiveButton;
  OnNegativeButtonClickCallBack onNegativeButtonClickCallBack;
  OnPositiveButtonClickCallBack onPositiveButtonClickCallBack;

  static void defaultOnNegativeButtonClickCallBack(BuildContext context) {
    dismissTipDialog(context);
  }

  TipDialog(this.tip,
      {this.negativeButtonStr = "取消",
      this.positiveButtonStr = "确认",
      this.showNegativeButton = true,
      this.showPositiveButton = true,
      this.onNegativeButtonClickCallBack = defaultOnNegativeButtonClickCallBack,
      this.onPositiveButtonClickCallBack});

  static showTipDialog(BuildContext context, String tip,
      {String negativeButtonStr = "取消",
      String positiveButtonStr = "确认",
      bool showNegativeButton = true,
      bool showPositiveButton = true,
      OnNegativeButtonClickCallBack onNegativeButtonClickCallBack =
          defaultOnNegativeButtonClickCallBack,
      OnPositiveButtonClickCallBack onPositiveButtonClickCallBack}) {
    showDialog(
      context: context,
      builder: (ctx) => new TipDialog(
            tip,
            negativeButtonStr: negativeButtonStr,
            positiveButtonStr: positiveButtonStr,
            showNegativeButton: showNegativeButton,
            showPositiveButton: showPositiveButton,
            onNegativeButtonClickCallBack: onNegativeButtonClickCallBack,
            onPositiveButtonClickCallBack: onPositiveButtonClickCallBack,
          ),
    );
  }

  static dismissTipDialog(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: 400,
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
          decoration: ShapeDecoration(
            color: Theme.of(context).backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        tip,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Positioned(
                        top: 5,
                        right: 5,
                        child: InkWell(
                          onTap: () => dismissTipDialog(context),
                          child: Icon(Icons.close,
                              size: 24.0, color: Theme.of(context).accentColor),
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      if (onNegativeButtonClickCallBack != null) {
                        onNegativeButtonClickCallBack(context);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    color: ColorConfig.red,
                    child: Text(negativeButtonStr,
                        style: TextStyle(color: ColorConfig.white)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FlatButton(
                    onPressed: () {
                      if (onPositiveButtonClickCallBack != null) {
                        onPositiveButtonClickCallBack(context);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    color: ColorConfig.red,
                    child: Text(positiveButtonStr,
                        style: TextStyle(color: ColorConfig.white)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
