import 'package:chat_app/bloc/user_bloc/user_bloc.dart';
import 'package:chat_app/ui/common/rounded_button.dart';
import 'package:chat_app/utils/constant.dart';
import 'package:chat_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email;
  String password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appColorSelector[800],
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoadedState) {
            showSpinner = false;
            if (state.user != null) {
              Navigator.pushReplacementNamed(
                context,
                Constants.landingScreen,
                arguments: [state.user.uid],
              );
            }
          }
        },
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('assets/images/chat_ico.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: Constants.kInputDecoration
                      .copyWith(hintText: 'Enter Your E-mail'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: Constants.kInputDecoration
                      .copyWith(hintText: 'Enter Your Password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundButton(
                  navigationFunction: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    BlocProvider.of<UserBloc>(context).add(
                      LoginEvent(
                        email: email,
                        password: password,
                      ),
                    );
                  },
                  buttonText: 'Sign In',
                  colorName: AppTheme.appBarColor,
                ),
                RoundButton(
                  navigationFunction: () async {
                    Navigator.pushNamed(context, Constants.registrationScreen);
                  },
                  buttonText: 'Register',
                  colorName: AppTheme.appBarColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
