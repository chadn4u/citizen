import 'package:citizens/models/checkUpdate/checkUpdateFeed.dart';
import 'package:citizens/models/list/listFeed.dart';
import 'package:citizens/models/login/modelLoginFeed.dart';
import 'package:citizens/models/newUser/divisionFeed.dart';
import 'package:citizens/models/newUser/newUserFeed.dart';
import 'package:citizens/models/newUser/storeFeed.dart';
import 'package:citizens/models/repairing/resetPassword/searchListFeed.dart';
import 'package:citizens/models/responseDio/errorResponse.dart';
import 'package:citizens/models/responseDio/postResponse.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:citizens/models/token/token.dart';
import 'package:citizens/utils/session.dart';
import 'package:citizens/models/newUser/requestStatusFeed.dart';
import 'package:dio/dio.dart' as http_dio;

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
      throw (e);
    }
  }

  Future<ResponseDio> getLogin(String id, String password) async {
    http_dio.Dio dio = http_dio.Dio();
    dio.options.connectTimeout = 35000;
    dio.options.receiveTimeout = 35000;
    dio.interceptors.add(http_dio.InterceptorsWrapper(
        onRequest: (http_dio.Options options) async {
      String token = await Session().getStringVal('access_token');
      options.headers = {"Authorization": "Bearer $token"};
    }));

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
      throw (e);
    }
  }

  Future<ResponseDio> getList(Map<String, dynamic> data) async {
    http_dio.Dio dio = http_dio.Dio();
    dio.options.connectTimeout = 35000;
    dio.options.receiveTimeout = 35000;
    dio.interceptors.add(http_dio.InterceptorsWrapper(
        onRequest: (http_dio.Options options) async {
      String token = await Session().getStringVal('access_token');
      options.headers = {"Authorization": "Bearer $token"};
    }));

    http_dio.Response response;

    ResponseDio responseDio;
    ErrorResponse errorResponse;
    //dio.interceptors.add(http_dio.LogInterceptor(responseBody: false));

    try {
      response = await dio.get('http://frontier.lottemart.co.id/Citizen/list',
          queryParameters: {
            "jobCd": data['jobCd'],
            "strCd": data['strCd'],
            "empNo": data['empNo'],
            "corpFg": data['corpFg'],
            "min": data['min'],
            "max": data['max'],
            "totalData": data['totalData']
          });

      if (response.statusCode == 200) {
        responseDio = ResponseDio(ListFeed.from(response.data), 'Sukses');
      } else {
        errorResponse = ErrorResponse.from(response.data);
        responseDio = ResponseDio(errorResponse,
            '${errorResponse.message} ,E ${response.statusCode}');
      }
      //print(responseDio.toString());
      return responseDio;
    } on http_dio.DioError catch (e) {
      print(e.response.data);
      throw (e);
    }
  }

  Future<ResponseDio> getListSearch(Map<String, dynamic> data) async {
    http_dio.Dio dio = http_dio.Dio();
    dio.options.connectTimeout = 35000;
    dio.options.receiveTimeout = 35000;
    dio.interceptors.add(http_dio.InterceptorsWrapper(
        onRequest: (http_dio.Options options) async {
      String token = await Session().getStringVal('access_token');
      options.headers = {"Authorization": "Bearer $token"};
    }));

    http_dio.Response response;

    ResponseDio responseDio;
    ErrorResponse errorResponse;
    dio.interceptors.add(http_dio.LogInterceptor(responseBody: false));

    try {
      response = await dio.get(
          'http://frontier.lottemart.co.id/Citizen/listSearch',
          queryParameters: {
            "jobCd": data['jobCd'],
            "strCd": data['strCd'],
            "empNo": data['empNo'],
            "corpFg": data['corpFg'],
            "min": data['min'],
            "max": data['max'],
            "totalData": data['totalData'],
            "pilihan": data['pilihan'],
            "konten": data['konten']
          });

      if (response.statusCode == 200) {
        responseDio = ResponseDio(ListFeed.from(response.data), 'Sukses');
      } else {
        errorResponse = ErrorResponse.from(response.data);
        responseDio = ResponseDio(errorResponse,
            '${errorResponse.message} ,E ${response.statusCode}');
      }
      //print(responseDio.toString());
      return responseDio;
    } on http_dio.DioError catch (e) {
      throw (e);
    }
  }

  Future<ResponseDio> getNewUser(Map<String, dynamic> data) async {
    http_dio.Dio dio = http_dio.Dio();
    dio.options.connectTimeout = 35000;
    dio.options.receiveTimeout = 35000;
    dio.interceptors.add(http_dio.InterceptorsWrapper(
        onRequest: (http_dio.Options options) async {
      String token = await Session().getStringVal('access_token');
      options.headers = {"Authorization": "Bearer $token"};
    }));

    http_dio.Response response;

    ResponseDio responseDio;
    ErrorResponse errorResponse;
    dio.interceptors.add(http_dio.LogInterceptor(responseBody: false));

    try {
      response = await dio.get(
          'http://frontier.lottemart.co.id/Citizen/newUser',
          queryParameters: {
            "jobCd": data['jobCd'],
            "strCd": data['strCd'],
            "empNo": data['empNo'],
            "corpFg": data['corpFg'],
            "directorat": data['directorat'],
            "min": data['min'],
            "max": data['max'],
            "totalData": data['totalData']
          });

      if (response.statusCode == 200) {
        responseDio = ResponseDio(NewUserFeed.from(response.data), 'Sukses');
      } else {
        errorResponse = ErrorResponse.from(response.data);
        responseDio = ResponseDio(errorResponse,
            '${errorResponse.message} ,E ${response.statusCode}');
      }
      // print(responseDio.toString());
      return responseDio;
    } on http_dio.DioError catch (e) {
      print(e.response.data);
      throw (e);
    }
  }

  Future<ResponseDio> getDivision(Map<String, dynamic> data) async {
    http_dio.Dio dio = http_dio.Dio();
    dio.options.connectTimeout = 35000;
    dio.options.receiveTimeout = 35000;
    dio.interceptors.add(http_dio.InterceptorsWrapper(
        onRequest: (http_dio.Options options) async {
      String token = await Session().getStringVal('access_token');
      options.headers = {"Authorization": "Bearer $token"};
    }));

    http_dio.Response response;

    ResponseDio responseDio;
    ErrorResponse errorResponse;
    dio.interceptors.add(http_dio.LogInterceptor(responseBody: false));

    try {
      response = await dio.get(
          'http://frontier.lottemart.co.id/Citizen/getDivision',
          queryParameters: {"jobCd": data['jobCd'], "strCd": data['strCd']});

      if (response.statusCode == 200) {
        responseDio = ResponseDio(DivisionFeed.from(response.data), 'Sukses');
      } else {
        errorResponse = ErrorResponse.from(response.data);
        responseDio = ResponseDio(errorResponse,
            '${errorResponse.message} ,E ${response.statusCode}');
      }
      // print(responseDio.toString());
      return responseDio;
    } on http_dio.DioError catch (e) {
      print(e.response.data);
      throw (e);
    }
  }

  Future<ResponseDio> getStores(Map<String, dynamic> data) async {
    http_dio.Dio dio = http_dio.Dio();
    dio.options.connectTimeout = 35000;
    dio.options.receiveTimeout = 35000;
    dio.interceptors.add(http_dio.InterceptorsWrapper(
        onRequest: (http_dio.Options options) async {
      String token = await Session().getStringVal('access_token');
      options.headers = {"Authorization": "Bearer $token"};
    }));

    http_dio.Response response;

    ResponseDio responseDio;
    ErrorResponse errorResponse;
    dio.interceptors.add(http_dio.LogInterceptor(responseBody: false));

    try {
      response = await dio.get(
          'http://frontier.lottemart.co.id/Citizen/getStores',
          queryParameters: {
            "jobCd": data['jobCd'],
            "strCd": data['strCd'],
            "allCorp": data['allCorp']
          });

      if (response.statusCode == 200) {
        responseDio = ResponseDio(StoreFeed.from(response.data), 'Sukses');
      } else {
        errorResponse = ErrorResponse.from(response.data);
        responseDio = ResponseDio(errorResponse,
            '${errorResponse.message} ,E ${response.statusCode}');
      }
      // print(responseDio.toString());
      return responseDio;
    } on http_dio.DioError catch (e) {
      print(e.response.data);
      throw (e);
    }
  }

  Future<ResponseDio> postUser(Map data) async {
    http_dio.Dio dio = http_dio.Dio();
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    http_dio.Response response;
    //var head = {"Content-Type": "application/x-www-form-urlencoded"};
    ResponseDio responseDio;
    ErrorResponse errorResponse;

    dio.interceptors.add(http_dio.InterceptorsWrapper(
        onRequest: (http_dio.Options options) async {
      String token = await Session().getStringVal('access_token');
      options.headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/x-www-form-urlencoded"
      };
    }));
    // dio.interceptors.add(http_dio.LogInterceptor(responseBody: false));
    try {
      response = await dio.post(
          'http://frontier.lottemart.co.id/Citizen/newUser',
          data: http_dio.FormData.fromMap(data));
      if (response.statusCode == 200) {
        responseDio = ResponseDio(PostResponse.from(response.data), 'Sukses');
      } else {
        errorResponse = ErrorResponse.from(response.data);
        responseDio = ResponseDio(errorResponse,
            '${errorResponse.message} ,E ${response.statusCode}');
      }

      //print(responseDio);
      return responseDio;
    } on http_dio.DioError catch (e) {
      throw (e);
    }
  }

  Future<ResponseDio> checkUpdate(Map data) async {
    http_dio.Dio dio = http_dio.Dio();
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    http_dio.Response response;
    //var head = {"Content-Type": "application/x-www-form-urlencoded"};
    ResponseDio responseDio;
    ErrorResponse errorResponse;

    dio.interceptors.add(http_dio.InterceptorsWrapper(
        onRequest: (http_dio.Options options) async {
      options.headers = {"Content-Type": "application/x-www-form-urlencoded"};
    }));
    dio.interceptors.add(http_dio.LogInterceptor(responseBody: false));
    try {
      response = await dio.post(
          'http://frontier.lottemart.co.id/administration/V2/apeka',
          data: http_dio.FormData.fromMap(data));
      if (response.statusCode == 200) {
        responseDio =
            ResponseDio(CheckUpdateFeed.from(response.data), 'Sukses');
      } else {
        errorResponse = ErrorResponse.from(response.data);
        responseDio = ResponseDio(errorResponse,
            '${errorResponse.message} ,E ${response.statusCode}');
      }

      //print(responseDio);
      return responseDio;
    } on http_dio.DioError catch (e) {
      throw (e);
    }
  }

  Future<ResponseDio> getRequestStatus(Map<String, dynamic> data) async {
    http_dio.Dio dio = http_dio.Dio();
    dio.options.connectTimeout = 35000;
    dio.options.receiveTimeout = 35000;
    dio.interceptors.add(http_dio.InterceptorsWrapper(
        onRequest: (http_dio.Options options) async {
      String token = await Session().getStringVal('access_token');
      options.headers = {"Authorization": "Bearer $token"};
    }));

    http_dio.Response response;

    ResponseDio responseDio;
    ErrorResponse errorResponse;
    dio.interceptors.add(http_dio.LogInterceptor(responseBody: true));

    try {
      response = await dio.get(
          'http://frontier.lottemart.co.id/Citizen/getRequestStatus',
          queryParameters: {
            "jobCd": data['jobCd'],
            "strCd": data['strCd'],
            "empNo": data['empNo'],
            "corpFg": data['corpFg'],
            "directorat": data['directorat'],
            "allCorp": data['allCorp']
          });

      if (response.statusCode == 200) {
        responseDio =
            ResponseDio(RequestStatusFeed.from(response.data), 'Sukses');
      } else {
        errorResponse = ErrorResponse.from(response.data);
        responseDio = ResponseDio(errorResponse,
            '${errorResponse.message} ,E ${response.statusCode}');
      }
      return responseDio;
    } on http_dio.DioError catch (e) {
      // print(e.response.request);
      throw (e);
    }
  }

  Future<ResponseDio> getSearchUser(Map<String, dynamic> data) async {
    http_dio.Dio dio = http_dio.Dio();
    dio.options.connectTimeout = 35000;
    dio.options.receiveTimeout = 35000;
    dio.interceptors.add(http_dio.InterceptorsWrapper(
        onRequest: (http_dio.Options options) async {
      String token = await Session().getStringVal('access_token');
      options.headers = {"Authorization": "Bearer $token"};
    }));

    http_dio.Response response;

    ResponseDio responseDio;
    ErrorResponse errorResponse;
    dio.interceptors.add(http_dio.LogInterceptor(responseBody: true));

    try {
      response = await dio.get(
          'http://frontier.lottemart.co.id/Citizen/getSearchUser',
          queryParameters: {
            "konten": data['konten'],
            "pilihan": data['pilihan'],
          });

      if (response.statusCode == 200) {
        responseDio = ResponseDio(SearchListFeed.from(response.data), 'Sukses');
      } else {
        errorResponse = ErrorResponse.from(response.data);
        responseDio = ResponseDio(errorResponse,
            '${errorResponse.message} ,E ${response.statusCode}');
      }
      return responseDio;
    } on http_dio.DioError catch (e) {
      // print(e.response.request);
      throw (e);
    }
  }

  Future<ResponseDio> postResetPassword(Map data) async {
    http_dio.Dio dio = http_dio.Dio();
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    http_dio.Response response;
    //var head = {"Content-Type": "application/x-www-form-urlencoded"};
    ResponseDio responseDio;
    ErrorResponse errorResponse;

    dio.interceptors.add(http_dio.InterceptorsWrapper(
        onRequest: (http_dio.Options options) async {
      String token = await Session().getStringVal('access_token');
      options.headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/x-www-form-urlencoded"
      };
    }));
    // dio.interceptors.add(http_dio.LogInterceptor(responseBody: false));
    try {
      response = await dio.post(
          'http://frontier.lottemart.co.id/Citizen/resetPassword',
          data: http_dio.FormData.fromMap(data));
      if (response.statusCode == 200) {
        responseDio = ResponseDio(PostResponse.from(response.data), 'Sukses');
      } else {
        errorResponse = ErrorResponse.from(response.data);
        responseDio = ResponseDio(errorResponse,
            '${errorResponse.message} ,E ${response.statusCode}');
      }

      //print(responseDio);
      return responseDio;
    } on http_dio.DioError catch (e) {
      throw (e);
    }
  }

  Future<ResponseDio> postEnableUser(Map data) async {
    http_dio.Dio dio = http_dio.Dio();
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    http_dio.Response response;
    //var head = {"Content-Type": "application/x-www-form-urlencoded"};
    ResponseDio responseDio;
    ErrorResponse errorResponse;

    dio.interceptors.add(http_dio.InterceptorsWrapper(
        onRequest: (http_dio.Options options) async {
      String token = await Session().getStringVal('access_token');
      options.headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/x-www-form-urlencoded"
      };
    }));
     dio.interceptors.add(http_dio.LogInterceptor(responseBody: false));
    try {
      response = await dio.post(
          'http://frontier.lottemart.co.id/Citizen/enableUser',
          data: http_dio.FormData.fromMap(data));
      if (response.statusCode == 200) {
        responseDio = ResponseDio(PostResponse.from(response.data), 'Sukses');
      } else {
        errorResponse = ErrorResponse.from(response.data);
        responseDio = ResponseDio(errorResponse,
            '${errorResponse.message} ,E ${response.statusCode}');
      }

      print(responseDio);
      return responseDio;
    } on http_dio.DioError catch (e) {
      throw (e);
    }
  }
}
