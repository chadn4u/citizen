
import 'package:citizens/models/login/modelLoginFeed.dart';
import 'package:citizens/models/responseDio/errorResponse.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:citizens/models/token/token.dart';
import 'package:citizens/utils/session.dart';
import 'package:dio/dio.dart' as http_dio;
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  Future<ResponseDio> getTokenProvider(Map data) async {
    http_dio.Dio dio = http_dio.Dio();
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    http_dio.Response response;
    var head = {"Content-Type": "application/x-www-form-urlencoded"};
    ResponseDio responseDio;
    ErrorResponse errorResponse;
    //dio.interceptors.add(http_dio.LogInterceptor(responseBody: false));
    try {
      response = await dio.post(
          'http://frontier.lottemart.co.id/authorize/password_credentials',
          data: http_dio.FormData.fromMap(data),
          options: http_dio.Options(headers: head));
      if (response.statusCode == 200) {
        responseDio = ResponseDio(Token.from(response.data), 'Sukses');
      } else {
        errorResponse = ErrorResponse.from(response.data);
        responseDio = ResponseDio(errorResponse,
            '${errorResponse.message} ,E ${response.statusCode}');
      }
      
      //print(responseDio);
      return responseDio;
    } on http_dio.DioError catch (e) {
      throw (e.type);
    }
  }

  Future<ResponseDio> getLogin(String id, String password) async {
    http_dio.Dio dio = http_dio.Dio();
    Session session = Session();
    dio.options.connectTimeout = 15000;
    dio.options.receiveTimeout = 15000;
    dio.interceptors.add(http_dio.InterceptorsWrapper(
        onRequest: (http_dio.Options options) async{
          String token = await Session().getStringVal('access_token');
          options.headers = {
              "Authorization": "Bearer $token"
          };
        }
    ));

    http_dio.Response response;

    ResponseDio responseDio;
    ErrorResponse errorResponse;
    dio.interceptors.add(http_dio.LogInterceptor(responseBody: false));
    
    try {
      response = await dio.get('http://frontier.lottemart.co.id/Citizen/login',
      queryParameters: {"username": id, "password": password});

      if (response.statusCode == 200) {
        responseDio = ResponseDio(ModelLoginFeed.from(response.data), 'Sukses');
      } else {
        errorResponse = ErrorResponse.from(response.data);
        responseDio = ResponseDio(errorResponse,
            '${errorResponse.message} ,E ${response.statusCode}');
      }
      print(responseDio.toString());
      return responseDio;
    } on http_dio.DioError catch (e) {
      print(e.response.data);
      throw (e.type);
    }
  }
}
