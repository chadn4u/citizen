
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:dio/dio.dart';

abstract class BottomState{}


class DataFetched extends BottomState{
  final ResponseDio responsedio;

  DataFetched(this.responsedio);
}

class FetchingData extends BottomState{}
class ErrorFetching extends BottomState{
  final DioError dioError;

  ErrorFetching(this.dioError);

}
class EmptyData extends BottomState{}
class BottomUninitialized extends BottomState{}

class DataFetchedStores extends BottomState{
  final ResponseDio responsedio;

  DataFetchedStores(this.responsedio);
}

class SubmitPostUser extends BottomState{
  final ResponseDio responsedio;

  SubmitPostUser(this.responsedio);
}