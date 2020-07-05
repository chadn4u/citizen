// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'divisionFeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DivisionFeed _$DivisionFeedFromJson(Map<String, dynamic> json) {
  return DivisionFeed(
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Division.from(e as Map<String, dynamic>))
        ?.toList(),
    json['status'] as bool,
  );
}

Map<String, dynamic> _$DivisionFeedToJson(DivisionFeed instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
