import 'dart:convert';

import 'package:mfawazTestChat/utils/app_exceptions.dart';
import 'package:mfawazTestChat/utils/api_caller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../model/user_model.dart';

abstract class UserRepository {
  Future<User> login(
    String email,
    String password,
    String platform,
    String firebaseToken,
  );

  Future<User> register(
    String email,
    String name,
    String username,
    String phone,
    String country,
    String password,
    String passwordConfirmation,
    String platform,
    String firebaseToken,
  );

  Future<User> update(User user);

  Future<User> updateProfilePicture(String photo, String name);

  Future<String> forgetPassword(String email);

  Future<String> resetPassword(String email, String token, String newPassword);

  Future<User> fetchUserData();

  Future<User> loadUserData(String firebaseToken);

  logout();
}

class UserDataRepository implements UserRepository {
  APICaller _apiCaller = new APICaller();

  @override
  Future<User> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      throw UnauthorisedException('no user logged in');
    }
    //User user = User.fromJson(json.decode(prefs.get('userData')));
    // final expiryDate = DateTime.parse(prefs.get('expiryDate'));
    // if (expiryDate.isBefore(DateTime.now())) {
    //   throw UnauthorisedException('Expired');
    // }
    return null;
  }

  @override
  Future<String> forgetPassword(String email) async {
    _apiCaller.setUrl("/password/create");
    final responseData = await _apiCaller.postData(
      body: {"email": email},
    );
    return responseData['message'];
  }

  @override
  Future<User> login(String email, String password, String platform, String firebaseToken) async {
    _apiCaller.setUrl("/login");
    final responseData = await _apiCaller.postData(
      body: {
        "username": email,
        "password": password,
        "firebase_token": firebaseToken ?? "firebaseToken",
        "platform": platform
      },
    );
    // User user = User.fromJson(responseData['user']);
    // DateTime _expiryDate = DateTime.parse(responseData['expires_at']);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', "temp");
    prefs.setString('token', 'Bearer ' + responseData['payload']);
    // prefs.setString('expiryDate', _expiryDate.toIso8601String());
    // prefs.setBool('loggedIn', true);
    // return user;
    return null;
  }

  @override
  Future<User> register(String email, String name, String username, String phone, String country, String password,
      String passwordConfirmation, String platform, String firebaseToken) async {
    _apiCaller.setUrl("/register");
    final responseData = await _apiCaller.postData(body: {
      "name": name,
      "email": email,
      "phone": phone,
      "country": country,
      "username": username,
      "password": password,
      "firebase_token": firebaseToken,
      "platform": platform
    });
    User user = User.fromJson(responseData['user']);
    DateTime _expiryDate = DateTime.parse(responseData['expires_at']);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', json.encode(user));
    prefs.setString('token', 'Bearer ' + responseData['access_token']);
    prefs.setString('expiryDate', _expiryDate.toIso8601String());
    prefs.setBool('loggedIn', true);
    return user;
  }

  @override
  Future<String> resetPassword(String email, String token, String newPassword) async {
    _apiCaller.setUrl("/password/reset");
    final responseData = await _apiCaller.postData(
      body: {"email": email, "token": token},
      needAuthorization: true,
    );
    return responseData;
  }

  @override
  Future<User> update(User updatedUser) async {
    final prefs = await SharedPreferences.getInstance();
    _apiCaller.setUrl("/update-user-data");
    final responseData = await _apiCaller.postData(
      body: updatedUser.toUpdateJson(),
      needAuthorization: true,
    );
    User user = User.fromJson(responseData['user']);
    prefs.setString('userData', json.encode(user));
    return user;
  }

  @override
  Future<User> updateProfilePicture(String photo, String name) async {
    final prefs = await SharedPreferences.getInstance();
    _apiCaller.setUrl("/update-user-profile-picture");
    final responseData = await _apiCaller.postData(
      body: {
        "photo": photo,
        "name": name,
      },
      needAuthorization: true,
    );
    User user = User.fromJson(responseData['user']);
    prefs.setString('userData', json.encode(user));
    return user;
  }

  @override
  Future<User> loadUserData(String firebaseToken) async {
    final prefs = await SharedPreferences.getInstance();
    _apiCaller.setUrl("/auth/user");
    final responseData = await _apiCaller.postData(
      body: {'firebase_token': firebaseToken},
      needAuthorization: true,
    );
    User user = User.fromJson(responseData['user']);
    prefs.setString('userData', json.encode(user));
    return user;
  }

  @override
  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // String theme = preferences.getString("theme");
    // String local = preferences.getString('languageCode');
    Root.user = null;
    preferences.clear();
    // preferences.setString('languageCode', local);
    // preferences.setString('theme', theme);
  }
}
