import 'package:json_annotation/json_annotation.dart';

part 'faceAuth.g.dart';

@JsonSerializable()
class FaceAuth {
  @JsonKey(name: "status")
  final bool status;
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "emp_no")
  final String emp_no;
  @JsonKey(name: "is_match")
  final bool is_match;
  @JsonKey(name: "face_found")
  final bool face_found;

  FaceAuth(
      this.status, this.message, this.emp_no, this.is_match, this.face_found);
  @override
  String toString() {
    return 'FaceAuth{status: $status, message: $message, emp_no: $emp_no, is_match: $is_match, face_found: $face_found}';
  }

  factory FaceAuth.from(Map<String, dynamic> json) => _$FaceAuthFromJson(json);

  Map<String, dynamic> toJson() => _$FaceAuthToJson(this);
}
