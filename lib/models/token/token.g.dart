// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    json['access_token'] as String,
    json['expires_in'] as int,
    json['token_type'] as String,
    json['scope'] as String,
    json['refresh_token'] as String,
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'access_token': instance.access_token,
      'expires_in': instance.expires_in,
      'token_type': instance.token_type,
      'scope': instance.scope,
      'refresh_token': instance.refresh_token,
    };
