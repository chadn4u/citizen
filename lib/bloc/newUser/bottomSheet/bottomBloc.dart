import 'package:citizens/api/apiRepository.dart';
import 'package:citizens/bloc/newUser/bottomSheet/bottomEvent.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_ip/get_ip.dart';
import 'package:location/location.dart';

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
    } else if (event is SubmitUser) {
      try {
        
        _dataForRequest['EMP_NO_REQ'] = event.empNoReq;
        _dataForRequest['EMP_NO'] = event.empNo;
        _dataForRequest['EMP_NM'] = event.empNm;
        _dataForRequest['JOB_CD'] = event.jobCd;
        _dataForRequest['STR_CD'] = event.strCd;
        _dataForRequest['EMPID'] = event.empId;
        _dataForRequest['EMAIL_FG'] = event.emailFg;
        _dataForRequest['SAP_FG'] = event.sapFg;
        _dataForRequest['B2B_FG'] = event.b2bFg;
        _dataForRequest['NET_FG'] = event.netFg;
        _dataForRequest['GMD_FG'] = event.gmdFg;
        _dataForRequest['WIFI_FG'] = event.wifiFg;
        _dataForRequest['MOBILE_FG'] = event.mobileFg;
        _dataForRequest['CORP_FG'] = event.corpFg;
        _dataForRequest['IP'] = await getIp().then((value)=> value);
        _dataForRequest['LAT'] = await _getLocation().then((value){return value.latitude;});
        _dataForRequest['LONG'] = await _getLocation().then((value){return value.longitude;});

        
       responseDio = await _apiRepository.postUserRepo(_dataForRequest);
          if (responseDio != null) {
           yield SubmitPostUser(responseDio);
         } else {
           EmptyData();
         }
      } catch (e) {
        yield ErrorFetching(e);
      }
    }
  }

  Future<String> getIp() async {
    String ipAddress;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      ipAddress = await GetIp.ipAddress;
    } on PlatformException {
      ipAddress = 'Failed to get ipAddress.';
    }

    return ipAddress;
   
  }

  Future<LocationData> _getLocation() async {
    var location = new Location();
    LocationData locationData;
    try {
      locationData = await location.getLocation();
    } catch (e) {
      locationData = null;
    }
    return locationData;
  }
}
