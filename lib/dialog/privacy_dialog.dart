import 'package:flutter/material.dart';
import 'package:score_app/util/net_util.dart';
import 'package:score_app/util/open_url_util.dart';

// 显示隐私条款对话框
void showPrivacyDialog(BuildContext context, Function option) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "欢迎光临灵魂酒馆\n",
                style: TextStyle(fontSize: 24),
              ),
              Text(
                "请您仔细阅读以下条款，如果您对本协议的任何条款表示异议，您可以选择不使用本app",
                style: TextStyle(fontSize: 24),
              ),
              Text(
                "进入本app则意味着您将同意遵守本协议下全部规定。",
                style: TextStyle(fontSize: 24),
              ),
              Text(
                "本app全部资源，如有疏忽导致侵权烦请告知，会立即删除。",
                style: TextStyle(fontSize: 24),
              ),
              FlatButton(
                child: Text("点击此处查看协议相关信息"),
                onPressed: () {
                  launchURL(NetUtils.PRIVACY_URL);
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('同意并进入'),
            onPressed: () {
              Navigator.of(context).pop();
              option();
            },
          ),
        ],
      );
    },
  );
}
