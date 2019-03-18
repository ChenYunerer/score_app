import 'package:flutter/material.dart';
import 'package:score_app/config/color_config.dart';

class MinePage extends StatelessWidget {
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
              Image.asset(
                "res/images/ic_laucner_ion.png",
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("搜谱--简简单单搜曲谱", style: TextStyle(fontSize: 16, color: ColorConfig.textBlack,fontWeight: FontWeight.w700),),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: ColorConfig.white,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Text("🍗 鸡腿计划", style: TextStyle(fontSize: 16, color: ColorConfig.textBlack),),
        )
      ],
    );
  }
}
