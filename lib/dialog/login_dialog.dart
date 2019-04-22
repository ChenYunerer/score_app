import 'package:flutter/material.dart';
import 'package:score_app/bean/base_response.dart';
import 'package:score_app/bean/user_info_bean.dart';
import 'package:score_app/config/color_config.dart';
import 'package:score_app/util/net_util.dart';
import 'package:score_app/util/toast_util.dart';

typedef OnLoginSuccessCallBack = void Function(UserInfo userInfo);
typedef OnUserClickRegisterButtonCallBack = void Function();

final TextEditingController phoneNumController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();

class LoginDialog extends Dialog {
  OnLoginSuccessCallBack onLoginSuccessCallBack;
  OnUserClickRegisterButtonCallBack onUserClickRegisterButtonCallBack;

  LoginDialog(this.onLoginSuccessCallBack,
      this.onUserClickRegisterButtonCallBack);

  static showLoadingDialog(BuildContext context,
      Function onLoginSuccessCallBack, Function onClickRegisterCallBack) {
    showDialog(
      context: context,
      builder: (ctx) =>
      new LoginDialog(onLoginSuccessCallBack, onClickRegisterCallBack),
    );
  }

  static dismissLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  ///发起登录请求
  _login(BuildContext context, String phoneNum, String password) {
    if (phoneNum == null || phoneNum.isEmpty) {
      ToastUtil.showToast("请输入用户名");
      return;
    }
    if (password == null || password.isEmpty) {
      ToastUtil.showToast("请输入登录密码");
      return;
    }
    //发起请求
    NetUtils.getInstance().post(
        "/user/login", {"phoneNum": "$phoneNum", "password": "$password"})
        .then((dataMap) {
      BaseResponse baseResponse = BaseResponse.fromJson(dataMap);
      if (baseResponse.code != 1) {
        ToastUtil.showToast(baseResponse.message);
        return;
      }
      UserInfo userInfo = UserInfo.fromJson(baseResponse.data);
      dismissLoadingDialog(context);
      onLoginSuccessCallBack(userInfo);
    });
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
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "登录",
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
              _buildInputWidget(context, "用户名", phoneNumController),
              _buildInputWidget(
                  context, "密码", passwordController, password: true),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _login(context, phoneNumController.text,
                          passwordController.text);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    color: ColorConfig.red,
                    child:
                        Text("登录", style: TextStyle(color: ColorConfig.white)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FlatButton(
                    onPressed: () {
                      onUserClickRegisterButtonCallBack();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    color: ColorConfig.red,
                    child:
                        Text("注册", style: TextStyle(color: ColorConfig.white)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputWidget(BuildContext context, String inputHint,
      TextEditingController controller, {bool password = false}) {
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
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: InputDecoration(
                  hintText: "$inputHint", border: InputBorder.none),
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 14, color: ColorConfig.textBlack),
              obscureText: password,
            ),
          ),
        ],
      ),
    );
  }
}
