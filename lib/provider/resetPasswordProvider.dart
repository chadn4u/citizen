import 'package:citizens/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPasswordProvider with ChangeNotifier {
  bool _employeeIdSelected = true;
  bool _employeeNmSelected = false;
  bool _isSearch = false;

  Color get colorEmployeeId =>
      (_employeeIdSelected) ? colorPrimary : Colors.grey[800];
  Color get colorEmployeeNm =>
      (_employeeNmSelected) ? colorPrimary : Colors.grey[800];

  bool get isSelectedEmpId => _employeeIdSelected;
  set isSelectedEmpId(bool value) {
    if (_employeeNmSelected) _employeeNmSelected = false;

    _employeeIdSelected = value;
    notifyListeners();
  }

  bool get isSelectedEmpNm => _employeeNmSelected;
  set isSelectedEmpNm(bool value) {
    if (_employeeIdSelected) _employeeIdSelected = false;

    _employeeNmSelected = value;
    notifyListeners();
  }

  bool get isSearch => _isSearch;
  set isSearch(bool value){
    _isSearch = value;
    notifyListeners();
  }
  @override
  void dispose() {
    super.dispose();
  }
}
