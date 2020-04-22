
import 'package:json_annotation/json_annotation.dart';

part 'checkUpdateDetail.g.dart';

@JsonSerializable()
class CheckUpdateDetail{
  @JsonKey(name:"APK_NM")
  final String apkNm;
  @JsonKey(name:"APK_VER")
  final String apkVer;
  @JsonKey(name:"APK_LINK")
  final String apkLink;
  @JsonKey(name:"APK_ACTIVE")
  final String apkActive;

  CheckUpdateDetail(this.apkNm, this.apkVer, this.apkLink, this.apkActive);

  @override
  String toString() {
    return 'CheckUpdateDetail{apkNm: $apkNm, apkVer: $apkVer, apkLink: $apkLink, apkActive: $apkActive}';
  }

  factory CheckUpdateDetail.from(Map<String,dynamic> json) => _$CheckUpdateDetailFromJson(json);

  Map<String,dynamic> toJson() => _$CheckUpdateDetailToJson(this);
}