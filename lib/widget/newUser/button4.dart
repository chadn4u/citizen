import 'package:citizens/utils/colors.dart';
import 'package:citizens/utils/const.dart';
import 'package:citizens/utils/extensions.dart';
import 'package:flutter/material.dart';

class T4Button extends StatefulWidget {
  static String tag = '/T4Button';
  var textContent;
  VoidCallback onPressed;
  var isStroked=false;
  var height=50.0;

  T4Button({@required this.textContent, @required this.onPressed,this.isStroked=false,this.height=45.0});
  @override
  T4ButtonState createState() => T4ButtonState();
}
class T4ButtonState extends State<T4Button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height,
        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
        alignment: Alignment.center,
        child: text(widget.textContent,textColor: widget.isStroked?colorPrimary:colorWhite,isCentered: true,fontFamily: fontMedium,textAllCaps: true),
        decoration: widget.isStroked?boxDecoration(bgColor: Colors.transparent,color: colorPrimary):boxDecoration(bgColor: colorPrimary,radius: 4),
      ),
    ) ;
  }
}