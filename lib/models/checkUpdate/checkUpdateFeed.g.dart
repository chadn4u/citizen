// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkUpdateFeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUpdateFeed _$CheckUpdateFeedFromJson(Map<String, dynamic> json) {
  return CheckUpdateFeed(
    json['message'] as String,
    json['status'] as bool,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : CheckUpdateDetail.from(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CheckUpdateFeedToJson(CheckUpdateFeed instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };
