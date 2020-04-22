import 'package:json_annotation/json_annotation.dart';

part 'requestStatusDetail.g.dart';

@JsonSerializable()
class RequestStatusDetail {
  @JsonKey(name: "EMP_NO")
  final String empNo;

  @JsonKey(name: "EMP_NM")
  final String empNm;

  @JsonKey(name: "DOJ")
  final String doj;

  @JsonKey(name: "EMAIL_FG_NM")
  final String emailFgNm;

  @JsonKey(name: "EMAIL_STATUS")
  final String emailStatus;

  @JsonKey(name: "SAP_FG_NM")
  final String sapFgNm;

  @JsonKey(name: "SAP_STATUS")
  final String sapStatus;

  @JsonKey(name: "B2B_FG_NM")
  final String b2bFgNm;

  @JsonKey(name: "B2B_STATUS")
  final String b2bStatus;

  @JsonKey(name: "NET_FG_NM")
  final String netFgNm;

  @JsonKey(name: "NET_STATUS")
  final String netStatus;

  @JsonKey(name: "GMD_FG_NM")
  final String gmdFgNm;

  @JsonKey(name: "GMD_STATUS")
  final String gmdStatus;

  @JsonKey(name: "WIFI_FG_NM")
  final String wifiFgNm;

  @JsonKey(name: "WIFI_STATUS")
  final String wifiStatus;

  @JsonKey(name: "MOBILE_FG_NM")
  final String mobileFgNm;

  @JsonKey(name: "MOBILE_STATUS")
  final String mobileStatus;

  @JsonKey(name: "REQ_DATE")
  final String reqDate;

  @JsonKey(name: "REQ_USER_NM")
  final String reqUserNm;

  @JsonKey(name: "DIRECTORAT")
  final String directorat;

  @JsonKey(name: "STR_CD")
  final String strCd;

  @JsonKey(name: "CORP_FG")
  final String corpFg;

   bool selected = false;

  RequestStatusDetail(
      this.b2bFgNm,
      this.b2bStatus,
      this.wifiFgNm,
      this.wifiStatus,
      this.emailFgNm,
      this.emailStatus,
      this.gmdFgNm,
      this.gmdStatus,
      this.mobileFgNm,
      this.mobileStatus,
      this.netFgNm,
      this.netStatus,
      this.sapFgNm,
      this.sapStatus,
      this.corpFg,
      this.directorat,
      this.doj,
      this.empNm,
      this.empNo,
      this.strCd,
      this.reqDate,
      this.reqUserNm);

  @override
  String toString() {
    return 'RequestStatusDetail{strCd: $strCd, strCd: $strCd}';
  }

  factory RequestStatusDetail.from(Map<String, dynamic> json) => _$RequestStatusDetailFromJson(json);

  Map<String, dynamic> toJson() => _$RequestStatusDetailToJson(this);
}
