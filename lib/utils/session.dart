

import 'package:shared_preferences/shared_preferences.dart';

class Session {
  SharedPreferences prefs;

  addToString(String index, String value) async{
    prefs = await SharedPreferences.getInstance();
    print('session nih yee $index $value');
    prefs.setString(index, value);
  }
  addToInt(String index, int value) async{
    prefs = await SharedPreferences.getInstance();
    prefs.setInt(index, value);
  }
  addToBool(String index, bool value) async{
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(index, value);
  }
  addToDouble(String index, double value) async{
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(index, value);
  }


  Future<String> getStringVal(String index) async{
    prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(index);
    
    //print('session nih yee pas gw get ${prefs.getString(index)}');
    return stringValue;
  }
  Future<int> getIntVal(String index) async{
    prefs = await SharedPreferences.getInstance();
    //Return String
    int stringValue = prefs.getInt(index);
    return stringValue;
  }
  Future<bool> getBoolVal(String index) async{
    prefs = await SharedPreferences.getInstance();
    //Return String
    bool stringValue = prefs.getBool(index);
    return stringValue;
  }
  Future<double> getDoubleVal(String index) async{
    prefs = await SharedPreferences.getInstance();
    //Return String
    double stringValue = prefs.getDouble(index);
    return stringValue;
  }

  removeSession(String index) async{
    prefs = await SharedPreferences.getInstance();
    prefs.remove("stringValue");
  }

}