// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storeFeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreFeed _$StoreFeedFromJson(Map<String, dynamic> json) {
  return StoreFeed(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Stores.from(e as Map<String, dynamic>))
        ?.toList(),
    json['status'] as bool,
  );
}

Map<String, dynamic> _$StoreFeedToJson(StoreFeed instance) => <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
