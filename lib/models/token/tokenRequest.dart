import 'package:json_annotation/json_annotation.dart';

part 'tokenRequest.g.dart';

@JsonSerializable()
class TokenRequest{
  @JsonKey(name : "grant_type")
  final String grant_type;

   @JsonKey(name : "username")
  final String username;

   @JsonKey(name : "password")
  final String password;

   @JsonKey(name : "client_secret")
  final String client_secret;

   @JsonKey(name : "client_id")
  final String client_id;

  TokenRequest(this.grant_type, this.username, this.password, this.client_secret, this.client_id);

  factory TokenRequest.from(Map<String,dynamic> json) => _$TokenRequestFromJson(json);

  Map<String,dynamic> toJson()=> _$TokenRequestToJson(this);

  Map toMap(){
    var map = Map<String,dynamic>();
    map['grant_type'] = grant_type;
    map['username'] = username;
    map['password'] = password;
    map['client_secret'] = client_secret;
    map['client_id'] = client_id;
    return map;
  }
}