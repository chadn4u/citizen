import 'package:citizens/pages/list/list.dart';
import 'package:citizens/pages/login/loginPagesV2.dart';
import 'package:citizens/pages/newUser/newUserMain.dart';
import 'package:citizens/settings/settingScreen.dart';
import 'package:citizens/utils/colors.dart';
import 'package:citizens/utils/const.dart';
import 'package:citizens/utils/extensions.dart';
import 'package:citizens/utils/mainUtils.dart';
import 'package:citizens/widget/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String name, corp, empId, jobCde, strCd, allCorp, directorat, passw = "";
  Utils utils = Utils();

  Future _checkSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref;
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

  List<CategoryList> mFavouriteList;
  List<SliderDashboard> mSliderList;
  List<Choice> choices;
  Choice _selectedChoice; // The app's "state".

  Future _logout(page, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.commit();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> page));
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => page ));
  }

  void _select(Choice choice) {
    if (choice.title == 'Settings') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingScreen(empId: empId,empNm: name,passw: passw)));
    } else if (choice.title == 'Logout') {
      _logout(LoginScreen(), context);
    }
  }

  @override
  void initState() {
    super.initState();

    choices = const <Choice>[
      const Choice(title: 'Settings', icon: Icons.settings),
      const Choice(title: 'Logout', icon: Icons.exit_to_app),
    ];
    _selectedChoice = choices[0]; // The app's "state".
    mSliderList = [
      SliderDashboard(
          "assets/images/t5_bg_card_2.png", "20000", "200 0000 293829 992")
    ];
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(colorPrimary);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: colorPrimary,
        key: _scaffoldKey,
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
                passw = data.data.getString('passw');

                mFavouriteList = [
                  CategoryList(
                      'List',
                      cat1,
                      Icons.list,
                      ListData(
                        corpFg: corp,
                        strCd: strCd,
                        jobCd: jobCde,
                        empNo: empId,
                      )),
                  CategoryList(
                      'New User',
                      cat2,
                      Icons.fiber_new,
                      NewUserMain(
                          corpFg: corp,
                          strCd: strCd,
                          jobCd: jobCde,
                          empNo: empId,
                          directorat: directorat,
                          allCorp: allCorp)),
                  CategoryList('Mutation', cat3, Icons.leak_add, null),
                  CategoryList('Resign', cat4, Icons.settings_power, null),
                  CategoryList('IT Process', cat5, Icons.computer, null),
                  CategoryList(
                      'More',
                      cat6,
                      Icons.more,
                      DashboardSession(name, corp, empId, jobCde, strCd,
                          allCorp, directorat)),
                ];

                return _body();
              }
            }),
      ),
    );
  }

  Widget _body() {
    return SafeArea(
        child: Stack(
      children: <Widget>[
        Container(
          height: 70,
          margin: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  RoundedLetter(
                    text: utils.getFirstLetter(name),
                    shapeColor:
                        Utils().getRandomColor(Utils().getFirstLetter(name)),
                    shapeType: ShapeType.circle,
                    borderColor: Colors.white,
                    borderWidth: 2,
                  ),
                  SizedBox(width: 16),
                  text(name,
                      textColor: colorWhite,
                      fontSize: textSizeNormal,
                      fontFamily: fontMedium)
                ],
              ),
              PopupMenuButton<Choice>(
                onSelected: _select,
                itemBuilder: (BuildContext context) {
                  return choices.map((Choice choice) {
                    return PopupMenuItem<Choice>(
                      value: choice,
                      child: ListTile(
                          trailing: Icon(choice.icon),
                          title: Text(choice.title)),
                    );
                  }).toList();
                },
                icon: SvgPicture.asset(
                  optionsIcon,
                  width: 25,
                  height: 25,
                  color: colorWhite,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 100),
          child: Container(
            padding: EdgeInsets.only(top: 28),
            alignment: Alignment.topLeft,
            height: MediaQuery.of(context).size.height - 100,
            decoration: BoxDecoration(
                color: layoutBackgroundWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            child: Column(
              children: <Widget>[
                T5SliderWidget(mSliderList),
                SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: GridListing(mFavouriteList, false),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class CategoryList {
  var name;
  Color color;
  IconData icon;
  var page;

  CategoryList(this.name, this.color, this.icon, this.page);
}

class DashboardSession {
  String name, corp, empId, jobCde, strCd, allCorp, directorat = "";

  DashboardSession(this.name, this.corp, this.empId, this.jobCde, this.strCd,
      this.allCorp, this.directorat);
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

class SliderDashboard {
  var image;
  var balance;
  var accountNo;

  SliderDashboard(this.image, this.balance, this.accountNo);
}
