// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'errorResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return ErrorResponse(
    json['status'] as bool,
    json['username'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'username': instance.username,
      'message': instance.message,
    };
