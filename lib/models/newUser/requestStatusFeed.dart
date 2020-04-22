import 'package:json_annotation/json_annotation.dart';
import 'package:citizens/models/newUser/requestStatusDetail.dart';
part 'requestStatusFeed.g.dart';

@JsonSerializable()
class RequestStatusFeed{
  @JsonKey(name: "data")
  final List<RequestStatusDetail> data;

  @JsonKey(name: "status")
  final bool status;

  RequestStatusFeed(this.data, this.status);
  
  @override
  String toString() {
    return 'RequestStatusFeed{data: $data, status: $status}';
  }

  factory RequestStatusFeed.from(Map<String,dynamic> json) => _$RequestStatusFeedFromJson(json);

  Map<String,dynamic> toJson() => _$RequestStatusFeedToJson(this);
}