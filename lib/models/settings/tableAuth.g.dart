// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tableAuth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableAuth _$TableAuthFromJson(Map<String, dynamic> json) {
  return TableAuth(
    json['empId'] as String,
    json['empNm'] as String,
    json['passw'] as String,
  );
}

Map<String, dynamic> _$TableAuthToJson(TableAuth instance) => <String, dynamic>{
      'empId': instance.empId,
      'empNm': instance.empNm,
      'passw': instance.passw,
    };
