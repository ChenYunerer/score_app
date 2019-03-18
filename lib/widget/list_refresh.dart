import 'dart:async';

import 'package:flutter/material.dart';

///加载更多LoadingWidget
typedef LoadMoreWidgetBuilder = Widget Function();

///没有数据Widget
typedef NoMoreDataWidgetBuilder = Widget Function();

///加载更多回调
typedef OnLoadMoreCallback = void Function();

///RefreshList 封装
// ignore: must_be_immutable
class ListRefresh<T> extends StatefulWidget {
  List<T> itemData;
  IndexedWidgetBuilder itemBuilder;
  LoadMoreWidgetBuilder loadMoreWidgetBuilder;
  NoMoreDataWidgetBuilder noMoreDataWidgetBuilder;
  OnLoadMoreCallback onLoadMoreCallback;
  bool loadingMore;
  bool noMoreData;

  ListRefresh(
      {@required this.itemData,
      @required this.itemBuilder,
      this.onLoadMoreCallback,
      this.loadMoreWidgetBuilder,
      this.noMoreDataWidgetBuilder,
      this.loadingMore = false,
      this.noMoreData = false})
      : super();

  @override
  State<StatefulWidget> createState() => _ListRefreshState();
}

class _ListRefreshState extends State<ListRefresh> {
  @override
  Widget build(BuildContext context) {
    return (widget.itemData == null || widget.itemData.length == 0)
        ? ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Image.asset(
                  "res/images/ic_empty.png",
                  width: 60,
                  height: 60,
                ),
              )
            ],
          )
        : ListView.builder(
            itemCount: widget.itemData.length, itemBuilder: _itemBuilder);
  }

  ///默认加载更多Widget
  Widget _loadMoreWidgetBuilder() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: CircularProgressIndicator(strokeWidth: 2.0)),
    );
  }

  ///默认没有更多数据Widget
  Widget _noMoreDataWidgetBuilder() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Text("no more data"),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index == widget.itemData.length - 1 && !widget.noMoreData) {
      if (!widget.loadingMore) {
        widget.onLoadMoreCallback();
      }
      return widget.loadMoreWidgetBuilder == null
          ? _loadMoreWidgetBuilder()
          : widget.loadMoreWidgetBuilder;
    } else if (index == widget.itemData.length - 1 && widget.noMoreData) {
      return widget.noMoreDataWidgetBuilder == null
          ? _noMoreDataWidgetBuilder()
          : widget.noMoreDataWidgetBuilder;
    }
    return widget.itemBuilder(context, index);
  }
}
