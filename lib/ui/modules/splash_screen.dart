import 'dart:async';
import 'package:chat_app/data/sources/firebase/firebase_auth.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/utils/constant.dart';
import 'package:chat_app/utils/theme.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FbAuth _auth = FbAuth.instance;
  String userToken;

  @override
  void initState() {
    super.initState();
    /*loadSharedPrefrences().then((prefs) {
      Timer(const Duration(seconds: 2), () {
        isSignedIn(prefs);
      });
    });*/
    Timer(const Duration(seconds: 2), () {
      isSignedIn();
    });
  }

  /*Future<SharedPreferences> loadSharedPrefrences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }*/

  bool isLoggedIn() {
    if (_auth.getCurrentUser() != null) {
      MyApp.userId = _auth.getCurrentUser().uid;
      return true;
    } else {
      return false;
    }
  }

  void isSignedIn() {
    if (isLoggedIn()) {
      /*print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print(prefs.get("id"));
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");*/
      Navigator.pushReplacementNamed(
        context,
        Constants.landingScreen,
        arguments: [_auth.getCurrentUser().uid],
      );
    } else {
      Navigator.pushReplacementNamed(context, Constants.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.orange,
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Image(
                height: MediaQuery.of(context).size.width / 1.6,
                width: MediaQuery.of(context).size.width / 1.6,
                image: AssetImage('assets/images/chat_ico.png'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LinearProgressIndicator(
              backgroundColor: AppTheme.appColorSelector[800],
              valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.blackColorSelector[700]),
            ),
          ),
        ],
      ),
    );
  }
}
