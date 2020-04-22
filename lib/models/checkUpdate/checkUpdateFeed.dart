import 'checkUpdateDetail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checkUpdateFeed.g.dart';

@JsonSerializable()
class CheckUpdateFeed{
  @JsonKey(name:"message")
  final String message;

  @JsonKey(name:"status")
  final bool status;

  @JsonKey(name:"data")
  final List<CheckUpdateDetail> data;

  CheckUpdateFeed(this.message,this.status,this.data);

  @override
  String toString() {
    return 'CheckUpdateFeed{message: $message, status: $status, data: $data}';
  }

  factory CheckUpdateFeed.from(Map<String,dynamic> json) => _$CheckUpdateFeedFromJson(json);

  Map<String,dynamic> toJson() => _$CheckUpdateFeedToJson(this);
}