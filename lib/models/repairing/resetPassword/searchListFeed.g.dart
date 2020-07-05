// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchListFeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchListFeed _$SearchListFeedFromJson(Map<String, dynamic> json) {
  return SearchListFeed(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : SearchListReset.from(e as Map<String, dynamic>))
        ?.toList(),
    json['status'] as bool,
  );
}

Map<String, dynamic> _$SearchListFeedToJson(SearchListFeed instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };
