
import 'package:citizens/api/apiProvider.dart';
import 'package:citizens/models/responseDio/responseDio.dart';

class ApiRepository{

  ApiProvider apiProvider = ApiProvider();

  Future<ResponseDio> getTokenRepo(Map data) => apiProvider.getTokenProvider(data);
  Future<ResponseDio> getLoginRepo(String id, String password) => apiProvider.getLogin(id,password);
  Future<ResponseDio> getListRepo(Map<String, dynamic> data) async => await apiProvider.getList(data);
  Future<ResponseDio> getListSearchRepo(Map<String, dynamic> data)async => await apiProvider.getListSearch(data);
  Future<ResponseDio> getNewUserRepo(Map<String, dynamic> data)async => await apiProvider.getNewUser(data);
  Future<ResponseDio> getDivisionRepo(Map<String, dynamic> data)async => await apiProvider.getDivision(data);
  Future<ResponseDio> getStoreRepo(Map<String, dynamic> data)async => await apiProvider.getStores(data);
  Future<ResponseDio> postUserRepo(Map<String, dynamic> data)async => await apiProvider.postUser(data);
  Future<ResponseDio> checkUpdateRepo(Map<String, dynamic> data)async => await apiProvider.checkUpdate(data);
  Future<ResponseDio> getRequestStatusRepo(Map<String, dynamic> data)async => await apiProvider.getRequestStatus(data);
  Future<ResponseDio> getSearchUserRepo(Map<String, dynamic> data)async => await apiProvider.getSearchUser(data);
}