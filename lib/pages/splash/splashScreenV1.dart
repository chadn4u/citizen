import 'package:citizens/provider/splas/splashScreenProvider.dart';
import 'package:citizens/utils/behavior.dart';
import 'package:citizens/utils/const.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citizens/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  final String linkUpdate;

  const SplashScreen({Key key, this.linkUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
    BuildContext ctx1;
    int pageLength;

    SplashScreenProvider splashScreenProvider;
    pageLength = 3;
    splashScreenProvider = SplashScreenProvider();
    splashScreenProvider.linkUpdate = linkUpdate;
    splashScreenProvider.init(context);
    return ChangeNotifierProvider(
      create: (context) => splashScreenProvider,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Consumer<SplashScreenProvider>(
                  builder: (context, value, child) {
                return ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: PageView(
                    children: <Widget>[
                      WalkThrough(
                        textContent: value.icBuild,
                      ),
                      WalkThrough(
                        textContent: value.icListen,
                      ),
                      WalkThrough(
                        textContent: value.icPlan,
                      ),
                    ],
                    onPageChanged: (values) {
                      value.currentIndexPage = values;
                    },
                  ),
                );
              }),
            ),
            Consumer<SplashScreenProvider>(builder: (context, value, child) {
              return Container(
                child: Positioned(
                  width: MediaQuery.of(context).size.width,
                  top: MediaQuery.of(context).size.height * 0.43,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: new DotsIndicator(
                            dotsCount: 3,
                            position: value.currentIndexPage,
                            decorator: DotsDecorator(
                              color: inactivedot_color,
                              activeColor: colorPrimary,
                            )),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(value.titles[value.currentIndexPage],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: fontMedium,
                                      color: colorPrimary)),
                              SizedBox(height: 16),
                              Center(
                                  child: Text(
                                value.subTitles[value.currentIndexPage],
                                style: TextStyle(
                                    fontFamily: fontRegular,
                                    fontSize: 18,
                                    color: t3_textColorSecondary),
                                textAlign: TextAlign.center,
                              )),
                              SizedBox(height: 50),
                            ],
                          )),
                      (!value.doneCheckPerm || !value.doneCheckUpd)
                          ? Container(
                              child: CircularProgressIndicator(),
                            )
                          : Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 100,
                                child: RaisedButton(
                                  textColor: Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(80.0),
                                          topLeft: Radius.circular(80.0))),
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: <Color>[
                                            colorGradientYT1,
                                            colorGradientYT2,
                                            colorGradientYT3
                                          ]),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(80.0),
                                          topLeft: Radius.circular(80.0)),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          "Skip",
                                          style: TextStyle(fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    value.navigation();
                                  },
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class WalkThrough extends StatelessWidget {
  final String textContent;

  WalkThrough({Key key, @required this.textContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: Image.asset(
        textContent,
        width: 280,
        height: (MediaQuery.of(context).size.height) / 2.3,
      ),
    );
  }
}
