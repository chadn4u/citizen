
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:dio/dio.dart';

abstract class ResetPasswordState{}

class SearchListFetched extends ResetPasswordState{
  final ResponseDio responsedio;

  SearchListFetched(this.responsedio);
}
class SearchListFetching extends ResetPasswordState{}
class SearchListError extends ResetPasswordState{
  final DioError dioError;

  SearchListError(this.dioError);

}
class SearchListLoading extends ResetPasswordState{}
class SearchListEmpty extends ResetPasswordState{}
class SearchListUninitialized extends ResetPasswordState{}