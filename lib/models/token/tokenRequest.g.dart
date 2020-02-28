// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokenRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRequest _$TokenRequestFromJson(Map<String, dynamic> json) {
  return TokenRequest(
    json['grant_type'] as String,
    json['username'] as String,
    json['password'] as String,
    json['client_secret'] as String,
    json['client_id'] as String,
  );
}

Map<String, dynamic> _$TokenRequestToJson(TokenRequest instance) =>
    <String, dynamic>{
      'grant_type': instance.grant_type,
      'username': instance.username,
      'password': instance.password,
      'client_secret': instance.client_secret,
      'client_id': instance.client_id,
    };
