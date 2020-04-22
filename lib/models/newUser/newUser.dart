import 'package:json_annotation/json_annotation.dart';

part 'newUser.g.dart';

@JsonSerializable()
class NewUser{
  @JsonKey(name :"EMP_NO")
  final String empNo;

  @JsonKey(name :"EMP_NM")
  final String empNm;

  @JsonKey(name :"DOJ")
  final String doj;

  @JsonKey(name :"DIRECTORAT")
  final String directorat;

  @JsonKey(name :"JOB_CD")
  final String jobCd;

  @JsonKey(name :"STR_CD")
  final String strCd;

  @JsonKey(name :"CORP_FG")
  final String corpFg;

  @JsonKey(name :"LEVEL_EMP")
  final String levelEmp;

  @JsonKey(name :"COMPID")
  final String compId;

  NewUser(this.empNo, this.empNm, this.doj, this.directorat, this.levelEmp, this.compId, this.jobCd, this.strCd, this.corpFg);

   @override
  String toString() {
    return 'NewUser{empNo: $empNo, empNm: $empNm,doj: $doj, directorat: $directorat,jobCd: $jobCd,levelEmp: $levelEmp,compId:$compId,strCd: $strCd,corpFg:$corpFg}';
  }

  factory NewUser.from(Map<String,dynamic> json) => _$NewUserFromJson(json);

  Map<String,dynamic> toJson() => _$NewUserToJson(this);

}