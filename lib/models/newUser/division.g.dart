// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'division.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Division _$DivisionFromJson(Map<String, dynamic> json) {
  return Division(
    json['DETAIL_CD'] as String,
    json['DETAIL_NM'] as String,
  );
}

Map<String, dynamic> _$DivisionToJson(Division instance) => <String, dynamic>{
      'DETAIL_CD': instance.detailCd,
      'DETAIL_NM': instance.detailNm,
    };
