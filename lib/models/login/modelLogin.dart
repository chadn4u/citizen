import 'package:json_annotation/json_annotation.dart';

part 'modelLogin.g.dart';

@JsonSerializable()
class ModelLogin{
  @JsonKey(name: "EMP_NO")
  final String empNo;

  @JsonKey(name: "EMP_NM")
  final String empNm;

  @JsonKey(name: "JOB_CD")
  final String jobCd;

  @JsonKey(name: "STR_CD")
  final String strCd;

  @JsonKey(name: "CORP_FG")
  final String corpFg;

  @JsonKey(name: "ALL_CORP")
  final String allCorp;

   @JsonKey(name: "DIRECTORAT")
  final String directorat;
  

  ModelLogin(this.empNo, this.empNm, this.jobCd, this.strCd, this.corpFg,this.allCorp,this.directorat);

  @override
  String toString() {
    return 'ModelLogin{empNo: $empNo, empNm: $empNm,jobCd: $jobCd, strCd: $strCd,corpFg: $corpFg,directorat:$directorat}';
  }

  factory ModelLogin.from(Map<String,dynamic> json) => _$ModelLoginFromJson(json);

  Map<String,dynamic> toJson() => _$ModelLoginToJson(this);
}