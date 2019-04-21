import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:score_app/bean/base_response.dart';
import 'package:score_app/config/color_config.dart';
import 'package:score_app/util/net_util.dart';
import 'package:score_app/widget/count_down_text.dart';

final TextEditingController phoneNumTextEditingController =
TextEditingController();
final TextEditingController smsVerificationTextEditingController =
TextEditingController();
final TextEditingController passwordTextEditingController =
TextEditingController();
final TextEditingController passwordAgainTextEditingController =
TextEditingController();

///注册/重置Dialog
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
              _buildInputWidget(context, Icons.account_circle, "用户名",
                  phoneNumTextEditingController),
              _buildVerificationCodeInputWidget(
                  context, "验证码", smsVerificationTextEditingController),
              _buildInputWidget(context, Icons.account_circle, "密码",
                  passwordTextEditingController),
              _buildInputWidget(
                  context, Icons.account_circle, "重复密码",
                  passwordAgainTextEditingController),
              FlatButton(
                onPressed: () {
                  _register(
                      phoneNumTextEditingController.text,
                      passwordTextEditingController.text,
                      passwordAgainTextEditingController.text,
                      smsVerificationTextEditingController.text);
                },
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

  ///通用输入框
  Widget _buildInputWidget(BuildContext context, IconData iconData,
      String inputHint,
      TextEditingController controller) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 40.0,
      decoration: BoxDecoration(
          color: ColorConfig.white, borderRadius: BorderRadius.circular(4.0)),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(right: 10.0, top: 3.0, left: 10.0),
            child: new Icon(iconData,
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

  ///验证码输入框
  Widget _buildVerificationCodeInputWidget(BuildContext context,
      String inputHint, TextEditingController controller) {
    var countDownText = CountDownText();
    return Container(
      margin: EdgeInsets.all(10),
      height: 40.0,
      decoration: BoxDecoration(
          color: ColorConfig.white, borderRadius: BorderRadius.circular(4.0)),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(right: 10.0, top: 3.0, left: 10.0),
            child: new Icon(Icons.add_to_home_screen,
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
            onPressed: () {
              if (!countDownText.isActive()) {
                countDownText.startCountDown();
                _getSMSVerificationCode();
              }
            },
            //shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
            padding: EdgeInsets.all(0),
            color: ColorConfig.red,
            child: countDownText,
          )
        ],
      ),
    );
  }

  ///获取短信验证码
  _getSMSVerificationCode() async {
    await NetUtils.get("/sms/verificationCode").then((dataMap) {
      BaseResponse baseResponse = BaseResponse.fromJson(dataMap);
      Fluttertoast.showToast(msg: baseResponse.message);
    });
  }

  ///注册/重制
  _register(String phoneNum, String password, String passwordAgain,
      String smsVerificationCode) async {
    if (phoneNum == null || phoneNum.isEmpty) {
      Fluttertoast.showToast(msg: "请输入用户名");
      return;
    }
    if (smsVerificationCode == null || smsVerificationCode.isEmpty) {
      Fluttertoast.showToast(msg: "请输入短信验证码");
      return;
    }
    if (password == null || password.isEmpty) {
      Fluttertoast.showToast(msg: "请输入密码");
      return;
    }
    if (passwordAgain == null || passwordAgain.isEmpty) {
      Fluttertoast.showToast(msg: "请重复密码");
      return;
    }
    if (password != passwordAgain) {
      Fluttertoast.showToast(msg: "两次输入密码不匹配");
      return;
    }
    await NetUtils.post("/user/register", {
      "phoneNum": phoneNum,
      "password": password,
      "smsVerificationCode": smsVerificationCode
    }).then((dataMap) {
      BaseResponse baseResponse = BaseResponse.fromJson(dataMap);
      Fluttertoast.showToast(msg: baseResponse.message);
    });
  }
}
