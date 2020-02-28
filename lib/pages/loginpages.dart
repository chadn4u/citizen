import 'dart:developer';

import 'package:citizens/api/apiRepository.dart';
import 'package:citizens/models/login/modelLogin.dart';
import 'package:citizens/models/login/modelLoginFeed.dart';
import 'package:citizens/models/responseDio/errorResponse.dart';
import 'package:citizens/models/token/token.dart';
import 'package:citizens/models/token/tokenRequest.dart';
import 'package:citizens/pages/mainMenu.dart';
import 'package:citizens/utils/session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPagesState();
}

class LoginPagesState extends State<LoginPages> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final idController = TextEditingController();
  final passwdController = TextEditingController();

  void getLoginDetail(String id, String password, pr) {
    ApiRepository _apiRepository = ApiRepository();
    _apiRepository.getLoginRepo(id, password).then((value) {
      if (value.data != null) {
        if (value.data is ModelLoginFeed) {
          Session session = Session();
          ModelLoginFeed modelLoginFeed = value.data;
          session.addToString('empNo', modelLoginFeed.data[0].empNo);
          session.addToString('empNm', modelLoginFeed.data[0].empNm);
          session.addToString('jobCd', modelLoginFeed.data[0].jobCd);
          session.addToString('strCd', modelLoginFeed.data[0].strCd);
          session.addToString('corpFg', modelLoginFeed.data[0].corpFg);
        } else {
          ErrorResponse errorResponse = value.data;
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(errorResponse.message.toString())));
        }
      } else {
        _scaffoldKey.currentState.removeCurrentSnackBar();
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(value.message)));
      }
    }).catchError((onerror) {
      pr.hide().then((isHidden) {
        print(isHidden);
      });

      switch (onerror) {
        case DioErrorType.CONNECT_TIMEOUT:
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Connection Timeout')));
          break;
        case DioErrorType.SEND_TIMEOUT:
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Send Timeout')));
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Receive Timeout')));
          break;
        case DioErrorType.RESPONSE:
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text('Error ${onerror.toString()}')));
          break;
        case DioErrorType.CANCEL:
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Operation Cancelled')));
          break;
        case DioErrorType.DEFAULT:
          _scaffoldKey.currentState.removeCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(
                  'Failed host lookup, Please make sure you have used Lotte Connection')));

          break;
      }
    }).whenComplete(() {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainMenu()));
    });
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr =
        ProgressDialog(context, isDismissible: false, showLogs: true);
    pr.style(message: 'Please Wait...');
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.blue[900],
            Colors.blue[900],
            Colors.blue[700],
          ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Citizen Mobile Apps',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Container(
                    child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blue[900],
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextField(
                                    controller: idController,
                                    decoration: InputDecoration(
                                        hintText: "ID GMD",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextField(
                                    controller: passwdController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              if (idController.text.isEmpty ||
                                  passwdController.text.isEmpty) {
                                _scaffoldKey.currentState
                                    .removeCurrentSnackBar();
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content:
                                        Text('Id or Password cant be null')));
                              } else {
                                await pr.show();
                                TokenRequest tokenRequest = TokenRequest(
                                    'password',
                                    idController.text,
                                    passwdController.text,
                                    'testpass',
                                    'testclient');

                                ApiRepository apiRepository = ApiRepository();
                                apiRepository
                                    .getTokenRepo(tokenRequest.toMap())
                                    .then((value) {
                                  if (value.data != null) {
                                    if (value.data is Token) {
                                      Token token = value.data;
                                      Session session = Session();

                                      session.addToString(
                                          'access_token', token.access_token);
                                      session.addToString(
                                          'refresh_token', token.refresh_token);
                                      getLoginDetail(idController.text,
                                          passwdController.text, pr);
                                    } else {
                                      ErrorResponse errorResponse = value.data;
                                      _scaffoldKey.currentState
                                          .removeCurrentSnackBar();
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              content: Text(errorResponse
                                                  .message
                                                  .toString())));
                                    }
                                  } else {
                                    _scaffoldKey.currentState
                                        .removeCurrentSnackBar();
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(content: Text(value.message)));
                                  }
                                }).catchError((onerror) {
                                  pr.hide().then((isHidden) {
                                    print(isHidden);
                                  });
                                  switch (onerror) {
                                    case DioErrorType.CONNECT_TIMEOUT:
                                      _scaffoldKey.currentState
                                          .removeCurrentSnackBar();
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text('Connection Timeout')));
                                      break;
                                    case DioErrorType.SEND_TIMEOUT:
                                      _scaffoldKey.currentState
                                          .removeCurrentSnackBar();
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              content: Text('Send Timeout')));
                                      break;
                                    case DioErrorType.RECEIVE_TIMEOUT:
                                      _scaffoldKey.currentState
                                          .removeCurrentSnackBar();
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text('Receive Timeout')));
                                      break;
                                    case DioErrorType.RESPONSE:
                                      _scaffoldKey.currentState
                                          .removeCurrentSnackBar();
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Error ${onerror.toString()}')));
                                      break;
                                    case DioErrorType.CANCEL:
                                      _scaffoldKey.currentState
                                          .removeCurrentSnackBar();
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text('Operation Cancelled')));
                                      break;
                                    case DioErrorType.DEFAULT:
                                      _scaffoldKey.currentState
                                          .removeCurrentSnackBar();
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Failed host lookup, Please make sure you have used Lotte Connection')));

                                      break;
                                  }
                                }).whenComplete(() {});
                              }
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Colors.blue[900]),
                              child: Center(
                                  child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
