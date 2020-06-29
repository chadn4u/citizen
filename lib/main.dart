import 'package:citizens/models/checkUpdate/checkUpdateDetail.dart';
import 'package:citizens/models/checkUpdate/checkUpdateFeed.dart';
import 'package:citizens/pages/login/loginPagesV2.dart';
import 'package:citizens/pages/splash/splashScreenV1.dart';
import 'package:citizens/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/apiRepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
//     Set default home.
  Widget _defaultHome = SplashScreen();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  SharedPreferences pref = await SharedPreferences.getInstance();

  print("${packageInfo.packageName} Version ${packageInfo.buildNumber}");

  ApiRepository _apiRepository = ApiRepository();
  Map<String, dynamic> _dataForRequest = new Map();
  _dataForRequest['name'] = packageInfo.packageName;
  _dataForRequest['version'] = packageInfo.buildNumber;
  await _apiRepository.checkUpdateRepo(_dataForRequest).then((value) {
    if (value.data != null) {
      if (value.data is CheckUpdateFeed) {
        print(value.data);
        CheckUpdateFeed checkUpdateFeed = value.data;
        if (checkUpdateFeed.message != null) {
          // Get result of the login function.
          String _result = pref.getString('empNo');
          if (_result != null) {
            _defaultHome = SplashScreen();
          }
        } else {
          CheckUpdateDetail checkUpdateDetail = checkUpdateFeed.data[0];
          _defaultHome = SplashScreen(
            linkUpdate: checkUpdateDetail.apkLink,
          );
        }
      } else {
        // Get result of the login function.
        String _result = pref.getString('empNo');
        if (_result != null) {
          _defaultHome = SplashScreen();
        }
      }
    } else {
      // Get result of the login function.
      String _result = pref.getString('empNo');
      if (_result != null) {
        _defaultHome = SplashScreen();
      }
    }
  }).catchError((onError) {
    String _result = pref.getString('empNo');
    if (_result != null) {
      _defaultHome = SplashScreen();
    }
  });

  FlutterStatusbarcolor.setStatusBarColor(colorPrimary);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: _defaultHome,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Citizen',
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: colorPrimary),
          primarySwatch: colorPrimary,
          primaryColor: colorPrimary),
      home: LoginScreen(),
    );
  }
}
