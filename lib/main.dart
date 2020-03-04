import 'package:citizens/pages/loginpages.dart';
import 'package:citizens/pages/mainMenu.dart';
import 'package:citizens/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Set default home.
  Widget _defaultHome = LoginPages();

  SharedPreferences pref = await SharedPreferences.getInstance();
  // Get result of the login function.
  String _result = pref.getString('empNo');;
  if (_result != null) {
    _defaultHome = MainMenu();
  }

  FlutterStatusbarcolor.setStatusBarColor(Colors.blue[900]);
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
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blue[900]
        ),
        primarySwatch: Colors.blue[900],
        primaryColor: Colors.blue[900]
      ),
      home: LoginPages(),
    );
  }
}
