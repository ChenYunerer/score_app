import 'package:json_annotation/json_annotation.dart';
part 'score_base_info_bean.g.dart';

@JsonSerializable()
///曲谱基本信息
class ScoreBaseInfoBean{
  int scoreId;  //曲谱id
  String scoreCategory;  //曲谱类型
  String scoreName; //曲谱名称
  String scoreHref;  //曲谱地址
  String scoreSinger;  //演唱者
  String scoreAuthor;  //作者
  String scoreWordWriter;  //词作者
  String scoreSongWriter;  //曲作者
  String scoreFormat;  //曲谱格式
  String scoreOrigin;  //曲谱源
  String scoreUploader;  //上传者
  int scoreUploaderTime;  //上传时间
  int scoreViewCount;  //访问量
  String scoreCoverPicture;  //曲谱首页图
  int scorePictureCount;

  ScoreBaseInfoBean(this.scoreId, this.scoreCategory, this.scoreName,
      this.scoreHref, this.scoreSinger, this.scoreAuthor, this.scoreWordWriter,
      this.scoreSongWriter, this.scoreFormat, this.scoreOrigin,
      this.scoreUploader, this.scoreUploaderTime, this.scoreViewCount,
      this.scoreCoverPicture, this.scorePictureCount); //曲谱图数量

  factory ScoreBaseInfoBean.fromJson(Map<String, dynamic> json) => _$ScoreBaseInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreBaseInfoBeanToJson(this);
}