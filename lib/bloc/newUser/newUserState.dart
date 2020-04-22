
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:dio/dio.dart';

abstract class NewUserState{}

class NewUserFetched extends NewUserState{
  final ResponseDio responsedio;
  final bool refresh;
  final bool submitResult;

  NewUserFetched(this.responsedio, this.refresh, this.submitResult);
}
class NewUserFetching extends NewUserState{}
class NewUserError extends NewUserState{
  final DioError dioError;

  NewUserError(this.dioError);

}
class NewUserLoading extends NewUserState{}
class NewUserEmpty extends NewUserState{}
class NewUserUninitialized extends NewUserState{}