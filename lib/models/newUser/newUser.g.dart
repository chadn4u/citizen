// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewUser _$NewUserFromJson(Map<String, dynamic> json) {
  return NewUser(
    json['EMP_NO'] as String,
    json['EMP_NM'] as String,
    json['DOJ'] as String,
    json['DIRECTORAT'] as String,
    json['LEVEL_EMP'] as String,
    json['COMPID'] as String,
    json['JOB_CD'] as String,
    json['STR_CD'] as String,
    json['CORP_FG'] as String,
  );
}

Map<String, dynamic> _$NewUserToJson(NewUser instance) => <String, dynamic>{
      'EMP_NO': instance.empNo,
      'EMP_NM': instance.empNm,
      'DOJ': instance.doj,
      'DIRECTORAT': instance.directorat,
      'JOB_CD': instance.jobCd,
      'STR_CD': instance.strCd,
      'CORP_FG': instance.corpFg,
      'LEVEL_EMP': instance.levelEmp,
      'COMPID': instance.compId,
    };
