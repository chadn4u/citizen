import 'package:citizens/utils/colors.dart';
import 'package:citizens/utils/const.dart';
import 'package:citizens/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class WalkthroughScrreen extends StatefulWidget {
  static String tag = '/T6WalkThrough';

  @override
  WalkthroughScrreenState createState() => WalkthroughScrreenState();
}

class WalkthroughScrreenState extends State<WalkthroughScrreen> {
  int currentIndexPage = 0;
  int pageLength;

  var titles = [
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.This is simply text ",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.This is simply text  ",
  ];

  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;
    pageLength = 2;
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              // Container(
              //   alignment: Alignment.topRight,
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: text("Skip",textAllCaps: true,textColor: textColorPrimary,fontFamily: fontMedium),
              //     )
              // ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: PageView(
                  children: <Widget>[
                    WalkThrough(textContent: updateImage,title: 'Ini Test',),
                    WalkThrough(textContent: storageImage,title: 'Ini Test',),
                  ],
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
                          dotsCount: 2,
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
}

class WalkThrough extends StatelessWidget {
  final String textContent;
  final String title;

  WalkThrough({Key key, @required this.textContent,@required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var  h= MediaQuery.of(context).size.height;

    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              textContent,
              height: (MediaQuery.of(context).size.height) / 2.5,
            ),
          ),
          SizedBox(height: h*0.08,),
          Container(
            margin: EdgeInsets.only(left: 30,right: 30),
            child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: textSizeLargeMedium,
                      color: textColorSecondary),
                  textAlign: TextAlign.center,
                )),
          ),
        ButtonWalkthrough(textContent: 'wadaw', onPressed: () {},),
        ],
      ),
    );
  }
}
