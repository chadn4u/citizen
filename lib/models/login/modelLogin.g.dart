// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelLogin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelLogin _$ModelLoginFromJson(Map<String, dynamic> json) {
  return ModelLogin(
    json['EMP_NO'] as String,
    json['EMP_NM'] as String,
    json['JOB_CD'] as String,
    json['STR_CD'] as String,
    json['CORP_FG'] as String,
  );
}

Map<String, dynamic> _$ModelLoginToJson(ModelLogin instance) =>
    <String, dynamic>{
      'EMP_NO': instance.empNo,
      'EMP_NM': instance.empNm,
      'JOB_CD': instance.jobCd,
      'STR_CD': instance.strCd,
      'CORP_FG': instance.corpFg,
    };
