import 'package:flutter/material.dart';
import 'package:score_app/bean/user_info_bean.dart';
import 'package:score_app/config/color_config.dart';
import 'package:score_app/dialog/login_dialog.dart';
import 'package:score_app/dialog/register_dialog.dart';
import 'package:score_app/page/about_us_page.dart';
import 'package:score_app/page/chicken_leg_plan_page.dart';
import 'package:score_app/page/collection_page.dart';
import 'package:score_app/util/token_util.dart';
import 'package:score_app/util/user_util.dart';

///我的页面
class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> {
  bool logined = false;
  UserInfo userInfo;

  @override
  void initState() {
    super.initState();
    initUserStatus();
  }

  void initUserStatus() {
    UserUtil.getUserInfo().then((userInfo) {
      this.userInfo = userInfo;
      if (this.userInfo != null) {
        logined = true;
      } else {
        logined = false;
      }
      setState(() {});
    }, onError: (e) {
      logined = false;
      userInfo = null;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: ColorConfig.white,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              if (logined) {
                return;
              }
              LoginDialog.showLoadingDialog(context, onLoginSuccessCallBack,
                  onUserClickRegisterButtonCallBack);
            },
            child: Row(
              children: <Widget>[
                Image.asset(
                  "res/images/ic_laucner_ion.png",
                  width: 60,
                  height: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "${userInfo == null ? "未登录" : userInfo.phoneNum}",
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorConfig.textBlack,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "搜谱--简简单单搜曲谱",
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorConfig.textBlack,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            if (logined) {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new CollectionPage()));
            } else {
              LoginDialog.showLoadingDialog(context, onLoginSuccessCallBack,
                  onUserClickRegisterButtonCallBack);
            }
          },
          child: _buildDisplayItem(context, Icons.collections, "我的收藏"),
        ),
        SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new ChickenLegPlanPage()));
          },
          child: _buildDisplayItem(context, Icons.queue_play_next, "鸡腿计划"),
        ),
        SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new AboutUsPage()));
          },
          child: _buildDisplayItem(context, Icons.alternate_email, "关于我们"),
        ),
        SizedBox(
          height: 20,
        ),
        logined
            ? Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 45,
          child: FlatButton(
            onPressed: () {
              UserUtil.clearUserInfo();
              TokenUtil.clearToken();
              initUserStatus();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            color: ColorConfig.red,
            child: Text(
              "退出登录",
              style: TextStyle(color: ColorConfig.white),
            ),
          ),
        )
            : SizedBox()
      ],
    );
  }

  Widget _buildDisplayItem(BuildContext context, IconData iconData,
      String str) {
    return Container(
      width: double.infinity,
      color: ColorConfig.white,
      padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Row(
        children: <Widget>[
          Icon(iconData, size: 24.0, color: Theme
              .of(context)
              .accentColor),
          SizedBox(
            width: 10,
          ),
          Text(
            str,
            style: TextStyle(fontSize: 16, color: ColorConfig.textBlack),
          )
        ],
      ),
    );
  }

  onLoginSuccessCallBack(UserInfo userInfo) {
    TokenUtil.saveToken(userInfo.token);
    UserUtil.saveUserInfo(userInfo);
    initUserStatus();
  }

  onUserClickRegisterButtonCallBack() {
    LoginDialog.dismissLoadingDialog(context);
    RegisterDialog.showLoadingDialog(context, onLoginSuccessCallBack);
  }
}
