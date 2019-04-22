import 'package:flutter/material.dart';
import 'package:score_app/config/color_config.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("关于我们")),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 6,
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: Text(
                "搜谱——简简单单搜曲谱",
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorConfig.textBlack, fontSize: 17.0),
              ),
            ),
          ),
          Card(
            elevation: 6,
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: Text(
                "搜谱APP是一个非商业化的项目，目的在于提供简单方便的在线曲谱搜索功能，以及下载、收藏等功能，方便音乐爱好者。现曲谱库包含20万曲谱数据，40万曲谱图片数据，不定期更新。由于还处在第一个版本，APP还不稳定，页面也略显粗糙，我们将继续优化和美化工作。",
                style: TextStyle(color: ColorConfig.textBlack, fontSize: 15.0),
              ),
            ),
          ),
          Card(
            elevation: 6,
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: Text(
                  "搜谱APP所提供的所有曲谱图片等等信息，全部来自网络，如果涉及版权问题，请联系我们。在此感谢中国曲谱网等其余曲谱网站和个人。",
                  style:
                      TextStyle(color: ColorConfig.textBlack, fontSize: 15.0)),
            ),
          ),
          Card(
            elevation: 6,
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: Text(
                  "搜谱项目的在于提供良好的曲谱搜索服务，适配Android手机，以及Android平板，对于iOS设备的支持，会在系统趋于稳定的时候提上日程。搜谱项目实际开发、维护、运营团队只有一个人，难免存在不足，望谅解。",
                  style:
                      TextStyle(color: ColorConfig.textBlack, fontSize: 15.0)),
            ),
          )
        ],
      ),
    );
  }
}
