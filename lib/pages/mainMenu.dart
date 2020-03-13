import 'package:citizens/pages/list/list.dart';
import 'package:citizens/pages/loginpages.dart';
import 'package:citizens/utils/mainUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'newUser/newUserMain.dart';

class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String name, corp, empId, jobCde, strCd, allCorp,directorat = "";
  Utils utils = Utils();

  Future _checkSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref;
  }

  Future _logout(page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.commit();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> page));
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => page ));
  }

  DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 3)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Press Back again to exit', toastLength: Toast.LENGTH_SHORT);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();

    // _checkSession().then((pref) {
    //   setState(() {
    //     name = pref.getString('empNm');
    //     empId = pref.getString('empNo');
    //     corp = pref.getString('corpFg');
    //     jobCde = pref.getString('jobCd');
    //     strCd = pref.getString('strCd');
    //     allCorp = pref.getString('allCorp');
    //   });
    // });
    // print(empId);
  }

  _top() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.blue[900],
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(80),
              bottomLeft: Radius.circular(80))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RoundedLetter(
            text: utils.getFirstLetter(name),
            shapeColor: Utils().getRandomColor(Utils().getFirstLetter(name)),
            shapeType: ShapeType.circle,
            borderColor: Colors.white,
            borderWidth: 2,
          ),
          // ClipOval(
          //   child: Material(
          //     color: Colors.white, // button color
          //     child: InkWell(
          //       splashColor: Colors.blue[900], // inkwell color
          //       child:
          //           SizedBox(width: 56, height: 56, child: Icon(Icons.person)),
          //       onTap: () {},
          //     ),
          //   ),
          // ),
          SizedBox(height: 12),
          Text(
            name == null ? 'NULL' : name,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                corp == '06' ? 'LSI' : 'LMI',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                empId == null ? 'NULL' : empId,
                style: TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }

  _middle() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.blue[900],
          boxShadow: [
            BoxShadow(
                color: Colors.blue[900], blurRadius: 20, offset: Offset(0, 10))
          ]),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(22),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 3 / 3),
        children: <Widget>[
          _gridItem(
              Icons.list,
              'List',
              ListData(
                corpFg: corp,
                strCd: strCd,
                jobCd: jobCde,
                empNo: empId,
              )),
          _gridItem(
              Icons.fiber_new,
              'New User',
              NewUserMain(
                corpFg: corp,
                strCd: strCd,
                jobCd: jobCde,
                empNo: empId,
                directorat: directorat,
                allCorp:allCorp
              )),
          _gridItem(Icons.leak_add, 'Mutation', null),
          _gridItem(Icons.settings_power, 'Resignation', null),
          _gridItem(Icons.computer, 'IT Process', null),
          _gridItem(Icons.developer_mode, 'Repairing', null),
          _gridItem(Icons.desktop_mac, 'Monitoring', null),
          _gridItem(Icons.exit_to_app, 'Logout', LoginPages()),
        ],
      ),
    );
  }

  _gridItem(image, menuName, page) {
    return Column(
      children: <Widget>[
        ClipOval(
          child: Material(
            color: Colors.white, // button color
            child: InkWell(
              splashColor: Colors.blue[900], // inkwell color
              child: SizedBox(width: 44, height: 44, child: Icon(image)),
              onTap: () {
                if (page != null) {
                  if (menuName == "Logout") {
                    _logout(page);
                  } else {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => page));
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text("Belum Ada Menu nya"),
                        content: new Text("Menu nye Kage Ade"),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          menuName,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue[900]);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: FutureBuilder(
            future: _checkSession(),
            builder: (BuildContext ctx, AsyncSnapshot data) {
              if (data.data == null) {
                return Center(
                  child: Text(data.error.toString()),
                );
              } else {
                name = data.data.getString('empNm');
                empId = data.data.getString('empNo');
                corp = data.data.getString('corpFg');
                jobCde = data.data.getString('jobCd');
                strCd = data.data.getString('strCd');
                allCorp = data.data.getString('allCorp');
                directorat = data.data.getString('directorat');
                return ListView(
                  children: <Widget>[_top(), _middle()],
                );
              }
            }),
      ),
    );
  }
}
