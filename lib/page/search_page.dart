import 'package:flutter/material.dart';
import 'package:score_app/bean/base_response.dart';
import 'package:score_app/bean/score_base_info_bean.dart';
import 'package:score_app/config/color_config.dart';
import 'package:score_app/dialog/loading_dialog.dart';
import 'package:score_app/page/show_picture_page.dart';
import 'package:score_app/util/net_util.dart';
import 'package:score_app/widget/list_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

///搜索页
class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  List<ScoreBaseInfoBean> listData = new List();
  List<Widget> chipWidgetList = new List();
  String searchParameter;
  BuildContext context;

  @override
  void initState() {
    _initSearchHistoryWidget();
    super.initState();
  }

  ///初始化搜索历史
  _initSearchHistoryWidget() {
    SharedPreferences.getInstance().then((sp) {
      List<String> searchParameterHistoryList =
          sp.getStringList("searchParameterHistory");
      if (searchParameterHistoryList == null) {
        return;
      }
      for (int i = 0; i < searchParameterHistoryList.length; i++) {
        chipWidgetList.add(ChoiceChip(
            backgroundColor: ColorConfig.red,
            selected: false,
            onSelected: (bool value) {
              _searchScore(searchParameterHistoryList.elementAt(i));
            },
            label: Text(
              searchParameterHistoryList.elementAt(i),
              style: TextStyle(color: ColorConfig.white, fontSize: 13),
            )));
      }
    }, onError: (err) {
      print(err);
    }).whenComplete(() {
      setState(() {});
    });
  }

  ///保存搜索历史
  _saveSearchHistory(String searchParameter) {
    SharedPreferences.getInstance().then((sp) {
      List<String> searchParameterHistoryList =
          sp.getStringList("searchParameterHistory");
      if (searchParameterHistoryList == null) {
        searchParameterHistoryList = new List();
      }
      if (searchParameterHistoryList.contains(searchParameter)) {
        return;
      }
      searchParameterHistoryList.add(searchParameter);
      if (searchParameterHistoryList.length > 10) {
        for (int i = 0; i < searchParameterHistoryList.length - 10; i++) {
          searchParameterHistoryList.removeAt(i);
        }
      }
      sp.setStringList("searchParameterHistory", searchParameterHistoryList);
    });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(title: Text("搜索")),
      body: Column(
        children: <Widget>[
          buildSearchInput(context),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Wrap(
              spacing: 10,
              children: chipWidgetList,
            ),
          ),
          Expanded(
            child: ListRefresh<ScoreBaseInfoBean>(
              itemData: listData,
              itemBuilder: itemWidgetBuild,
            ),
          )
        ],
      ),
    );
  }

  ///搜索框
  Widget buildSearchInput(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
      height: 40.0,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(4.0)),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(right: 10.0, top: 3.0, left: 10.0),
            child: new Icon(Icons.search,
                size: 24.0, color: Theme.of(context).accentColor),
          ),
          new Expanded(
            child: TextField(
              onChanged: (String str) {
                searchParameter = str;
              },
              onSubmitted: (String str) {
                _searchScore(searchParameter);
              },
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 14, color: ColorConfig.textBlack),
              decoration: InputDecoration(
                  hintText: "搜索曲谱: 名称 词作者 曲作者", border: InputBorder.none),
            ),
          ),
          FlatButton(
            onPressed: () => _searchScore(searchParameter),
            //shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
            padding: EdgeInsets.all(0),
            color: ColorConfig.red,
            child: Text("搜索", style: TextStyle(color: ColorConfig.white)),
          )
        ],
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

  ///发起搜索请求
  _searchScore(String searchParameter) async {
    if (searchParameter == null || searchParameter.isEmpty) {
      return;
    }
    LoadingDialog.showLoadingDialog(context);
    //保存到搜索历史
    _saveSearchHistory(searchParameter);
    //发起请求
    Map<String, String> params = new Map();
    params["searchParameter"] = searchParameter;
    await NetUtils.get("/score/scoreBase",
            params: params)
        .then((dataMap) {
      BaseResponse baseResponse = BaseResponse.fromJson(dataMap);
      if (baseResponse.code == 1) {
        //success
        List scoreBaseInfoBeanList = baseResponse.data;
        List<ScoreBaseInfoBean> list = scoreBaseInfoBeanList.map((item) {
          return item = ScoreBaseInfoBean.fromJson(item);
        }).toList();
        listData.clear();
        listData.addAll(list);
      } else {
        //something error
        print(baseResponse.message);
      }
    }, onError: (e) {
      print(e);
    });
    LoadingDialog.dismissLoadingDialog(context);
    setState(() {});
  }
}
