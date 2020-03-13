
import 'package:citizens/models/newUser/division.dart';
import 'package:citizens/models/newUser/store.dart';
import 'package:json_annotation/json_annotation.dart';

part 'storeFeed.g.dart';

@JsonSerializable()
class StoreFeed{
  @JsonKey(name: "data")
  final List<Stores> data;

  @JsonKey(name: "status")
  final bool status;

  StoreFeed(this.data, this.status);

  @override
  String toString() {
    return 'StoreFeed{data: $data,status: $status}';
  }

  factory StoreFeed.from(Map<String,dynamic> json) => _$StoreFeedFromJson(json);

  Map<String,dynamic> toJson() => _$StoreFeedToJson(this);
}