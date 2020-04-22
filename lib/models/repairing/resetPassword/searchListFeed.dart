
import 'package:citizens/models/list/searchList.dart';
import 'package:citizens/models/repairing/resetPassword/searchList.dart';
import 'package:json_annotation/json_annotation.dart';


part 'searchListFeed.g.dart';

@JsonSerializable()
class SearchListFeed{
  @JsonKey(name: "data")
  final List<SearchListReset> data;

  @JsonKey(name: "status")
  final bool status;

  SearchListFeed(this.data, this.status);

  @override
  String toString() {
    return 'SearchListFeed{data: $data,status: $status}';
  }

  factory SearchListFeed.from(Map<String,dynamic> json) => _$SearchListFeedFromJson(json);

  Map<String,dynamic> toJson() => _$SearchListFeedToJson(this);
}