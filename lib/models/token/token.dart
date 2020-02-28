import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token{
  @JsonKey(name: "access_token")
  final String access_token;

  @JsonKey(name: "expires_in")
  final int expires_in;

  @JsonKey(name: "token_type")
  final String token_type;

  @JsonKey(name: "scope")
  final String scope;

  @JsonKey(name: "refresh_token")
  final String refresh_token;

  @override
  String toString() {
    return 'Token{access_token: $access_token, expires_in: $expires_in,token_type: $token_type, scope: $scope,refresh_token: $refresh_token}';
  }

  Token(this.access_token, this.expires_in, this.token_type, this.scope, this.refresh_token);

  factory Token.from(Map<String,dynamic> json) => _$TokenFromJson(json);

  Map<String,dynamic> toJson() => _$TokenToJson(this);

}