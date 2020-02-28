import 'package:citizens/pages/list/list.dart';
import 'package:citizens/pages/loginpages.dart';
import 'package:citizens/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String name, corp, empId = "";

  Future _checkSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString('empNm');
      empId = pref.getString('empNo');
      corp = pref.getString('corpFg');
    });
  }

  Future _logout(page)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  prefs.commit();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => page ));
  }

  @override
  void initState() {
    super.initState();

    _checkSession();
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
          ClipOval(
            child: Material(
              color: Colors.white, // button color
              child: InkWell(
                splashColor: Colors.blue[900], // inkwell color
                child:
                    SizedBox(width: 56, height: 56, child: Icon(Icons.person)),
                onTap: () {},
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            name == null? 'NULL':name,
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
                empId== null? 'NULL':empId,
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
          _gridItem(Icons.list, 'List',ListData()),
          _gridItem(Icons.fiber_new, 'New User',null),
          _gridItem(Icons.leak_add, 'Mutation',null),
          _gridItem(Icons.settings_power, 'Resignation',null),
          _gridItem(Icons.computer, 'IT Process',null),
          _gridItem(Icons.developer_mode, 'Repairing',null),
          _gridItem(Icons.desktop_mac, 'Monitoring',null),
          _gridItem(Icons.exit_to_app, 'Logout',LoginPages()),
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
                if (menuName == "List")
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => page ));
                else if (menuName == "Logout") {
                  _logout(page);
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
    return Scaffold(
      body: ListView(
        children: <Widget>[_top(), _middle()],
      ),
    );
  }
}
