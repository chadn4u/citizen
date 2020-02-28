
import 'package:citizens/models/login/modelLogin.dart';
import 'package:json_annotation/json_annotation.dart';

part 'modelLoginFeed.g.dart';

@JsonSerializable()
class ModelLoginFeed {
  @JsonKey(name: "data")
  final List<ModelLogin> data;

  @JsonKey(name: "status")
  final bool status;

  ModelLoginFeed(this.data, this.status);

  @override
  String toString() {
    return 'ModelLoginFeed{data: $data, status: $status}';
  }

  factory ModelLoginFeed.from(Map<String,dynamic> json) => _$ModelLoginFeedFromJson(json);

  Map<String,dynamic> toJson() => _$ModelLoginFeedToJson(this);
}