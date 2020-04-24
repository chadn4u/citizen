import 'package:citizens/api/apiRepository.dart';
import 'package:citizens/models/login/modelLoginFeed.dart';
import 'package:citizens/models/responseDio/errorResponse.dart';
import 'package:citizens/models/settings/tableAuth.dart';
import 'package:citizens/models/token/token.dart';
import 'package:citizens/models/token/tokenRequest.dart';
import 'package:citizens/pages/dashboard/dashboard.dart';
import 'package:citizens/sqlite/auth.dart';
import 'package:citizens/utils/colors.dart';
import 'package:citizens/utils/const.dart';
import 'package:citizens/utils/extensions.dart';
import 'package:citizens/utils/mainUtils.dart';
import 'package:citizens/utils/session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info/package_info.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../loginpages.dart';
import '../mainMenu.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final idController = TextEditingController();
  final passwdController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool _authenticated = false;

  PackageInfo packageInfo;

  Future<void> _checkBiometrics() async {
    
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      print(canCheckBiometrics);
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _authenticate(ProgressDialog pr) async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });

    if (authenticated) {
      DbHelper().getAuthList().then((onValue) {
        TableAuth tabAuth = onValue;

        TokenRequest tokenRequest = TokenRequest('password', tabAuth.empId,
            tabAuth.passw, 'testpass', 'testclient');
        login(tokenRequest, pr);
      });
    }
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

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
          session.addToString('allCorp', modelLoginFeed.data[0].allCorp);
          session.addToString('directorat', modelLoginFeed.data[0].directorat);
          session.addToString('passw', password);
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
      DioError dioError = onerror;
      switch (dioError.type) {
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
          if (dioError.response.toString().contains('Invalid Token')) {
            _scaffoldKey.currentState.removeCurrentSnackBar();
            _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Token Expired.... try Relogin'),
                action: SnackBarAction(
                  label: 'Relogin',
                  onPressed: () {
                    Utils().logout(LoginPages(), context);
                  },
                )));
          } else {
            _scaffoldKey.currentState.removeCurrentSnackBar();
            _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Error ${dioError.response.toString()}')));
          }
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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashBoard()));
    });
  }

  Future<String> getPackageinfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr =
        ProgressDialog(context, isDismissible: false, showLogs: true);
    pr.style(message: 'Please Wait...');
    changeStatusColor(colorWhite);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/lottelogo.png',
                  width: width / 2.5, height: width / 2.5),
              text('Lotte Citizens',
                  textColor: textColorPrimary,
                  fontFamily: fontBold,
                  fontSize: 22.0),
              Container(
                margin: EdgeInsets.all(24),
                decoration: boxDecoration(
                    bgColor: colorWhite, showShadow: true, radius: 4),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 10),
                    EditText(
                      hint: 'User GMD',
                      isPassword: false,
                      mController: idController,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    EditText(
                      hint: 'Password',
                      isSecure: true,
                      mController: passwdController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 10),
                        child: FutureBuilder(
                            future: getPackageinfo(),
                            builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) =>
                                Text(
                                  snapshot.hasData
                                      ? "Version " + snapshot.data
                                      : "Loading ...",
                                  style: TextStyle(color: Colors.black38),
                                )),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
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
                                login(tokenRequest, pr);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 16),
                              alignment: Alignment.center,
                              height: width / 8,
                              child: text('Sign In',
                                  textColor: colorWhite, isCentered: true),
                              decoration: boxDecoration(
                                  bgColor: colorPrimary, radius: 8),
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: DbHelper().getAuthList(),
                          builder: (ctx, snapshot) {
                            if (snapshot.hasData) {
                              if (_canCheckBiometrics == null)
                                _checkBiometrics();
                              if (_canCheckBiometrics) {
                                return GestureDetector(
                                    onTap: () async {
                                      _authenticate(pr);
                                    },
                                    child: SvgPicture.asset(fingerPrintIcon,
                                        width: width / 8.2,
                                        color: colorPrimary));
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void login(TokenRequest tokenRequest, ProgressDialog pr) {
    ApiRepository apiRepository = ApiRepository();
    apiRepository.getTokenRepo(tokenRequest.toMap()).then((value) {
      if (value.data != null) {
        if (value.data is Token) {
          Token token = value.data;
          Session session = Session();

          session.addToString('access_token', token.access_token);
          session.addToString('refresh_token', token.refresh_token);
          getLoginDetail(idController.text, passwdController.text, pr);
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
      if (onerror is DioError) {
        DioError dioError = onerror;
        switch (dioError.type) {
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
            if (dioError.response.toString().contains('Invalid Token')) {
              _scaffoldKey.currentState.removeCurrentSnackBar();
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Token Expired.... try Relogin'),
                  action: SnackBarAction(
                    label: 'Relogin',
                    onPressed: () {
                      Utils().logout(LoginScreen(), context);
                    },
                  )));
            } else {
              _scaffoldKey.currentState.removeCurrentSnackBar();
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Error ${dioError.response.toString()}')));
            }
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
      } else {
        _scaffoldKey.currentState.removeCurrentSnackBar();
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(onerror.toString())));
      }
    }).whenComplete(() {});
  }

  Widget text(var text,
      {var fontSize = textSizeLargeMedium,
      textColor = textColorSecondary,
      var fontFamily = fontRegular,
      var isCentered = false,
      var maxLine = 1,
      var latterSpacing = 0.25}) {
    return Text(text,
        textAlign: isCentered ? TextAlign.center : TextAlign.start,
        maxLines: maxLine,
        style: TextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize,
            color: textColor,
            height: 1.5,
            letterSpacing: latterSpacing));
  }

  BoxDecoration boxDecoration(
      {double radius = 2,
      Color color = Colors.transparent,
      Color bgColor = colorWhite,
      var showShadow = false}) {
    return BoxDecoration(
        //gradient: LinearGradient(colors: [bgColor, whiteColor]),
        color: bgColor,
        boxShadow: showShadow
            ? [BoxShadow(color: shadowColor, blurRadius: 10, spreadRadius: 2)]
            : [BoxShadow(color: Colors.transparent)],
        border: Border.all(color: color),
        borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}
