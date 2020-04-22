import 'dart:ui';

import 'package:citizens/pages/login/loginPagesV2.dart';
import 'package:citizens/pages/loginpages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  String getFirstLetter(String name) {
    return name.substring(0, 1).toUpperCase();
  }

  Color getRandomColor(String string) {
    Color colorRandom;
    switch (string) {
      case 'A':
        colorRandom = Colors.blue;
        break;
      case 'B':
        colorRandom = Colors.blueAccent;
        break;
      case 'C':
        colorRandom = Colors.brown;
        break;
      case 'D':
        colorRandom = Colors.cyan;
        break;
      case 'E':
        colorRandom = Colors.cyanAccent;
        break;
      case 'F':
        colorRandom = Colors.deepOrange;
        break;
      case 'G':
        colorRandom = Colors.deepOrangeAccent;
        break;
      case 'H':
        colorRandom = Colors.deepPurple;
        break;
      case 'I':
        colorRandom = Colors.deepPurpleAccent;
        break;
      case 'J':
        colorRandom = Colors.green;
        break;
      case 'K':
        colorRandom = Colors.greenAccent;
        break;
      case 'L':
        colorRandom = Colors.indigo;
        break;
      case 'M':
        colorRandom = Colors.indigoAccent;
        break;
      case 'N':
        colorRandom = Colors.lightBlue;
        break;
      case 'O':
        colorRandom = Colors.lightBlueAccent;
        break;
      case 'P':
        colorRandom = Colors.lime;
        break;
      case 'Q':
        colorRandom = Colors.orangeAccent;
        break;
      case 'R':
        colorRandom = Colors.teal;
        break;
      case 'S':
        colorRandom = Colors.pink;
        break;
      case 'T':
        colorRandom = Colors.tealAccent;
        break;
      case 'U':
        colorRandom = Colors.limeAccent;
        break;
      case 'V':
        colorRandom = Colors.pinkAccent;
        break;
      case 'W':
        colorRandom = Colors.purple;
        break;
      case 'X':
        colorRandom = Colors.purpleAccent;
        break;
      case 'Y':
        colorRandom = Colors.red;
        break;
      case 'Z':
        colorRandom = Colors.tealAccent;
        break;
    }
    return colorRandom;
  }

  Future logout(page, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.commit();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> page));
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => page ));
  }

  void onError(GlobalKey<ScaffoldState> _scaffoldKey, DioError dioError,
      BuildContext context) {
    switch (dioError.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Connection Timeout')));
        });

        break;
      case DioErrorType.SEND_TIMEOUT:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Send Timeout')));
        });

        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Receive Timeout')));
        });

        break;
      case DioErrorType.RESPONSE:
        if (dioError.response.toString().contains('Invalid Token')) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scaffoldKey.currentState.removeCurrentSnackBar();
            _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Token Expired.... try Relogin'),
                action: SnackBarAction(
                  label: 'Relogin',
                  onPressed: () {
                    Utils().logout(LoginScreen(), context);
                  },
                )));
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scaffoldKey.currentState.removeCurrentSnackBar();
            _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Error ${dioError.response.toString()}')));
          });
        }

        break;
      case DioErrorType.CANCEL:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Operation Cancelled')));
        });

        break;
      case DioErrorType.DEFAULT:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(
                  'Failed host lookup, Please make sure you have used Lotte Connection')));
        });

        break;
    }
  }
}
