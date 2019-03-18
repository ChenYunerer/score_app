// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_picture_info_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScorePictureInfoBean _$ScorePictureInfoBeanFromJson(Map<String, dynamic> json) {
  return ScorePictureInfoBean(
      json['id'] as int,
      json['scoreId'] as int,
      json['scoreName'] as String,
      json['scoreHref'] as String,
      json['scorePictureIndex'] as int,
      json['scorePictureHref'] as String);
}

Map<String, dynamic> _$ScorePictureInfoBeanToJson(
        ScorePictureInfoBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scoreId': instance.scoreId,
      'scoreName': instance.scoreName,
      'scoreHref': instance.scoreHref,
      'scorePictureIndex': instance.scorePictureIndex,
      'scorePictureHref': instance.scorePictureHref
    };
