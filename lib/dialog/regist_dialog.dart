import 'package:flutter/material.dart';
import 'package:score_app/config/color_config.dart';

class RegisterDialog extends Dialog {
  static showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => new RegisterDialog(),
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
          width: 400,
          margin: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
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
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "注册/重置",
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
                          onTap: () => dismissLoadingDialog(context),
                          child: Icon(Icons.close,
                              size: 24.0, color: Theme.of(context).accentColor),
                        ))
                  ],
                ),
              ),
              _buildInputWidget(context, "用户名"),
              _buildVerificationCodeInputWidget(context, "验证码"),
              _buildInputWidget(context, "密码"),
              _buildInputWidget(context, "重复密码"),
              FlatButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                color: ColorConfig.red,
                child: Text("确认", style: TextStyle(color: ColorConfig.white)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputWidget(BuildContext context, String inputHint) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 40.0,
      decoration: BoxDecoration(
          color: ColorConfig.white, borderRadius: BorderRadius.circular(4.0)),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(right: 10.0, top: 3.0, left: 10.0),
            child: new Icon(Icons.account_circle,
                size: 24.0, color: Theme.of(context).accentColor),
          ),
          new Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: "$inputHint", border: InputBorder.none),
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 14, color: ColorConfig.textBlack),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationCodeInputWidget(
      BuildContext context, String inputHint) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 40.0,
      decoration: BoxDecoration(
          color: ColorConfig.white, borderRadius: BorderRadius.circular(4.0)),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(right: 10.0, top: 3.0, left: 10.0),
            child: new Icon(Icons.account_circle,
                size: 24.0, color: Theme.of(context).accentColor),
          ),
          new Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: "$inputHint", border: InputBorder.none),
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 14, color: ColorConfig.textBlack),
            ),
          ),
          FlatButton(
            onPressed: () {},
            //shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
            padding: EdgeInsets.all(0),
            color: ColorConfig.red,
            child: Text("验证码", style: TextStyle(color: ColorConfig.white)),
          )
        ],
      ),
    );
  }
}
