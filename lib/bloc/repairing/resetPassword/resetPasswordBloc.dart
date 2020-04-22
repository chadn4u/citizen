import 'package:citizens/api/apiRepository.dart';
import 'package:citizens/bloc/repairing/resetPassword/resetPasswordEvents.dart';
import 'package:citizens/bloc/repairing/resetPassword/resetPasswordState.dart';
import 'package:citizens/models/repairing/resetPassword/searchListFeed.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    }
    SearchListFeed searchListFeed = responseDio.data;
    if (searchListFeed.data.length > 0 ) {
      yield SearchListFetched(responseDio);
    } else {
      yield SearchListEmpty();
    }
  }
}
