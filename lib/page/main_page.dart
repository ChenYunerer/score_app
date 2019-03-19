import 'package:flutter/material.dart';
import 'package:score_app/config/color_config.dart';
import 'package:score_app/page/home_page.dart';
import 'package:score_app/page/mine_page.dart';
import 'package:score_app/page/search_page.dart';

///主页面
class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  List<Widget> myTabs = [new Text("首页"), new Text("我的")];

  @override
  void initState() {
    controller = new TabController(
        initialIndex: 0, vsync: this, length: 2); // 这里的length 决定有多少个底导 submenus

    controller.addListener(() {
      if (controller.indexIsChanging) {
        _onTabChange();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: buildSearchInput(context),
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: 40.0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFFd0d0d0),
                    blurRadius: 3.0,
                    spreadRadius: 2.0,
                    offset: Offset(-1.0, -1.0),
                  ),
                ],
              ),
              child: TabBar(
                  controller: controller,
                  indicatorColor: ColorConfig.white,
                  indicatorWeight: 3.0,
                  indicatorPadding: EdgeInsets.fromLTRB(50, 0, 50, 5),
                  labelColor: ColorConfig.white,
                  unselectedLabelColor: ColorConfig.gray,
                  tabs: myTabs)),
          Expanded(
            child: new TabBarView(
              controller: controller,
              children: <Widget>[
                new HomePage(),
                new MinePage(),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///顶部搜索框
  Widget buildSearchInput(BuildContext context) {
    return new FlatButton(
      onPressed: () => _go2SearchPage(context),
      padding: EdgeInsets.all(0),
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
            color: Theme
                .of(context)
                .backgroundColor,
            borderRadius: BorderRadius.circular(4.0)),
        child: new Row(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(right: 10.0, top: 3.0, left: 10.0),
              child: new Icon(Icons.search,
                  size: 24.0, color: Theme
                      .of(context)
                      .accentColor),
            ),
            new Expanded(
              child: Text(
                "搜索曲谱: 名称 词作者 曲作者",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14, color: ColorConfig.textBlack),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///跳转到搜索页面
  _go2SearchPage(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new SearchPage()));
  }

  ///页面切换
  void _onTabChange() {
    if (this.mounted) {
      this.setState(() {});
    }
  }
}
