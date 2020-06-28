import 'package:citizens/pages/citizen/citizen.dart';
import 'package:citizens/pages/list/list.dart';
import 'package:citizens/utils/colors.dart';
import 'package:citizens/widget/dashboard/curvedNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    bottomRight: Radius.circular(90)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      colorGradientYT1,
                      colorGradientYT2,
                      colorGradientYT3
                    ])),
          ),
          Container(
            child: Column(
              children: <Widget>[
                SafeArea(
                    child: Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Richard Mario',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person,color: Colors.grey,),
                      )
                    ],
                  ),
                )),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height:
                              (MediaQuery.of(context).size.height * 0.25) * 0.5,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24)),
                                    border: Border.all(width: 0.05)),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        'Divisi',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: colorGradientYT1),
                                      ),
                                      Text(
                                        'Information Technology',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: colorGradientYT2),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(24)),
                                      border: Border.all(width: 0.05)),
                                  child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            'Email',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: colorGradientYT1),
                                          ),
                                          Text(
                                            'richard.mario@lottemart.co.id',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: colorGradientYT2),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height:
                              (MediaQuery.of(context).size.height * 0.25) * 0.5,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(24)),
                                    border: Border.all(width: 0.05)),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Center(
                                        child: getTime(), //getTime()
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(24)),
                                      border: Border.all(width: 0.05)),
                                  child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            'Sisa Cuti',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: colorGradientYT1),
                                          ),
                                          Text('8',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: colorGradientYT2)),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        runSpacing: 5,
                        spacing: 5,
                        direction: Axis.horizontal,
                        children: <Widget>[
                          CardMenu(
                            mainColor: colorGradientBtnClick1,
                            seconColor: colorGradientBtnClick2,
                            icon: Icons.list,
                            title: 'Citizen',
                            fnc: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Citizen()));
                            },
                          ),
                          CardMenu(
                              mainColor: colorGradientBtn11,
                              seconColor: colorGradientBtn12,
                              title: 'New User',
                              icon: Icons.fiber_new,
                              fnc: () {}),
                          CardMenu(
                              mainColor: colorGradientBtn21,
                              seconColor: colorGradientBtn22,
                              icon: Icons.print,
                              title: 'PrintPda',
                              fnc: () {}),
                          CardMenu(
                              mainColor: colorGradientBtn31,
                              seconColor: colorGradientBtn32,
                              title: 'Absensi',
                              icon: Icons.person,
                              fnc: () {})
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.white,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 24,
            color: colorGradientYT1,
          ),
          Icon(
            Icons.settings,
            size: 24,
            color: colorGradientYT1,
          ),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
    );
  }
}

class CardMenu extends StatelessWidget {
  final Color mainColor;
  final Color seconColor;
  final String title;
  final IconData icon;
  final Function fnc;

  const CardMenu(
      {Key key,
      this.mainColor,
      this.seconColor,
      this.title,
      this.icon,
      this.fnc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fnc,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: 140,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(24)),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  mainColor,
                  seconColor,
                ])),
        child: Stack(children: [
          // Positioned(
          //     left: 24,
          //     top: 4,
          //     child: Container(
          //       width: 45,
          //       height: 45,
          //       decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           gradient: LinearGradient(
          //               begin: Alignment.topLeft,
          //               end: Alignment.bottomRight,
          //               colors: <Color>[
          //                 mainColor,
          //                 seconColor,
          //               ])),
          //     )),
          // Positioned(
          //     right: 24,
          //     bottom: -24,
          //     child: Container(
          //       width: 45,
          //       height: 45,
          //       decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           gradient: LinearGradient(
          //               begin: Alignment.topLeft,
          //               end: Alignment.bottomRight,
          //               colors: <Color>[
          //                 mainColor,
          //                 seconColor,
          //               ])),
          //     )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 60,
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class getTime extends StatelessWidget {
  String getSystemTime() {
    var now = DateTime.now();
    return new DateFormat("HH:mm:ss").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
      return Text(
        "${getSystemTime()}",
        style: TextStyle(
            color: colorGradientYT2, fontSize: 24, fontWeight: FontWeight.w700),
      );
    });
  }
}
