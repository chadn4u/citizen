
import 'package:citizens/models/newUser/division.dart';
import 'package:json_annotation/json_annotation.dart';

part 'divisionFeed.g.dart';

@JsonSerializable()
class DivisionFeed{
  @JsonKey(name: "data")
  final List<Division> data;

  @JsonKey(name: "status")
  final bool status;

  DivisionFeed(this.data, this.status);

  @override
  String toString() {
    return 'NewUserFeed{data: $data,status: $status}';
  }

  factory DivisionFeed.from(Map<String,dynamic> json) => _$DivisionFeedFromJson(json);

  Map<String,dynamic> toJson() => _$DivisionFeedToJson(this);
}