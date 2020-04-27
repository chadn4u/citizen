import 'package:citizens/pages/splash/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreenProvider with ChangeNotifier {
  List<Permission> _lsPermission = [Permission.storage, Permission.location];
  List<SplashScreenModel> _lstSplash = [];
  bool _isUpdate = false;
  bool _endCheck = false;
  bool _firstRun = true;

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

  void runCheck() async {
    setCurrentStatus('Checking permission....');
    notifyListeners();

    Future.delayed(Duration(seconds: 1), () async {
      for (int i = 0; i < _lsPermission.length; i++) {
        if (!await _lsPermission[i].request().isUndetermined) {
          _lstSplash.add(SplashScreenModel(_lsPermission[i], 0));
        }
      }
      _doneCheckPerm = true;
      notifyListeners();
    });

    if (_isUpdate) {
      Future.delayed(Duration(seconds: 3), () {
        setCurrentStatus('Checking updates....');
        notifyListeners();
        Future.delayed(Duration(seconds: 1), () {
          _lstSplash.add(SplashScreenModel('Updates', 1));
          notifyListeners();
        });
      });
      _doneCheckUpdate = true;
      notifyListeners();
    }else{
      _doneCheckUpdate = true;
      notifyListeners();
    }

    
  }
  // @override
  // void dispose(){
  //   super.dispose();
  // }
}
