
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:dio/dio.dart';

abstract class ListState{}


class ListUninitializedState extends ListState{
}

class ListFetchingState extends ListState{}

class ListFetchedState extends ListState{
  final ResponseDio responsedio;

  ListFetchedState(this.responsedio);
}

class ListFetchedSearchState extends ListState{
  final ResponseDio responsedio;

  ListFetchedSearchState(this.responsedio);
}

class ListErrorState extends ListState{
  final DioError dioError;

  ListErrorState(this.dioError);

}

class ListEmptyState extends ListState{}