
import 'package:citizens/api/apiProvider.dart';
import 'package:citizens/models/responseDio/responseDio.dart';

class ApiRepository{

  ApiProvider apiProvider = ApiProvider();

  Future<ResponseDio> getTokenRepo(Map data) => apiProvider.getTokenProvider(data);
  Future<ResponseDio> getLoginRepo(String id, String password) => apiProvider.getLogin(id,password);
  Future<ResponseDio> getListRepo(Map<String, dynamic> data) async => await apiProvider.getList(data);
  Future<ResponseDio> getListSearchRepo(Map<String, dynamic> data)async => await apiProvider.getListSearch(data);
  Future<ResponseDio> getNewUserRepo(Map<String, dynamic> data)async => await apiProvider.getNewUser(data);
  
}