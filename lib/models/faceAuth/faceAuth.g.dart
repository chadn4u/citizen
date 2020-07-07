// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faceAuth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaceAuth _$FaceAuthFromJson(Map<String, dynamic> json) {
  return FaceAuth(
    json['status'] as bool,
    json['message'] as String,
    json['emp_no'] as String,
    json['is_match'] as bool,
    json['face_found'] as bool,
    json['data'] == null
        ? null
        : ModelLogin.from(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FaceAuthToJson(FaceAuth instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'emp_no': instance.emp_no,
      'is_match': instance.is_match,
      'face_found': instance.face_found,
      'data': instance.data,
    };
