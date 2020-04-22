import 'package:citizens/api/apiRepository.dart';
import 'package:citizens/bloc/newUser/newUserEvents.dart';
import 'package:citizens/bloc/newUser/newUserState.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewUserBloc extends Bloc<NewUserEvents, NewUserState> {
  ApiRepository _apiRepository;
  Map<String, dynamic> _dataForRequest = new Map();

  NewUserBloc() {
    _apiRepository = ApiRepository();
  }

  @override
  NewUserState get initialState => NewUserUninitialized();

  @override
  Stream<NewUserState> mapEventToState(NewUserEvents event) async* {
    ResponseDio responseDio;
    bool isRefresh;
    bool submitResult = false;
     //yield NewUserFetching();
    if (event is FirstLoadEvent) {
      isRefresh = false;
      try {
        _dataForRequest['jobCd'] = event.jobCd;
        _dataForRequest['strCd'] = event.strCd;
        _dataForRequest['empNo'] = event.empNo;
        _dataForRequest['corpFg'] = event.corpFg;
        _dataForRequest['directorat'] = event.directorat;
        _dataForRequest['min'] = event.min;
        _dataForRequest['max'] = event.max;
        _dataForRequest['totalData'] = null;

        responseDio = await _apiRepository.getNewUserRepo(_dataForRequest);
        isRefresh = false;
      } catch (e) {
        yield NewUserError(e);
      }
    } else if (event is LoadMoreEvent) {
      try {
        _dataForRequest['jobCd'] = event.jobCd;
        _dataForRequest['strCd'] = event.strCd;
        _dataForRequest['empNo'] = event.empNo;
        _dataForRequest['corpFg'] = event.corpFg;
        _dataForRequest['directorat'] = event.directorat;
        _dataForRequest['min'] = event.min;
        _dataForRequest['max'] = event.max;
        _dataForRequest['totalData'] = event.totalData;

        responseDio = await _apiRepository.getNewUserRepo(_dataForRequest);
        isRefresh = false;
      } catch (e) {
        yield NewUserError(e);
      }
    }else if(event is RefreshEvent) {
      try {
        _dataForRequest['jobCd'] = event.jobCd;
        _dataForRequest['strCd'] = event.strCd;
        _dataForRequest['empNo'] = event.empNo;
        _dataForRequest['corpFg'] = event.corpFg;
        _dataForRequest['directorat'] = event.directorat;
        _dataForRequest['min'] = event.min;
        _dataForRequest['max'] = event.max;
        _dataForRequest['totalData'] = event.totalData;
        submitResult = event.submitResult;

        responseDio = await _apiRepository.getNewUserRepo(_dataForRequest);
        isRefresh = true;
      } catch (e) {
        yield NewUserError(e);
      }
    }

    if (responseDio != null) {
      yield NewUserFetched(responseDio,isRefresh,submitResult);
    } else {
      NewUserEmpty();
    }
  }
}
