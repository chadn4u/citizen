import 'package:citizens/pages/dashboard/dashboard.dart';
import 'package:citizens/pages/login/loginPagesV2.dart';
import 'package:citizens/pages/splash/splashScreen.dart';
import 'package:citizens/pages/updates/updatePages.dart';
import 'package:citizens/utils/colors.dart';
import 'package:citizens/utils/const.dart';
import 'package:citizens/utils/extensions.dart';
import 'package:citizens/widget/newUser/button4.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalkthroughScrreen extends StatefulWidget {
  final List<SplashScreenModel> lstSplash;
  final String updateLink;

  static String tag = '/T6WalkThrough';

  WalkthroughScrreen({Key key, this.lstSplash,this.updateLink}) : super(key: key);

  @override
  WalkthroughScrreenState createState() => WalkthroughScrreenState();
}

class WalkthroughScrreenState extends State<WalkthroughScrreen> {
  int currentIndexPage = 0;
  int pageLength;
  bool _doneCheckPerm = false;
  bool _doneCheckUpdate = false;

  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;
    pageLength = 2;
    if (widget.lstSplash == null) {
      routes();
    }
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () async {
                      int count = 0;
                      String update;
                      for (int i = 0; i < widget.lstSplash.length; i++) {
                        if (widget.lstSplash[i].typeChecking is Permission) {
                          Permission perm = widget.lstSplash[i].typeChecking;
                          if (!await perm.isGranted) count++;
                        } else {
                          update = widget.lstSplash[i].typeChecking;
                        }
                      }
                      if (count == widget.lstSplash.length) {
                        routes();
                      } else if (count == 0) {
                        if (update != null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => CustomDialogWT(
                              textDialog: 'You need to update the apps',
                            ),
                          );
                        } else {
                          routes();
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialogWT(
                            textDialog: 'You need to grant all Permissions',
                          ),
                        );
                      }
                    },
                    child: text("Skip",
                        textAllCaps: true,
                        textColor: textColorPrimary,
                        fontFamily: fontMedium)),
              )),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PageView.builder(
              itemBuilder: (ctx, index) {
                return WalkThrough(splashScreenModel: widget.lstSplash[index],updateLink: widget.updateLink,);
              },
              itemCount: widget.lstSplash.length,
              onPageChanged: (value) {
                setState(() => currentIndexPage = value);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  child: new DotsIndicator(
                      dotsCount: (widget.lstSplash == null)?0:widget.lstSplash.length,
                      position: currentIndexPage,
                      decorator: DotsDecorator(
                        color: viewColor,
                        activeColor: t6colorPrimary,
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  void routes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('empNo').isEmpty) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => LoginScreen()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => DashBoard()));
    }
  }
}

class WalkThrough extends StatelessWidget {
  // final String textContent;
  // final String title;
  final SplashScreenModel splashScreenModel;
  final String updateLink;

  WalkThrough({Key key, @required this.splashScreenModel,this.updateLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              splashScreenModel.imageLoc,
              height: (MediaQuery.of(context).size.height) / 2.5,
            ),
          ),
          SizedBox(
            height: h * 0.08,
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Center(
                child: Text(
              splashScreenModel.title,
              style: TextStyle(
                  fontSize: textSizeLargeMedium, color: textColorSecondary),
              textAlign: TextAlign.center,
            )),
          ),
          SizedBox(
            height: h * 0.1,
          ),
          (splashScreenModel.typeChecking is Permission)
              ? ButtonWalkthrough(
                  textContent:
                      (splashScreenModel.typeChecking == Permission.storage)
                          ? 'Grant'
                          : 'Grant',
                  onPressed: () async {
                    Permission perm = splashScreenModel.typeChecking;
                    if (await perm.isPermanentlyDenied) {
                      openAppSettings();
                    } else {
                      perm.request();
                    }
                  },
                )
              : ButtonWalkthrough(
                  textContent: 'Update apps',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => UpdatePages(updateLink: updateLink,)));
                  },
                ),
        ],
      ),
    );
  }
}

class CustomDialogWT extends StatelessWidget {
  final String textDialog;

  const CustomDialogWT({Key key, this.textDialog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContentWT(context, textDialog),
    );
  }
}

dialogContentWT(BuildContext context, String textDialog) {
  return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          text("$textDialog!",
              fontSize: textSizeLargeMedium,
              maxLine: 2,
              isCentered: true,
              textColor: textColorPrimary,
              fontFamily: fontSemibold),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              T4Button(
                textContent: 'Ok',
                isStroked: true,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ));
}
