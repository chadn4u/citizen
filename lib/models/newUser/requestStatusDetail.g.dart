// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestStatusDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestStatusDetail _$RequestStatusDetailFromJson(Map<String, dynamic> json) {
  return RequestStatusDetail(
    json['B2B_FG_NM'] as String,
    json['B2B_STATUS'] as String,
    json['WIFI_FG_NM'] as String,
    json['WIFI_STATUS'] as String,
    json['EMAIL_FG_NM'] as String,
    json['EMAIL_STATUS'] as String,
    json['GMD_FG_NM'] as String,
    json['GMD_STATUS'] as String,
    json['MOBILE_FG_NM'] as String,
    json['MOBILE_STATUS'] as String,
    json['NET_FG_NM'] as String,
    json['NET_STATUS'] as String,
    json['SAP_FG_NM'] as String,
    json['SAP_STATUS'] as String,
    json['CORP_FG'] as String,
    json['DIRECTORAT'] as String,
    json['DOJ'] as String,
    json['EMP_NM'] as String,
    json['EMP_NO'] as String,
    json['STR_CD'] as String,
    json['REQ_DATE'] as String,
    json['REQ_USER_NM'] as String,
  )..selected = json['selected'] as bool;
}

Map<String, dynamic> _$RequestStatusDetailToJson(
        RequestStatusDetail instance) =>
    <String, dynamic>{
      'EMP_NO': instance.empNo,
      'EMP_NM': instance.empNm,
      'DOJ': instance.doj,
      'EMAIL_FG_NM': instance.emailFgNm,
      'EMAIL_STATUS': instance.emailStatus,
      'SAP_FG_NM': instance.sapFgNm,
      'SAP_STATUS': instance.sapStatus,
      'B2B_FG_NM': instance.b2bFgNm,
      'B2B_STATUS': instance.b2bStatus,
      'NET_FG_NM': instance.netFgNm,
      'NET_STATUS': instance.netStatus,
      'GMD_FG_NM': instance.gmdFgNm,
      'GMD_STATUS': instance.gmdStatus,
      'WIFI_FG_NM': instance.wifiFgNm,
      'WIFI_STATUS': instance.wifiStatus,
      'MOBILE_FG_NM': instance.mobileFgNm,
      'MOBILE_STATUS': instance.mobileStatus,
      'REQ_DATE': instance.reqDate,
      'REQ_USER_NM': instance.reqUserNm,
      'DIRECTORAT': instance.directorat,
      'STR_CD': instance.strCd,
      'CORP_FG': instance.corpFg,
      'selected': instance.selected,
    };
