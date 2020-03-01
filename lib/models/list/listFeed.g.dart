// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listFeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListFeed _$ListFeedFromJson(Map<String, dynamic> json) {
  return ListFeed(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ListDataModel.from(e as Map<String, dynamic>))
        ?.toList(),
    json['totalData'] as String,
    json['status'] as bool,
  );
}

Map<String, dynamic> _$ListFeedToJson(ListFeed instance) => <String, dynamic>{
      'data': instance.data,
      'totalData': instance.totalData,
      'status': instance.status,
    };
