import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:score_app/bean/base_response.dart';
import 'package:score_app/bean/score_base_info_bean.dart';
import 'package:score_app/bean/score_picture_info_bean.dart';
import 'package:score_app/bean/user_info_bean.dart';
import 'package:score_app/config/color_config.dart';
import 'package:score_app/util/net_util.dart';
import 'package:score_app/util/toast_util.dart';
import 'package:score_app/util/user_util.dart';

///图片展示页面
// ignore: must_be_immutable
class ShowPicturePage extends StatefulWidget {
  ScoreBaseInfoBean scoreBaseInfoBean;

  ShowPicturePage(this.scoreBaseInfoBean);

  @override
  State<StatefulWidget> createState() {
    return new ShowPicturePageState(scoreBaseInfoBean);
  }
}

class ShowPicturePageState extends State<ShowPicturePage> {
  ScoreBaseInfoBean scoreBaseInfoBean;
  List<PhotoViewGalleryPageOptions> photoViewGalleryPageOptionsList =
  new List();
  List<ScorePictureInfoBean> scorePictureInfoBeanList;

  ShowPicturePageState(this.scoreBaseInfoBean);

  bool logined = false;
  UserInfo userInfo;
  bool isCollected = false;

  @override
  void initState() {
    //图片数量大于1张时 才去加载其余图片
    if (scoreBaseInfoBean.scorePictureCount > 1) {
      _loadScorePictures();
    }
    initUserStatus();
    super.initState();
  }

  void initUserStatus() {
    UserUtil.getUserInfo().then((userInfo) {
      this.userInfo = userInfo;
      if (this.userInfo != null) {
        logined = true;
        _isCollected();
      } else {
        logined = false;
      }
      setState(() {});
    }, onError: (e) {
      logined = false;
      userInfo = null;
      setState(() {});
    });
  }

  ///初始化页面信息
  _preparePicturePageData() {
    photoViewGalleryPageOptionsList.clear();
    for (int i = 0; i < scoreBaseInfoBean.scorePictureCount; i++) {
      if (i == 0) {
        photoViewGalleryPageOptionsList.add(PhotoViewGalleryPageOptions(
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 1.5,
            imageProvider: NetworkImage(scoreBaseInfoBean.scoreCoverPicture)));
      } else {
        photoViewGalleryPageOptionsList.add(PhotoViewGalleryPageOptions(
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 1.5,
            imageProvider: NetworkImage(scorePictureInfoBeanList == null
                ? ""
                : scorePictureInfoBeanList
                .elementAt(i)
                .scorePictureHref)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _preparePicturePageData();
    return Scaffold(
      appBar: AppBar(
        title: Text(scoreBaseInfoBean.scoreName),
        actions: <Widget>[
          InkWell(
            onTap: () {
              if (isCollected) {
                _removeCollection();
              } else {
                _addCollection();
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: isCollected
                  ? Icon(Icons.remove_circle_outline, size: 30,)
                  : Icon(Icons.add_circle_outline, size: 30,),
            ),
          )
        ],
      ),
      body: PhotoViewGallery(
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(color: ColorConfig.black),
          pageOptions: photoViewGalleryPageOptionsList),
    );
  }

  ///加载所有图片信息
  _loadScorePictures() async {
    Map<String, int> params = new Map();
    params["scoreId"] = scoreBaseInfoBean.scoreId;
    await NetUtils.getInstance()
        .get("/score/scorePicture", params: params)
        .then((dataMap) {
      BaseResponse baseResponse = BaseResponse.fromJson(dataMap);
      if (baseResponse.code == 1) {
        //success
        List list = baseResponse.data;
        scorePictureInfoBeanList = list.map((item) {
          return item = ScorePictureInfoBean.fromJson(item);
        }).toList();
        setState(() {});
      }
    });
  }

  ///是否收藏
  _isCollected() {
    if (!logined) {
      ToastUtil.showToast("请先登录");
      return;
    }
    //发起请求
    NetUtils.getInstance().get("/collection/exist",
        params: {"scoreId": scoreBaseInfoBean.scoreId}).then((dataMap) {
      BaseResponse baseResponse = BaseResponse.fromJson(dataMap);
      if (baseResponse.code != 1) {
        isCollected = false;
      } else {
        isCollected = baseResponse.data as bool;
      }
      setState(() {});
    });
  }

  ///添加收藏
  _addCollection() {
    if (!logined) {
      ToastUtil.showToast("请先登录");
      return;
    }
    //发起请求
    NetUtils.getInstance().post("/collection", null,
        params: {"scoreId": scoreBaseInfoBean.scoreId}).then((dataMap) {
      BaseResponse baseResponse = BaseResponse.fromJson(dataMap);
      if (baseResponse.code != 1) {
        isCollected = false;
      } else {
        isCollected = true;
        ToastUtil.showToast("添加到收藏");
      }
      setState(() {});
    });
  }

  ///移除收藏
  _removeCollection() {
    if (!logined) {
      ToastUtil.showToast("请先登录");
      return;
    }
    //发起请求
    NetUtils.getInstance().delete("/collection",
        params: {"scoreId": scoreBaseInfoBean.scoreId}).then((dataMap) {
      BaseResponse baseResponse = BaseResponse.fromJson(dataMap);
      if (baseResponse.code != 1) {
        isCollected = true;
      } else {
        isCollected = false;
        ToastUtil.showToast("删除收藏");
      }
      setState(() {});
    });
  }
}
