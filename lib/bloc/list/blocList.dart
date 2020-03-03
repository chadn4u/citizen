import 'package:citizens/api/apiRepository.dart';
import 'package:citizens/bloc/list/blocListState.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';

import 'blocListEvents.dart';

class ListBloc extends Bloc<UserEvents, ListState> {
  ApiRepository _apiRepository;
  Map<String, dynamic> _dataForRequest = new Map();

  ListBloc() {
    _apiRepository = ApiRepository();
  }

  @override
  ListState get initialState => ListUninitializedState();

  @override
  Stream<ListState> mapEventToState(UserEvents event) async* {
    ResponseDio responseDio;
    bool isSearch = false;
    // yield ListFetchingState();
    if (event is FirstLoadEvent) {
      try {
        _dataForRequest['jobCd'] = event.jobCd;
        _dataForRequest['strCd'] = event.strCd;
        _dataForRequest['empNo'] = event.empNo;
        _dataForRequest['corpFg'] = event.corpFg;
        _dataForRequest['min'] = event.min;
        _dataForRequest['max'] = event.max;
        _dataForRequest['totalData'] = null;

        responseDio = await _apiRepository.getListRepo(_dataForRequest);
      } catch (_) {
        yield ListErrorState();
      }
    } else if (event is FirstLoadSearchEvent) {
      isSearch = true;
      try {
        _dataForRequest['jobCd'] = event.jobCd;
        _dataForRequest['strCd'] = event.strCd;
        _dataForRequest['empNo'] = event.empNo;
        _dataForRequest['corpFg'] = event.corpFg;
        _dataForRequest['min'] = event.min;
        _dataForRequest['max'] = event.max;
        _dataForRequest['pilihan'] = event.pilihan;
        _dataForRequest['konten'] = event.konten;

        responseDio = await _apiRepository.getListSearchRepo(_dataForRequest);
      } catch (_) {
        yield ListErrorState();
      }
    } else if (event is LoadMoreEvent) {
      try {
        _dataForRequest['jobCd'] = event.jobCd;
        _dataForRequest['strCd'] = event.strCd;
        _dataForRequest['empNo'] = event.empNo;
        _dataForRequest['corpFg'] = event.corpFg;
        _dataForRequest['min'] = event.min;
        _dataForRequest['max'] = event.max;
        _dataForRequest['totalData'] = event.totalData;

        responseDio = await _apiRepository.getListRepo(_dataForRequest);
      } catch (_) {
        yield ListErrorState();
      }
    } else if (event is LoadMoreSearchEvent) {
      isSearch = true;
      try {
        _dataForRequest['jobCd'] = event.jobCd;
        _dataForRequest['strCd'] = event.strCd;
        _dataForRequest['empNo'] = event.empNo;
        _dataForRequest['corpFg'] = event.corpFg;
        _dataForRequest['min'] = event.min;
        _dataForRequest['max'] = event.max;
        _dataForRequest['pilihan'] = event.pilihan;
        _dataForRequest['konten'] = event.konten;
        _dataForRequest['totalData'] = event.totalData;

        responseDio = await _apiRepository.getListSearchRepo(_dataForRequest);
      } catch (_) {
        yield ListErrorState();
      }
    }

    if (responseDio != null) {
      if (isSearch) {
        yield ListFetchedSearchState(responseDio);
      } else
        yield ListFetchedState(responseDio);
    } else {
      ListEmptyState();
    }
  }
}
