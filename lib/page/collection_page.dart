import 'package:flutter/material.dart';
import 'package:score_app/bean/base_response.dart';
import 'package:score_app/bean/score_base_info_bean.dart';
import 'package:score_app/config/color_config.dart';
import 'package:score_app/page/show_picture_page.dart';
import 'package:score_app/util/net_util.dart';
import 'package:score_app/widget/list_refresh.dart';

class CollectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CollectionPageState();
  }
}

class CollectionPageState extends State<CollectionPage> {
  List<ScoreBaseInfoBean> listData = new List();

  @override
  void initState() {
    super.initState();
    _getAllCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("收藏")),
      body: ListRefresh<ScoreBaseInfoBean>(
        itemData: listData,
        itemBuilder: itemWidgetBuild,
      ),
    );
  }

  ///list item
  Widget itemWidgetBuild(BuildContext context, int index) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () => _go2ShowPicturePage(context, listData.elementAt(index)),
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        listData.elementAt(index).scoreName,
                        style: TextStyle(
                            color: ColorConfig.textBlack, fontSize: 16.0),
                      ),
                      Padding(
                        child: Text(
                            "作词: ${listData.elementAt(index).scoreWordWriter}",
                            style: TextStyle(
                                color: Colors.black54, fontSize: 13.0)),
                        padding: EdgeInsets.only(top: 15.0),
                      ),
                      Padding(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                  "作曲: ${listData.elementAt(index).scoreSongWriter}",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 13.0)),
                            ),
                            Text(listData.elementAt(index).scoreUploader,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 13.0))
                          ],
                        ),
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  ///跳转到图片展示页面
  _go2ShowPicturePage(
      BuildContext context, ScoreBaseInfoBean scoreBaseInfoBean) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) =>
            new ShowPicturePage(scoreBaseInfoBean)));
  }

  ///获取收藏信息
  _getAllCollection() async {
    await NetUtils.getInstance().get("/collection").then((dataMap) {
      BaseResponse baseResponse = BaseResponse.fromJson(dataMap);
      if (baseResponse.isSuccess()) {
        //success
        List scoreBaseInfoBeanList = baseResponse.data;
        List<ScoreBaseInfoBean> list = scoreBaseInfoBeanList.map((item) {
          return item = ScoreBaseInfoBean.fromJson(item);
        }).toList();
        listData.clear();
        listData.addAll(list);
        setState(() {});
      } else {
        //something error
        print(baseResponse.message);
      }
    });
  }
}
