
import 'dart:ui';

import 'package:flutter/material.dart';

class Utils{
  String getFirstLetter(String name){
    return name.substring(0, 1).toUpperCase();
  }

  Color getRandomColor(String string){
    Color colorRandom;
    switch(string){
      case 'A':
      colorRandom = Colors.blue;
      break;
      case 'B':
      colorRandom = Colors.blueAccent;
      break;
      case 'C':
      colorRandom = Colors.brown;
      break;
      case 'D':
      colorRandom = Colors.cyan;
      break;
      case 'E':
      colorRandom = Colors.cyanAccent;
      break;
      case 'F':
      colorRandom = Colors.deepOrange;
      break;
      case 'G':
      colorRandom = Colors.deepOrangeAccent;
      break;
      case 'H':
      colorRandom = Colors.deepPurple;
      break;
      case 'I':
      colorRandom = Colors.deepPurpleAccent;
      break;
      case 'J':
      colorRandom = Colors.green;
      break;
      case 'K':
      colorRandom = Colors.greenAccent;
      break;
      case 'L':
      colorRandom = Colors.indigo;
      break;
      case 'M':
      colorRandom = Colors.indigoAccent;
      break;
      case 'N':
      colorRandom = Colors.lightBlue;
      break;
      case 'O':
      colorRandom = Colors.lightBlueAccent;
      break;
      case 'P':
      colorRandom = Colors.lime;
      break;
      case 'Q':
      colorRandom = Colors.orangeAccent;
      break;
      case 'R':
      colorRandom = Colors.teal;
      break;
      case 'S':
      colorRandom = Colors.pink;
      break;
      case 'T':
      colorRandom = Colors.tealAccent;
      break;
      case 'U':
      colorRandom = Colors.limeAccent;
      break;
      case 'V':
      colorRandom = Colors.pinkAccent;
      break;
      case 'W':
      colorRandom = Colors.purple;
      break;
      case 'X':
      colorRandom = Colors.purpleAccent;
      break;
      case 'Y':
      colorRandom = Colors.red;
      break;
      case 'Z':
      colorRandom = Colors.tealAccent;
      break;
    }
    return colorRandom;
  }
}