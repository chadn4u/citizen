import 'package:json_annotation/json_annotation.dart';

part 'errorResponse.g.dart';

@JsonSerializable()
class ErrorResponse{
  @JsonKey(name: "status")
  final bool status;

  @JsonKey(name: "username")
  final String username;

  @JsonKey(name: "message")
  final String message;

  ErrorResponse(this.status, this.username, this.message);

  @override
  String toString() {
    return 'ErrorResponse{status: $status, username: $username,message: $message}';
  }

  factory ErrorResponse.from(Map<String,dynamic> json) => _$ErrorResponseFromJson(json);

  Map<String,dynamic> toJson() => _$ErrorResponseToJson(this);
}