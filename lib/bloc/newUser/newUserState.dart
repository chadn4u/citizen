
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:dio/dio.dart';

abstract class NewUserState{}

class NewUserFetched extends NewUserState{
  final ResponseDio responsedio;

  NewUserFetched(this.responsedio);
}
class NewUserFetching extends NewUserState{}
class NewUserError extends NewUserState{
  final DioError dioError;

  NewUserError(this.dioError);

}
class NewUserLoading extends NewUserState{}
class NewUserEmpty extends NewUserState{}
class NewUserUninitialized extends NewUserState{}