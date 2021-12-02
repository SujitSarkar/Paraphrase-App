import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StVariables{

  static var portraitMood =SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  static var landscapeMood =SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);

   //static const Color themeColor=Colors.blue;

  static final appTheme= ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'openSans',
      backgroundColor: Colors.white,
      canvasColor: Colors.transparent,
      textTheme:const TextTheme(
        headline1:TextStyle(fontFamily: "openSans"),
        headline2:TextStyle(fontFamily: "openSans"),
        headline3:TextStyle(fontFamily: "openSans"),
        headline4:TextStyle(fontFamily: "openSans"),
        headline5:TextStyle(fontFamily: "openSans"),
        headline6:TextStyle(fontFamily: "openSans"),
        subtitle1:TextStyle(fontFamily: "openSans"),
        subtitle2:TextStyle(fontFamily: "openSans"),
        bodyText1:TextStyle(fontFamily: "openSans"),
        bodyText2:TextStyle(fontFamily: "openSans"),
        caption:TextStyle(fontFamily: "openSans"),
        button:TextStyle(fontFamily: "openSans"),
        overline:TextStyle(fontFamily: "openSans"),
      ));

  static const List<Color> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.pink];

  static final Color textColor = Colors.grey.shade900;
  static const String appName= 'The Fast Paraphrase';

}