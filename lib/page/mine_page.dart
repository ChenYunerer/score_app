import 'package:flutter/material.dart';
import 'package:score_app/config/color_config.dart';
import 'package:score_app/dialog/login_dialog.dart';
import 'package:score_app/util/token_util.dart';

///我的页面
class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> {
  bool logined = false;

  @override
  void initState() {
    super.initState();
    TokenUtil.getToken().then((token) {
      String tokenStr = token as String;
      if (tokenStr != null && !tokenStr.isEmpty) {
        setState(() {
          logined = true;
        });
      }
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
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () => LoginDialog.showLoadingDialog(context),
                child: Image.asset(
                  "res/images/ic_laucner_ion.png",
                  width: 60,
                  height: 60,
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
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _buildDisplayItem(context, Icons.collections, "我的收藏"),
        SizedBox(
          height: 5,
        ),
        _buildDisplayItem(context, Icons.queue_play_next, "鸡腿计划"),
        SizedBox(
          height: 5,
        ),
        _buildDisplayItem(context, Icons.alternate_email, "关于我们"),
        SizedBox(
          height: 20,
        ),
        logined ? Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 45,
          child: FlatButton(
            onPressed: () {
              TokenUtil.clearToken();
              setState(() {
                logined = false;
              });
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            color: ColorConfig.red,
            child: Text(
              "退出登录",
              style: TextStyle(color: ColorConfig.white),
            ),
          ),
        ) : SizedBox()
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


}
