import 'package:json_annotation/json_annotation.dart';

part 'ListData.g.dart';

@JsonSerializable()
class ListDataModel{
  @JsonKey(name: "EMP_NO")
  final String empNo;

  @JsonKey(name: "EMP_NM")
  final String empNm;

  @JsonKey(name: "JOB_CD")
  final String jobCd;

  @JsonKey(name: "JOB_NM")
  final String jobNm;

  @JsonKey(name: "STR_NM")
  final String strNm;

  @JsonKey(name: "CORP_FG")
  final String corpFg;

  @JsonKey(name: "CHG_FG")
  final String chgFg;

  ListDataModel(this.empNo, this.empNm, this.jobCd, this.jobNm, this.strNm, this.corpFg, this.chgFg);

  @override
  String toString() {
    return 'ListDataModel{empNo: $empNo, empNm: $empNm,jobCd: $jobCd,jobNm: $jobNm, strNm: $strNm,corpFg: $corpFg,chgFg: $chgFg}';
  }

  factory ListDataModel.from(Map<String,dynamic> json) => _$ListDataModelFromJson(json);

  Map<String,dynamic> toJson() => _$ListDataModelToJson(this);

}