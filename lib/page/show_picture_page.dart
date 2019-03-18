import 'package:flutter/material.dart';
import 'package:score_app/bean/score_base_info_bean.dart';
import 'package:score_app/page/picture_page.dart';

// ignore: must_be_immutable
class ShowPicturePage extends StatefulWidget {
  ScoreBaseInfoBean scoreBaseInfoBean;

  ShowPicturePage(this.scoreBaseInfoBean);

  @override
  State<StatefulWidget> createState() {
    return new ShowPicturePageState(scoreBaseInfoBean);
  }
}

class ShowPicturePageState extends State<ShowPicturePage> with SingleTickerProviderStateMixin{
  ScoreBaseInfoBean scoreBaseInfoBean;

  ShowPicturePageState(this.scoreBaseInfoBean);

  TabController controller;
  List<Widget> picturePageList = new List();

  @override
  void initState() {
    for (int i = 0; i < scoreBaseInfoBean.scorePictureCount; i++){
      picturePageList.add(new PicturePage(scoreBaseInfoBean.scoreCoverPicture));
    }
    controller = new TabController(
        initialIndex: 0, vsync: this, length: scoreBaseInfoBean.scorePictureCount); // 这里的length 决定有多少个底导 submenus

    controller.addListener(() {
      if (controller.indexIsChanging) {
        //_onTabChange();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scoreBaseInfoBean.scoreName),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: new TabBarView(
              controller: controller,
              children: picturePageList,
            ),
          )
        ],
      ),
    );
  }
}
