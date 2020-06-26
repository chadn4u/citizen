import 'package:animator/animator.dart';
import 'package:citizens/pages/dashboard/dashboardV1.dart';
import 'package:citizens/pages/login/loginPagesV2.dart';
import 'package:citizens/pages/walkthrough/walkthrough.dart';
import 'package:citizens/utils/colors.dart';
import 'package:citizens/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:citizens/provider/splas/splashScreenProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:citizens/utils/extensions.dart';

class SplashScreen extends StatefulWidget {
  final String linkUpdate;

  const SplashScreen({Key key, this.linkUpdate}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<SplashScreen> {
  GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext ctx1;
  SplashScreenProvider splashScreenProvider;
  List<SplashScreenModel> _lstSplash = [];
  bool _doneCheckPerm = false;
  bool _doneCheckUpdate = false;
  String _currentStatus = 'Loading....';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      checkPermissions().then((_) {
        setState(() {
          _currentStatus = 'Checking permission....';
        });
      }).whenComplete(() {
        setState(() {
          _doneCheckPerm = true;
          _currentStatus = 'Checking updates....';
        });
        Future.delayed(Duration(seconds: 3), () {
          if (widget.linkUpdate != null) {
            _lstSplash.add(SplashScreenModel(
                'Updates', 1, updateImage, 'There is new updates available'));
          }
          setState(() {
            _doneCheckUpdate = true;
            _currentStatus = 'Done';
          });
          print(_lstSplash);
          Future.delayed(Duration(seconds: 3), () async {
            if (_lstSplash.isEmpty) {
              SharedPreferences pref = await SharedPreferences.getInstance();
              if (pref.getString('empNo') != null) {
                print('tai ucing');
                return Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => Dashboard()));
              } else {
                print('tai ambing');
                return Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => LoginScreen()));
              }
            } else {
              Navigator.of(ctx1).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => WalkthroughScrreen(
                        lstSplash: _lstSplash,
                        updateLink: widget.linkUpdate,
                      )));
            }
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx1 = context;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(color: colorPrimary),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeAnimation(2.6, Image.asset('assets/images/lottelogo.png',
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.width / 2.5),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        FadeAnimation(3.6,Text(
                            "Lotte",
                            style: TextStyle(color: colorWhite, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (_doneCheckPerm && _doneCheckUpdate)
                          ? Animator(
                              duration: Duration(seconds: 2),
                              cycles: 0,
                              repeats: 1,
                              builder: (anim) => Transform.scale(
                                  scale: anim.value,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 35,
                                  )))
                          : CircularProgressIndicator(
                              backgroundColor: colorWhite,
                            ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Text(_currentStatus, style: TextStyle(color: colorWhite))
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }

  Future<void> checkPermissions() async {
    List<Permission> _lsPermission = [Permission.storage, Permission.location];
    String location;
    String title;
    for (int i = 0; i < _lsPermission.length; i++) {
      if (!await _lsPermission[i].request().isUndetermined) {
        if (_lsPermission[i] == Permission.storage &&
            !await _lsPermission[i].isGranted) {
          location = storageImage;
          title = "Request Permission for storage";
          _lstSplash
              .add(SplashScreenModel(_lsPermission[i], 0, location, title));
        } else if (_lsPermission[i] == Permission.location &&
            !await _lsPermission[i].isGranted) {
          location = locationImageGif;
          title = "Request Permission for location";
          _lstSplash
              .add(SplashScreenModel(_lsPermission[i], 0, location, title));
        } else {
          location = updateImage;
          title = 'There is new Updates available';
        }
      }
    }
  }
}

class SplashScreenModel {
  final dynamic typeChecking;
  final String imageLoc;
  final String title;
  final int type;

  SplashScreenModel(this.typeChecking, this.type, this.imageLoc, this.title);
}
