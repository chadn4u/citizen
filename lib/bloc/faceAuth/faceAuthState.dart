import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:dio/dio.dart';

abstract class FaceAuthState {}

class FaceUninitializedState extends FaceAuthState {}

class FaceFetchingState extends FaceAuthState {}

class FaceEmptyState extends FaceAuthState {}

class CheckStatusFetchedState extends FaceAuthState {
  final ResponseDio responsedio;

  CheckStatusFetchedState(this.responsedio);
}

class FaceErrorState extends FaceAuthState {
  final DioError dioError;

  FaceErrorState(this.dioError);
}
