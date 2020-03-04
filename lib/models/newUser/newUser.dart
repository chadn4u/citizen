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

  
  @JsonKey(name :"LEVEL_EMP")
  final String levelEmp;

  
  @JsonKey(name :"COMPID")
  final String compId;

  NewUser(this.empNo, this.empNm, this.doj, this.directorat, this.levelEmp, this.compId);

   @override
  String toString() {
    return 'NewUser{empNo: $empNo, empNm: $empNm,doj: $doj, directorat: $directorat,levelEmp: $levelEmp,compId:$compId}';
  }

  factory NewUser.from(Map<String,dynamic> json) => _$NewUserFromJson(json);

  Map<String,dynamic> toJson() => _$NewUserToJson(this);

}