import 'dart:async';

import 'package:mfawazTestChat/bloc/user/user_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';

class LandingSplashScreen extends StatefulWidget {
  @override
  _LandingSplashScreenState createState() => _LandingSplashScreenState();
}

class _LandingSplashScreenState extends State<LandingSplashScreen> {
  String _route;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetUser());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
        listener: (BuildContext context, UserState state) async {
          if (state is UserLoadedState) {
          } else if (state is UserErrorState) {}
        },
        child: Container());
  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //if user registered
    if (prefs.containsKey('userData')) {
      //if email is verified
      _route = Constants.homePage;
    } else {
      //if user not registered
      _route = Constants.authPage;
    }

    Duration _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // if (_route == Constants.authPage) {
    //   Navigator.pushReplacement(
    //     context,
    //     PageRouteBuilder(
    //       transitionDuration: Duration(seconds: 1),
    //       pageBuilder: (_, __, ___) => AuthPage(),
    //       settings: RouteSettings(
    //         name: Constants.authPage,
    //       ),
    //     ),
    //   );
    // } else {
    //   Navigator.of(context).pushReplacementNamed(_route);
    // }
  }
}
