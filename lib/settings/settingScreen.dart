import 'package:citizens/pages/login/loginPagesV2.dart';
import 'package:citizens/utils/colors.dart';
import 'package:citizens/utils/const.dart';
import 'package:citizens/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:citizens/sqlite/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  final String empId;
  final String empNm;
  final String passw;

  const SettingScreen({Key key, this.empId, this.empNm, this.passw})
      : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state.toString());
    if (state == AppLifecycleState.resumed) {
      print(state.toString());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBgSettings,
      appBar: AppBar(
        title: text('Settings',
            fontSize: textSizeLargeMedium, fontFamily: fontMedium),
        leading: Icon(
          Icons.arrow_back,
          color: colorSettings,
          size: 30,
        ).onTap(() {
          Navigator.of(context).pop();
        }),
        centerTitle: true,
        backgroundColor: colorBgSettings,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: boxDecoration(
                        bgColor: colorWhite, radius: 8, showShadow: true),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: <Widget>[
                        FutureBuilder(
                          future: DbHelper().getSingleData(widget.empId),
                          builder: (ctx, snapshot) {
                            if (snapshot.data != null)
                              return quizSettingOptionPattern2(
                                  Icons.fingerprint,
                                  'FingerPrint Auth',
                                  true,
                                  widget.empId,
                                  widget.empNm,
                                  widget.passw);
                            else
                              return quizSettingOptionPattern2(
                                  Icons.fingerprint,
                                  'FingerPrint Auth',
                                  false,
                                  widget.empId,
                                  widget.empNm,
                                  widget.passw);
                          },
                        ),
                        quizSettingOptionPattern1('Face Recognition',
                            widget.empId, widget.empNm, widget.passw)
                      ],
                    ),
                  ),
                  Container(
                    decoration: boxDecoration(
                        bgColor: colorWhite, radius: 8, showShadow: true),
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: <Widget>[
                        quizSettingOptionPattern3(Icons.help, 'Help Center')
                            .onTap(() {
                          // setState(() {
                          //   launchScreen(context, QuizHelpCenter.tag);
                          // });
                        }),
                        quizSettingOptionPattern3(
                            Icons.security, 'Privacy & Terms'),
                        quizSettingOptionPattern3(
                                Icons.chat_bubble, 'Contact Us')
                            .onTap(() {
                          // setState(() {
                          //   launchScreen(context, QuizContactUs.tag);
                          // });
                        }),
                      ],
                    ),
                  ),
                  text('Logout',
                          textColor: colorSettings,
                          fontSize: textSizeLargeMedium,
                          textAllCaps: true,
                          fontFamily: fontBold)
                      .onTap(() async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    prefs.commit();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  })
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
