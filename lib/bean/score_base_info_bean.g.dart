// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_base_info_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreBaseInfoBean _$ScoreBaseInfoBeanFromJson(Map<String, dynamic> json) {
  return ScoreBaseInfoBean(
      json['scoreId'] as int,
      json['scoreCategory'] as String,
      json['scoreName'] as String,
      json['scoreHref'] as String,
      json['scoreSinger'] as String,
      json['scoreAuthor'] as String,
      json['scoreWordWriter'] as String,
      json['scoreSongWriter'] as String,
      json['scoreFormat'] as String,
      json['scoreOrigin'] as String,
      json['scoreUploader'] as String,
      json['scoreUploaderTime'] as int,
      json['scoreViewCount'] as int,
      json['scoreCoverPicture'] as String,
      json['scorePictureCount'] as int);
}

Map<String, dynamic> _$ScoreBaseInfoBeanToJson(ScoreBaseInfoBean instance) =>
    <String, dynamic>{
      'scoreId': instance.scoreId,
      'scoreCategory': instance.scoreCategory,
      'scoreName': instance.scoreName,
      'scoreHref': instance.scoreHref,
      'scoreSinger': instance.scoreSinger,
      'scoreAuthor': instance.scoreAuthor,
      'scoreWordWriter': instance.scoreWordWriter,
      'scoreSongWriter': instance.scoreSongWriter,
      'scoreFormat': instance.scoreFormat,
      'scoreOrigin': instance.scoreOrigin,
      'scoreUploader': instance.scoreUploader,
      'scoreUploaderTime': instance.scoreUploaderTime,
      'scoreViewCount': instance.scoreViewCount,
      'scoreCoverPicture': instance.scoreCoverPicture,
      'scorePictureCount': instance.scorePictureCount
    };
