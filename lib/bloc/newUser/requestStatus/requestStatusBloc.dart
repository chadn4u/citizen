

import 'package:citizens/api/apiRepository.dart';
import 'package:citizens/bloc/newUser/requestStatus/requestStatusEvents.dart';
import 'package:citizens/bloc/newUser/requestStatus/requestStatusState.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestStatusBloc extends Bloc<RequestStatusEvents, RequestStatusState> {
  ApiRepository _apiRepository;
  Map<String, dynamic> _dataForRequest = new Map();

  RequestStatusBloc() {
    _apiRepository = ApiRepository();
  }

  @override
  RequestStatusState get initialState => UninitializedStateRS();

  @override
  Stream<RequestStatusState> mapEventToState(RequestStatusEvents event) async* {
    ResponseDio responseDio;
    if (event is FirstLoadEventRS) {
      try {
        _dataForRequest['jobCd'] = event.jobCd;
        _dataForRequest['strCd'] = event.strCd;
        _dataForRequest['empNo'] = event.empNo;
        _dataForRequest['corpFg'] = event.corpFg;
        _dataForRequest['directorat'] = event.directorat;
        _dataForRequest['allCorp'] = event.allCorp;

        responseDio = await _apiRepository.getRequestStatusRepo(_dataForRequest);
      } catch (e) {
        yield ErrorStateRS(e);
      }
    } 

    if (responseDio != null) {
     yield FetchedStateRS(responseDio);
    } else {
     yield EmptyStateRS();
    }
  }
}