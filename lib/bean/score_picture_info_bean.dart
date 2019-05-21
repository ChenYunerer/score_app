import 'package:json_annotation/json_annotation.dart';

part 'score_picture_info_bean.g.dart';

@JsonSerializable()
///曲谱图片信息
class ScorePictureInfoBean {
  int id; //主键id
  int scoreId; //曲谱id
  String scoreName; //曲谱名称
  String scoreHref; //曲谱地址
  int scorePictureIndex; //曲谱图片index
  String scorePictureHref;  //曲谱图片

  ScorePictureInfoBean(this.id, this.scoreId, this.scoreName, this.scoreHref,
      this.scorePictureIndex, this.scorePictureHref); //曲谱图片地址

  factory ScorePictureInfoBean.fromJson(Map<String, dynamic> json) => _$ScorePictureInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ScorePictureInfoBeanToJson(this);
}
