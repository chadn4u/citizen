import 'package:animator/animator.dart';
import 'package:citizens/pages/walkthrough/walkthrough.dart';
import 'package:citizens/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:citizens/provider/splas/splashScreenProvider.dart';

class SplashScreen extends StatelessWidget {
  final String linkUpdate;

  const SplashScreen({Key key, this.linkUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashScreenProvider>(
      create: (context) => SplashScreenProvider(),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(color: colorPrimary),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/lottelogo.png',
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.width / 2.5),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Text(
                            "Lotte",
                            style: TextStyle(color: colorWhite, fontSize: 20),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<SplashScreenProvider>(
                            builder: (context, splashScreenProvider, _) {
                          if (splashScreenProvider.doneCheckPerm &&
                              splashScreenProvider.doneCheckUpd) {
                            return Animator(
                                duration: Duration(seconds: 2),
                                cycles: 0,
                                repeats: 1,
                                builder: (anim) => Transform.scale(
                                    scale: anim.value,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 35,
                                    )));
                          } else {
                            return CircularProgressIndicator(
                              backgroundColor: colorWhite,
                            );
                          }
                        }),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Consumer<SplashScreenProvider>(
                            builder: (ctx, splashScreenProvider, _) {
                          if (linkUpdate != null)
                            splashScreenProvider.isUpdate = true;
                          Future.delayed(Duration(seconds: 3), () {
                            if (splashScreenProvider.firstRun) {
                              splashScreenProvider.firstRun = false;
                              splashScreenProvider.runCheck();
                            }
                          });
                          if (splashScreenProvider.doneCheckPerm &&
                              splashScreenProvider.doneCheckUpd) {
                            Future.delayed(Duration(seconds: 1), () {
                              splashScreenProvider.currentStatus = 'Done...';
                            });

                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.pushReplacement(
                                  ctx,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          WalkthroughScrreen()));
                            });
                          }
                          return Text(splashScreenProvider.currentStatus,
                              style: TextStyle(color: colorWhite));
                        })
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SplashScreenModel {
  final dynamic typeChecking;
  final int type;

  SplashScreenModel(this.typeChecking, this.type);
}
