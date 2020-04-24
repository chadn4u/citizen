import 'package:citizens/api/apiRepository.dart';
import 'package:citizens/bloc/repairing/resetPassword/resetPasswordEvents.dart';
import 'package:citizens/bloc/repairing/resetPassword/resetPasswordState.dart';
import 'package:citizens/models/repairing/resetPassword/searchListFeed.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_ip/get_ip.dart';
import 'package:location/location.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvents, ResetPasswordState> {
  ApiRepository _apiRepository;
  Map<String, dynamic> _dataForRequest = new Map();

  ResetPasswordBloc() {
    _apiRepository = ApiRepository();
  }

  @override
  ResetPasswordState get initialState => SearchListUninitialized();

  @override
  Stream<ResetPasswordState> mapEventToState(ResetPasswordEvents event) async* {
    ResponseDio responseDio;
    //yield NewUserFetching();
    if (event is FirstLoadEvent) {
      try {
        yield SearchListLoading();
        _dataForRequest['pilihan'] = event.pilihan;
        _dataForRequest['konten'] = event.konten;

        responseDio = await _apiRepository.getSearchUserRepo(_dataForRequest);
      } catch (e) {
        yield SearchListError(e);
      }
      SearchListFeed searchListFeed = responseDio.data;
      if (searchListFeed.data.length > 0) {
        yield SearchListFetched(responseDio);
      } else {
        yield SearchListEmpty();
      }
    } else if (event is ResetPasswordEvent) {
      try {
        yield SearchListLoading();
        _dataForRequest['EMP_NO'] = event.empNo;
        _dataForRequest['EMP_NO_REQ'] = event.empNoReq;
        _dataForRequest['IP'] = await getIp().then((value)=> value);
        _dataForRequest['LAT'] = await _getLocation().then((value){return value.latitude;});
        _dataForRequest['LONG'] = await _getLocation().then((value){return value.longitude;});

        responseDio = await _apiRepository.postResetPasswordRepo(_dataForRequest);
        yield SearchListFetched(event.responseDio);
      } catch (e) {
        yield SearchListError(e);
      }
    }else if (event is EnableUserEvent) {
      try {
        yield SearchListLoading();
        _dataForRequest['EMP_NO'] = event.empNo;
        _dataForRequest['EMP_NO_REQ'] = event.empNoReq;
        _dataForRequest['IP'] = await getIp().then((value)=> value);
        _dataForRequest['LAT'] = await _getLocation().then((value){return value.latitude;});
        _dataForRequest['LONG'] = await _getLocation().then((value){return value.longitude;});

        responseDio = await _apiRepository.postEnableUserRepo(_dataForRequest);
        yield SearchListFetched(event.responseDio);
      } catch (e) {
        yield SearchListError(e);
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
