import 'package:citizens/pages/dashboard/dashboard.dart';
import 'package:citizens/pages/list/list.dart';
import 'package:citizens/pages/newUser/newUserMain.dart';
import 'package:citizens/pages/repairing/repairing.dart';
import 'package:citizens/utils/colors.dart';
import 'package:citizens/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:citizens/widget/carouselSlider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

changeStatusColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        useWhiteForeground(color));
  } on Exception catch (e) {
    print(e);
  }
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

class EditText extends StatefulWidget {
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var hint;
  var maxLine;
  TextEditingController mController;

  VoidCallback onPressed;

  EditText(
      {var this.fontSize = textSizeNormal,
      var this.textColor = textColorSecondary,
      var this.fontFamily = fontRegular,
      var this.isPassword = true,
      var this.hint = "",
      var this.isSecure = false,
      var this.text = "",
      var this.mController,
      var this.maxLine = 1});

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.mController,
      obscureText: widget.isPassword,
      style: TextStyle(fontSize: textSizeLargeMedium, fontFamily: fontRegular),
      decoration: InputDecoration(
        suffixIcon: widget.isSecure
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.isPassword = !widget.isPassword;
                  });
                },
                child: new Icon(widget.isPassword
                    ? Icons.visibility
                    : Icons.visibility_off),
              )
            : null,
        contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        hintText: widget.hint,
        hintStyle: TextStyle(color: textColorThird),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: viewColor, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: viewColor, width: 0.0),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return null;
  }
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

class T5SliderWidget extends StatelessWidget {
  List<SliderDashboard> mSliderList;
  T5SliderWidget(this.mSliderList);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final Size cardSize = Size(width, width / 1.8);
    return CarouselSlider(
      viewportFraction: 0.9,
      height: cardSize.height,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      items: mSliderList.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: cardSize.height,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    slider.image,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: cardSize.height,
                  ),
                  Padding(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          text(
                            slider.accountNo,
                            textColor: colorWhite,
                            fontSize: textSizeMedium,
                          ),
                          text(slider.balance,
                              textColor: colorWhite,
                              fontSize: textSizeLarge,
                              fontFamily: fontBold)
                        ],
                      ),
                      padding: EdgeInsets.all(14)),
                  Container(
                    padding: EdgeInsets.all(14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              text(
                                slider.accountNo,
                                textColor: colorWhite,
                                fontSize: textSizeMedium,
                              ),
                              text(slider.accountNo,
                                  textColor: colorWhite,
                                  fontSize: textSizeNormal)
                            ],
                          ),
                        ),
                        text("VISA",
                            textColor: colorWhite,
                            fontSize: textSizeLarge,
                            fontFamily: fontBold)
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class GridListing extends StatelessWidget {
  List<CategoryList> mFavouriteList;
  var isScrollable = false;

  GridListing(this.mFavouriteList, this.isScrollable);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
        scrollDirection: Axis.vertical,
        physics:
            isScrollable ? ScrollPhysics() : NeverScrollableScrollPhysics(),
        itemCount: mFavouriteList.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (mFavouriteList[index].page != null) {
                if (mFavouriteList[index].name == "More") {
                  DashboardSession dashboardSession =
                      mFavouriteList[index].page;
                  showSheet(
                      context,
                      dashboardSession.corp,
                      dashboardSession.strCd,
                      dashboardSession.jobCde,
                      dashboardSession.empId,
                      dashboardSession.directorat,
                      dashboardSession.allCorp);
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => mFavouriteList[index].page));
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
            child: Container(
              alignment: Alignment.center,
              decoration: boxDecoration(
                  radius: 10, showShadow: true, bgColor: colorWhite),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: width / 7.5,
                    width: width / 7.5,
                    margin: EdgeInsets.only(bottom: 4, top: 8),
                    padding: EdgeInsets.all(width / 30),
                    decoration: boxDecoration(
                        bgColor: mFavouriteList[index].color, radius: 10),
                    child: Icon(
                      mFavouriteList[index].icon,
                      color: colorWhite,
                    ),
                  ),
                  text(mFavouriteList[index].name, fontSize: textSizeMedium)
                ],
              ),
            ),
          );
        });
  }
}

showSheet(BuildContext aContext, var corp, var strCd, var jobCde, var empId,
    var directorat, var allCorp) {
  List<CategoryList> mFavouriteList = [
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
    CategoryList('Repairing', cat6, Icons.developer_mode, RepairingPages(
                          corpFg: corp,
                          strCd: strCd,
                          jobCd: jobCde,
                          empNo: empId,
                          directorat: directorat,
                          allCorp: allCorp)),
    CategoryList('Monitoring', cat1, Icons.desktop_mac, null),
  ];
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: aContext,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
            initialChildSize: 0.65,
            maxChildSize: 1,
            minChildSize: 0.5,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: EdgeInsets.only(top: 24),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: layoutBackgroundWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  children: <Widget>[
                    Container(
                      color: viewColor,
                      width: 50,
                      height: 3,
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: GridListing(mFavouriteList, true),
                      ),
                    )
                  ],
                ),
              );
            });
      });
}
