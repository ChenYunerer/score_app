import 'package:flutter/material.dart';
import 'package:score_app/bean/base_response.dart';
import 'package:score_app/bean/score_base_info_bean.dart';
import 'package:score_app/bean/score_picture_info_bean.dart';
import 'package:score_app/page/picture_page.dart';
import 'package:score_app/util/net_utils.dart';

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
  TabController controller;
  List<Widget> picturePageList = new List();
  List<ScorePictureInfoBean> scorePictureInfoBeanList;

  ShowPicturePageState(this.scoreBaseInfoBean);

  @override
  void initState() {
    _loadScorePictures();
    controller = new TabController(
        initialIndex: 0, vsync: this, length: scoreBaseInfoBean.scorePictureCount); // 这里的length 决定有多少个底导 submenus

    controller.addListener(() {
      if (controller.indexIsChanging) {
        //_onTabChange();
      }
    });
    super.initState();
  }

  ///初始化页面信息
  _preparePicturePageData() {
    picturePageList.clear();
    for (int i = 0; i < scoreBaseInfoBean.scorePictureCount; i++) {
      if (i == 0) {
        picturePageList.add(
            new PicturePage(scoreBaseInfoBean.scoreCoverPicture));
      } else {
        picturePageList.add(new PicturePage(
            scorePictureInfoBeanList == null ? null : scorePictureInfoBeanList
                .elementAt(i)
                .scorePictureHref));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _preparePicturePageData();
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

  _loadScorePictures() async {
    Map<String, int> params = new Map();
    params["scoreId"] = scoreBaseInfoBean.scoreId;
    await NetUtils.get("http://soupu.yuner.fun/app/score/scorePicture",
        params: params)
        .then((dataMap) {
      BaseResponse baseResponse = BaseResponse.fromJson(dataMap);
      if (baseResponse.code == 1) {
        //success
        List list = baseResponse.data;
        scorePictureInfoBeanList = list.map((item) {
          return item = ScorePictureInfoBean.fromJson(item);
        }).toList();
      } else {
        //something error
        print(baseResponse.message);
      }
    }, onError: (e) {
      print(e);
    });
    setState(() {});
  }
}
