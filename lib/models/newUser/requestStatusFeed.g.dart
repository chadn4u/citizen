// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestStatusFeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestStatusFeed _$RequestStatusFeedFromJson(Map<String, dynamic> json) {
  return RequestStatusFeed(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : RequestStatusDetail.from(e as Map<String, dynamic>))
        ?.toList(),
    json['status'] as bool,
  );
}

Map<String, dynamic> _$RequestStatusFeedToJson(RequestStatusFeed instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
