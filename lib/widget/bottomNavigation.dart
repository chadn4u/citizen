import 'package:citizens/utils/colors.dart';
import 'package:citizens/utils/const.dart';
import 'package:citizens/widget/bubbleBottomBar.dart';
import 'package:flutter/material.dart';

class T5BottomBar extends StatefulWidget {
  static String tag = '/T5BottomBar';
  @override
  T5BottomBarState createState() => T5BottomBarState();
}
class T5BottomBarState extends State<T5BottomBar> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      opacity: .2,
      currentIndex: currentIndex,
      elevation: 8,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      //new
      hasNotch: false,
      //new
      hasInk: true,
      //new, gives a cute ink effect
      inkColor: colorPrimaryLight,
      //optional, uses theme color if not specified
      items: <BubbleBottomBarItem>[
        tab(optionsIcon, 'Home'),
        tab(optionsIcon, 'List'),
      ],
    );
  }
}