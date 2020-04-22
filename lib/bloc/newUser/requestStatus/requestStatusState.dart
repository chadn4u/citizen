
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:dio/dio.dart';

abstract class RequestStatusState{}

class UninitializedStateRS extends RequestStatusState{
}

class FetchingStateRS extends RequestStatusState{}

class FetchedStateRS extends RequestStatusState{
  final ResponseDio responsedio;

  FetchedStateRS(this.responsedio);
}


class ErrorStateRS extends RequestStatusState{
  final DioError dioError;

  ErrorStateRS(this.dioError);

}

class EmptyStateRS extends RequestStatusState{}