import 'dart:async';

import 'package:flutter/material.dart';
import 'package:score_app/bean/base_response.dart';
import 'package:score_app/bean/score_base_info_bean.dart';
import 'package:score_app/config/color_config.dart';
import 'package:score_app/page/show_picture_page.dart';
import 'package:score_app/util/net_utils.dart';
import 'package:score_app/widget/list_refresh.dart';

///首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  List<ScoreBaseInfoBean> listData = new List();
  bool loadingMore = false;
  bool noMoreData = false;
  int pageNum = 0;

  @override
  void initState() {
    super.initState();
    _loadMoreData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListRefresh<ScoreBaseInfoBean>(
          itemData: listData,
          loadingMore: loadingMore,
          noMoreData: noMoreData,
          itemBuilder: itemWidgetBuild,
          onLoadMoreCallback: _loadMoreData),
    );
  }

  ///下拉刷新
  Future<Null> _handleRefresh() async {
    pageNum = 0;
    noMoreData = false;
    await _loadMoreData();
    return null;
  }

  ///ListView item
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

  ///加载更多
  _loadMoreData() async {
    loadingMore = true;
    Map<String, int> params = new Map();
    params["page"] = pageNum;
    await NetUtils.get("http://soupu.yuner.fun/app/score/homeRecommend",
            params: params)
        .then((dataMap) {
      BaseResponse baseResponse = BaseResponse.fromJson(dataMap);
      if (baseResponse.code == 1) {
        //success
        if (pageNum == 0) {
          listData.clear();
        }
        List scoreBaseInfoBeanList = baseResponse.data;
        List<ScoreBaseInfoBean> list = scoreBaseInfoBeanList.map((item) {
          return item = ScoreBaseInfoBean.fromJson(item);
        }).toList();
        listData.addAll(list);
        pageNum++;
      } else {
        //something error
        print(baseResponse.message);
      }
    }, onError: (e) {
      print(e);
    });
    loadingMore = false;
    setState(() {});
  }

  ///强制保活Page 避免页面重建
  @override
  bool get wantKeepAlive => true;
}
