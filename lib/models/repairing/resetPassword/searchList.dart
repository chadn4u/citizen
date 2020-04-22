import 'package:json_annotation/json_annotation.dart';


part 'searchList.g.dart';

@JsonSerializable()
class SearchListReset{
  @JsonKey(name: "EMP_NO")
  final String empNo;

  @JsonKey(name: "EMP_NM")
  final String empNm;

  SearchListReset(this.empNo, this.empNm);

  @override
  String toString() {
    return 'SearchListReset{data: $empNo,status: $empNm}';
  }

  factory SearchListReset.from(Map<String,dynamic> json) => _$SearchListResetFromJson(json);

  Map<String,dynamic> toJson() => _$SearchListResetToJson(this);
}