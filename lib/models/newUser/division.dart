import 'package:json_annotation/json_annotation.dart';

part 'division.g.dart';

@JsonSerializable()
class Division{
  @JsonKey(name:"DETAIL_CD")
  final String detailCd;

  @JsonKey(name:"DETAIL_NM")
  final String detailNm;

  Division(this.detailCd, this.detailNm);
  
  @override
  String toString() {
    return 'Division{detailCd: $detailCd, detailNm: $detailNm}';
  }

  factory Division.from(Map<String,dynamic> json) => _$DivisionFromJson(json);

  Map<String,dynamic> toJson() => _$DivisionToJson(this);
}