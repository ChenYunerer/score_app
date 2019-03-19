import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:score_app/bean/base_response.dart';
import 'package:score_app/bean/score_base_info_bean.dart';
import 'package:score_app/bean/score_picture_info_bean.dart';
import 'package:score_app/config/color_config.dart';
import 'package:score_app/util/net_utils.dart';

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

  @override
  void initState() {
    //图片数量大于1张时 才去加载其余图片
    if (scoreBaseInfoBean.scorePictureCount > 1) {
      _loadScorePictures();
    }
    super.initState();
  }

  ///初始化页面信息
  _preparePicturePageData() {
    photoViewGalleryPageOptionsList.clear();
    for (int i = 0; i < scoreBaseInfoBean.scorePictureCount; i++) {
      if (i == 0) {
        photoViewGalleryPageOptionsList.add(PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(scoreBaseInfoBean.scoreCoverPicture),
            heroTag: i.toString()));
      } else {
        photoViewGalleryPageOptionsList.add(PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(scorePictureInfoBeanList == null
                ? ""
                : scorePictureInfoBeanList
                .elementAt(i)
                .scorePictureHref),
            heroTag: i.toString()));
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
      body: PhotoViewGallery(
          backgroundDecoration: BoxDecoration(color: ColorConfig.black),
          pageOptions: photoViewGalleryPageOptionsList),
    );
  }

  ///加载所有图片信息
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
