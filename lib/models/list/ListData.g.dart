// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListDataModel _$ListDataModelFromJson(Map<String, dynamic> json) {
  return ListDataModel(
    json['EMP_NO'] as String,
    json['EMP_NM'] as String,
    json['JOB_CD'] as String,
    json['JOB_NM'] as String,
    json['STR_NM'] as String,
    json['CORP_FG'] as String,
    json['CHG_FG'] as String,
  );
}

Map<String, dynamic> _$ListDataModelToJson(ListDataModel instance) =>
    <String, dynamic>{
      'EMP_NO': instance.empNo,
      'EMP_NM': instance.empNm,
      'JOB_CD': instance.jobCd,
      'JOB_NM': instance.jobNm,
      'STR_NM': instance.strNm,
      'CORP_FG': instance.corpFg,
      'CHG_FG': instance.chgFg,
    };
