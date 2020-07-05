// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newUserFeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewUserFeed _$NewUserFeedFromJson(Map<String, dynamic> json) {
  return NewUserFeed(
    (json['data'] as List)
        ?.map((e) => e == null ? null : NewUser.from(e as Map<String, dynamic>))
        ?.toList(),
    json['totalData'] as String,
    json['status'] as bool,
  );
}

Map<String, dynamic> _$NewUserFeedToJson(NewUserFeed instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalData': instance.totalData,
      'status': instance.status,
    };
