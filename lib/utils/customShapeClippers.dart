
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height*0.8);
    path.quadraticBezierTo(size.width / 4, size.height * 0.6, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width/4), size.height * 0.6, size.width, size.height*0.8);
    path.lineTo(size.width, 0);

    // var firstEndPoint = Offset(size.width * .5,size.height - 20);
    // var firstControlPoint = Offset(size.width * 0.25,size.height - 80);
    // path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    // var secondEndPoint = Offset(size.width,size.height - 80);
    // var secondControlPoint = Offset(size.width * .75,size.height - 10);
    // path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    // path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper)=> true;

}