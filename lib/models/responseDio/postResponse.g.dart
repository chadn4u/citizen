// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponse _$PostResponseFromJson(Map<String, dynamic> json) {
  return PostResponse(
    json['status'] as bool,
    json['message'] as String,
  );
}

Map<String, dynamic> _$PostResponseToJson(PostResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
