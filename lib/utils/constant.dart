import 'package:flutter/material.dart';

class Constants {
  static const appName = "Chat App";
  static const mainUrl = "https://swapi.dev/api/";
  static const realtimeDbUrl =
      "https://interviewing-f4e2d-default-rtdb.europe-west1.firebasedatabase.app/";
  static const splashScreen = "/";
  static const registrationScreen = "/registrationScreen";
  static const loginScreen = "/logInScreen";
  static const landingScreen = "/landingScreen";
  static const chatScreen = "/chatScreen";

  static const kSendButtonTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  static const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    border: InputBorder.none,
  );

  static const kMessageContainerDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.black, width: 2.0),
    ),
  );

  static const kInputDecoration = InputDecoration(
    hintText: 'Enter your password.',
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );
}
