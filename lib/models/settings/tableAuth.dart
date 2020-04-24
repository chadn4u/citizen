import 'package:json_annotation/json_annotation.dart';

part 'tableAuth.g.dart';

@JsonSerializable()
class TableAuth {
  String empId;
  String empNm;
  String passw;


  TableAuth(this.empId, this.empNm, this.passw);
  
  @override
  String toString() {
    return 'TableAuth{empId: $empId, empNm: $empNm, passw:$passw}';
  }

  factory TableAuth.from(Map<String,dynamic> json) => _$TableAuthFromJson(json);

  Map<String,dynamic> toJson() => _$TableAuthToJson(this);
  
}