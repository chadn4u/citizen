import 'package:citizens/api/apiRepository.dart';
import 'package:citizens/bloc/newUser/bottomSheet/bottomEvent.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottomState.dart';

class BottomBloc extends Bloc<BottomEvent, BottomState> {
  ApiRepository _apiRepository;
  Map<String, dynamic> _dataForRequest = new Map();

  BottomBloc() {
    _apiRepository = ApiRepository();
  }

  @override
  BottomState get initialState => BottomUninitialized();

  @override
  Stream<BottomState> mapEventToState(BottomEvent event) async* {
    ResponseDio responseDio;
    if (event is GetDivisionEvent) {
      try {
        _dataForRequest['jobCd'] = event.jobCd;
        _dataForRequest['strCd'] = event.strCd;

        responseDio = await _apiRepository.getDivisionRepo(_dataForRequest);

        if (responseDio != null) {
          yield DataFetched(responseDio);
        } else {
          EmptyData();
        }
      } catch (e) {
        yield ErrorFetching(e);
      }
    } else if (event is GetStoreEvent) {
      try {
        _dataForRequest['jobCd'] = event.jobCd;
        _dataForRequest['strCd'] = event.strCd;
        _dataForRequest['allCorp'] = event.allCorp;

        responseDio = await _apiRepository.getStoreRepo(_dataForRequest);
        if (responseDio != null) {
          yield DataFetchedStores(responseDio);
        } else {
          EmptyData();
        }
      } catch (e) {
        yield ErrorFetching(e);
      }
    }
  }
}
