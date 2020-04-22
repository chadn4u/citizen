import 'package:json_annotation/json_annotation.dart';

part 'postResponse.g.dart';

@JsonSerializable()
class PostResponse{
  @JsonKey(name: "status")
  final bool status;

  @JsonKey(name: "message")
  final String message;

  PostResponse(this.status, this.message);

  @override
  String toString() {
    return 'PostResponse{status: $status,message: $message}';
  }

  factory PostResponse.from(Map<String,dynamic> json) => _$PostResponseFromJson(json);

  Map<String,dynamic> toJson() => _$PostResponseToJson(this);
}