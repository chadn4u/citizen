
import 'package:citizens/api/apiProvider.dart';
import 'package:citizens/models/responseDio/responseDio.dart';

class ApiRepository{

  ApiProvider apiProvider = ApiProvider();

  Future<ResponseDio> getTokenRepo(Map data) => apiProvider.getTokenProvider(data);
  Future<ResponseDio> getLoginRepo(String id, String password) => apiProvider.getLogin(id,password);
}