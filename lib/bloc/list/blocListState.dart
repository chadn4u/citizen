
import 'package:citizens/models/responseDio/responseDio.dart';

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

class ListErrorState extends ListState{}

class ListEmptyState extends ListState{}