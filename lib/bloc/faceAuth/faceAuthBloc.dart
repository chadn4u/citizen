import 'package:citizens/api/apiRepository.dart';
import 'package:citizens/bloc/faceAuth/faceAuthEvent.dart';
import 'package:citizens/bloc/faceAuth/faceAuthState.dart';
import 'package:citizens/models/faceAuth/faceAuth.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaceAuthBloc extends Bloc<FaceAuthEvents, FaceAuthState> {
  ApiRepository _apiRepository;
  Map<String, dynamic> _dataForRequest = new Map();

  FaceAuthBloc() {
    _apiRepository = ApiRepository();
  }
  @override
  FaceAuthState get initialState => FaceUninitializedState();

  @override
  Stream<FaceAuthState> mapEventToState(FaceAuthEvents event) async* {
    ResponseDio responseDio;
    if (event is CheckStatusEvent) {
      try {
        _dataForRequest['emp_no'] = event.empNo;

        responseDio =
            await _apiRepository.postCheckFaceAuthRepo(_dataForRequest);
      } catch (e) {
        yield FaceErrorState(e);
      }
      if (responseDio != null) {
        if (responseDio.data is FaceAuth) {
          yield CheckStatusFetchedState(responseDio);
        }
      } else {
        yield FaceEmptyState();
      }
    }
  }
}
