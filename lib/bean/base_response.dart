import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable()

class BaseResponse {
  int code;
  String message;
  Object data;

  BaseResponse(this.code, this.message, this.data);

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}