import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppTheme {
  AppTheme._();

  static const Color blue = Color(0xFF0e76a8);
  static const Color blueAccent = Color(0xFF0D47A1);
  static const Color grey = Color(0xCCCCCC);
  static const Color lightBlue = Color(0xFF0277BD);
  static const Color darkRed = Color(0xFF990000);
  static const Color whiteBlue = Color(0xFFE3F2FD);
  static const Color yellow = Color(0xFFFBC02D);
  static const Color orange = Color(0xFFDC8822);
  static const appBarColor = Color(0xFF00151C);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color semiLightGrey = Color(0xFFDFDEDE);

  final appBackgroundColor = Colors.grey[900];

  static MaterialColor appColorSelector = MaterialColor(
    0xFF0e76a8,
    <int, Color>{
      50: Colors.orange[50],
      100: Colors.orange[100],
      200: Colors.orange[200],
      300: Colors.orange[300],
      400: Colors.orange[400],
      500: Colors.orange[500],
      600: Colors.orange[600],
      700: Colors.orange[700],
      800: Colors.orange[800],
      900: Colors.orange[900],
    },
  );
  static MaterialColor blackColorSelector = MaterialColor(
    0xFF0e76a8,
    <int, Color>{
      100: Colors.black12,
      200: Colors.black26,
      300: Colors.black38,
      400: Colors.black45,
      500: Colors.black54,
      600: Colors.black87,
      700: Colors.black,
    },
  );

  static const String fontName = "Roboto";
  static const Color darkText = Colors.black;
  static const Color greyText = Colors.grey;
  static const Color whiteText = Colors.white;

  static const TextTheme textTheme = TextTheme(
    headline4: headline4,
    headline3: headline,
    headline2: headline6,
    headline1: headline1,
    subtitle2: subtitle2,
    bodyText1: bodyText1,
    bodyText2: bodyText2,
    caption: caption,
    subtitle1: subtitle1,
  );

  static const TextStyle headline1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 25,
    color: whiteText,
  );

  static const TextStyle headline4 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontSize: 20,
    color: darkText,
  );

  static const TextStyle headline6 = TextStyle(
      fontFamily: fontName,
      fontSize: 16,
      color: darkText,
      fontWeight: FontWeight.normal);

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle bodyText2 = TextStyle(
      fontFamily: fontName,
      fontSize: 14,
      color: darkText,
      fontWeight: FontWeight.normal);

  static const TextStyle bodyText1 = TextStyle(
      fontFamily: fontName,
      fontSize: 16,
      color: darkText,
      fontWeight: FontWeight.normal);

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: appBarColor, // was lightText
  );

  static const TextStyle subtitle1 = TextStyle(
      fontFamily: fontName,
      fontSize: 16,
      color: appBarColor, // was lightText
      fontWeight: FontWeight.normal);

  //  static final TextStyle shipmentCardTitle = TextStyle(
  //    color: Colors.black,
  //    fontSize: 15,
  //  );

}
