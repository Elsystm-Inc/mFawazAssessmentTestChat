import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'package:shared_preferences/shared_preferences.dart';

class FbAuth {
  static final FbAuth instance = FbAuth._privateConstructor();

  FirebaseAuth _authInstance = FirebaseAuth.instance;
  UserCredential _userCredential;
  User _user;

  FbAuth._privateConstructor();
  User getCurrentUser() {
    return _authInstance.currentUser;
  }

  Future<User> registerWithEmail({
    String email,
    String password,
    String nickname,
    File avatarImageFile,
  }) async {
    _userCredential = await _authInstance.createUserWithEmailAndPassword(
        email: email, password: password);
    User firebaseUser = _userCredential.user;

    if (firebaseUser != null) {
      Reference reference =
          FirebaseStorage.instance.ref().child(firebaseUser.uid);
      reference.putFile(avatarImageFile).then((taskSnapshot) {
        taskSnapshot.ref.getDownloadURL().then(
          (downloadUrl) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(firebaseUser.uid)
                .set(
              {
                'id': firebaseUser.uid,
                'email': firebaseUser.email,
                'nickname': nickname,
                'image_url': downloadUrl,
                'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
                'chattingWith': null,
              },
            );
          },
        );
      }, onError: (err) {
        print(err);
        Fluttertoast.showToast(msg: 'This file is not an image');
      });
    }
    _user = firebaseUser;
    //updateSharedPrefrences(_user);
    return _user;
  }

  Future<User> signInWithEmail({String email, String password}) async {
    _userCredential = await _authInstance.signInWithEmailAndPassword(
        email: email, password: password);
    _user = _userCredential.user;
    //updateSharedPrefrences(_user);
    return _user;
  }

  Future<void> signOut() async {
    await _authInstance.signOut();
  }

  /*updateSharedPrefrences(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', user.uid);
    await prefs.setString('email', user.email);
  }*/
}

/*
  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    _userCredential = await _authInstance.signInWithCredential(credential);
    _user = _userCredential.user;
    updateSharedPrefrences(_user);
    return _user;
  }

  Future<User> signInWithFacebook() async {
    // Trigger the sign-in flow
    final dynamic result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken.token);

    // Once signed in, return the UserCredential
    _userCredential =
        await _authInstance.signInWithCredential(facebookAuthCredential);
    _user = _userCredential.user;
    updateSharedPrefrences(_user);
    return _user;
  }
  */
