// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkUpdateDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUpdateDetail _$CheckUpdateDetailFromJson(Map<String, dynamic> json) {
  return CheckUpdateDetail(
    json['APK_NM'] as String,
    json['APK_VER'] as String,
    json['APK_LINK'] as String,
    json['APK_ACTIVE'] as String,
  );
}

Map<String, dynamic> _$CheckUpdateDetailToJson(CheckUpdateDetail instance) =>
    <String, dynamic>{
      'APK_NM': instance.apkNm,
      'APK_VER': instance.apkVer,
      'APK_LINK': instance.apkLink,
      'APK_ACTIVE': instance.apkActive,
    };
