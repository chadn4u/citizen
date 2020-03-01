
import 'package:citizens/models/list/ListData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'listFeed.g.dart';

@JsonSerializable()
class ListFeed{
  @JsonKey(name: "data")
  final List<ListDataModel> data;

  @JsonKey(name: "totalData")
  final String totalData;

  @JsonKey(name: "status")
  final bool status;

  ListFeed(this.data, this.totalData, this.status);

  @override
  String toString() {
    return 'ListFeed{data: $data, totalData: $totalData}';
  }

  factory ListFeed.from(Map<String,dynamic> json) => _$ListFeedFromJson(json);

  Map<String,dynamic> toJson() => _$ListFeedToJson(this);
}