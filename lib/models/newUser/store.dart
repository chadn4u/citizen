import 'package:json_annotation/json_annotation.dart';

part 'store.g.dart';

@JsonSerializable()
class Stores{
  @JsonKey(name:"STR_CD")
  final String strCd;

  @JsonKey(name:"STR_NM")
  final String strNm;

  Stores(this.strCd, this.strNm);

  @override
  String toString() {
    return 'Stores{strCd: $strCd, strCd: $strCd}';
  }

  factory Stores.from(Map<String,dynamic> json) => _$StoresFromJson(json);

  Map<String,dynamic> toJson() => _$StoresToJson(this);
}