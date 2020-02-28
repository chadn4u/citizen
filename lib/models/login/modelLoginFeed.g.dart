// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelLoginFeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelLoginFeed _$ModelLoginFeedFromJson(Map<String, dynamic> json) {
  return ModelLoginFeed(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ModelLogin.from(e as Map<String, dynamic>))
        ?.toList(),
    json['status'] as bool,
  );
}

Map<String, dynamic> _$ModelLoginFeedToJson(ModelLoginFeed instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
