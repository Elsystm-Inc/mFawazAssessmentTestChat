import 'dart:io';
import 'package:chat_app/bloc/user_bloc/user_bloc.dart';
import 'package:chat_app/ui/common/rounded_button.dart';
import 'package:chat_app/utils/constant.dart';
import 'package:chat_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  bool isLoading = false;
  String photoUrl = '';
  String email;
  String nickname;
  String password;
  File avatarImageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appColorSelector[800],
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoadedState) {
            showSpinner = false;
            if (state.user != null) {
              Navigator.pop(context);
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
                Container(
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        (avatarImageFile == null)
                            ? (photoUrl != ''
                                ? Material(
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => Container(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              AppTheme.appColorSelector[800]),
                                        ),
                                        width: 150.0,
                                        height: 150.0,
                                        padding: EdgeInsets.all(20.0),
                                      ),
                                      imageUrl: photoUrl,
                                      width: 150.0,
                                      height: 150.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(45.0)),
                                    clipBehavior: Clip.hardEdge,
                                  )
                                : Icon(
                                    Icons.account_circle,
                                    size: 150.0,
                                    color: Colors.grey[900],
                                  ))
                            : Material(
                                child: Image.file(
                                  avatarImageFile,
                                  width: 150.0,
                                  height: 150.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                clipBehavior: Clip.hardEdge,
                              ),
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: AppTheme.greyText.withOpacity(0.5),
                          ),
                          onPressed: getImage,
                          padding: EdgeInsets.all(50.0),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.grey[900],
                          iconSize: 50.0,
                        ),
                      ],
                    ),
                  ),
                  width: double.infinity,
                  margin: EdgeInsets.all(20.0),
                ),
                SizedBox(
                  height: 40.0,
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
                  height: 16.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    nickname = value;
                  },
                  decoration: Constants.kInputDecoration
                      .copyWith(hintText: 'Enter Your Nickname'),
                ),
                SizedBox(
                  height: 16.0,
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
                      RegistrationEvent(
                        email: email,
                        nickname: nickname,
                        password: password,
                        image: avatarImageFile,
                      ),
                    );
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

  /*User user = await UserRepository.instance.register(
                        email: email,
                        nickname: nickname,
                        password: password,
                        avatarImageFile: avatarImageFile,
                      );*/
  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;
    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    File image = File(pickedFile.path);

    if (image != null) {
      setState(() {
        avatarImageFile = image;
        isLoading = true;
      });
    }
  }
}
