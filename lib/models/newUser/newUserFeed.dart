
import 'package:json_annotation/json_annotation.dart';

import 'newUser.dart';

part 'newUserFeed.g.dart';

@JsonSerializable()
class NewUserFeed{
  @JsonKey(name: "data")
  final List<NewUser> data;

  @JsonKey(name: "totalData")
  final String totalData;

  @JsonKey(name: "status")
  final bool status;

  NewUserFeed(this.data, this.totalData, this.status);

  @override
  String toString() {
    return 'NewUserFeed{data: $data, totalData: $totalData,status: $status}';
  }

  factory NewUserFeed.from(Map<String,dynamic> json) => _$NewUserFeedFromJson(json);

  Map<String,dynamic> toJson() => _$NewUserFeedToJson(this);
}