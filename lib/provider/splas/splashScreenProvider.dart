import 'package:citizens/pages/dashboard/dashboardV1.dart';
import 'package:citizens/pages/login/loginPagesV2.dart';
import 'package:citizens/pages/splash/splashScreen.dart';
import 'package:citizens/pages/walkthrough/walkthrough.dart';
import 'package:citizens/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenProvider with ChangeNotifier {
  List<SplashScreenModel> _lstSplash = [];
  bool _isUpdate = false;
  bool _firstRun = true;
  String _linkUpdate;

  set linkUpdate(String value) {
    _linkUpdate = value;
  }

  String get linkUpdate => _linkUpdate;

  String _navigation;
  BuildContext _context;
  int _currentIndexPage = 0;

  int get currentIndexPage => _currentIndexPage;

  set currentIndexPage(int value) {
    _currentIndexPage = value;
    notifyListeners();
  }

  String _currentStatus = 'Loading....';
  bool _doneCheckPerm = false;
  bool _doneCheckUpdate = false;

  String get currentStatus => _currentStatus;

  set currentStatus(String value) {
    _currentStatus = value;
    notifyListeners();
  }

  bool get isUpdate => _isUpdate;

  set isUpdate(bool value) {
    _isUpdate = value;
    notifyListeners();
  }

  bool get firstRun => _firstRun;

  set firstRun(bool value) {
    _firstRun = value;
    notifyListeners();
  }

  List<SplashScreenModel> get lstSplash => _lstSplash;

  bool get doneCheckPerm => _doneCheckPerm;

  bool get doneCheckUpd => _doneCheckUpdate;

  void setCurrentStatus(String status) {
    _currentStatus = status;
    notifyListeners();
  }

  void init(BuildContext context) async {
    _context = context;
    Future.delayed(Duration(seconds: 3), () {
      checkPermissions().then((_) {
        _currentStatus = 'Checking permission....';
        notifyListeners();
      }).whenComplete(() {
        _doneCheckPerm = true;
        _currentStatus = 'Checking updates....';
        notifyListeners();
        Future.delayed(Duration(seconds: 3), () {
          if (_linkUpdate != null) {
            _lstSplash.add(SplashScreenModel(
                'Updates', 1, updateImage, 'There is new updates available'));
          }
          _doneCheckUpdate = true;
          _currentStatus = 'Done';
          notifyListeners();
          if (_lstSplash.isEmpty) {
            getInstance();
          } else {
            _navigation = 'Walkthrough';
          }
        });
      });
    });
  }

  Future<void> getInstance() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.getString('empNo') != null) {
      _navigation = 'Dashboard';
    } else {
      _navigation = 'LoginScreen';
    }
  }

  void navigation() {
    if (_navigation != null) {
      if (_navigation == 'Dashboard') {
        Navigator.of(_context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => Dashboard()));
      } else if (_navigation == 'LoginScreen') {
        Navigator.of(_context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => LoginScreen()));
      } else {
        Navigator.of(_context).pushReplacement(MaterialPageRoute(
            builder: (ctx) => WalkthroughScrreen(
                  lstSplash: _lstSplash,
                  updateLink: linkUpdate,
                )));
      }
    }
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
    notifyListeners();
  }

  List<String> _titles = ["Build Better", "Listen Better", "Plan Better"];

  List<String> get titles => _titles;
  List<String> _subTitles = [
    "If you don't build your dream someone else will hire you to help build theirs.",
    "Listen with curiosity. Speak with honesty. Act with integrity. The greatest problem with communication is we don’t listen to understand.",
    "Nobody panics when things go “according to plan”. Even if the plan is horrifying!"
  ];

  List<String> get subTitles => _subTitles;

  String _icListen = ic_listen;

  String get icListen => _icListen;

  String _icBuild = ic_build;

  String get icBuild => _icBuild;

  String _icPlan = ic_plan;

  String get icPlan => _icPlan;
}
