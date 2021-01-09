import 'package:chat_app/data/sources/firebase/cloud_messaging.dart';
import 'package:chat_app/utils/api_caller.dart';
import 'dart:io';
import 'package:chat_app/data/sources/firebase/firebase_auth.dart';
import 'package:chat_app/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

import '../../main.dart';

enum ConnectionState {
  online,
  offline,
  poor,
}

class UserRepository {
  static final UserRepository instance = UserRepository._privateConstructor();
  final _auth = FbAuth.instance;
  final _cloudMessaging = CloudMessaging.instance;
  final DatabaseReference _databaseReference =
      FirebaseDatabase(databaseURL: Constants.realtimeDbUrl).reference();
  APICaller apiCaller = APICaller();

  UserRepository._privateConstructor();

  Future<User> register({
    @required String email,
    @required String password,
    @required String nickname,
    @required File avatarImageFile,
  }) async {
    try {
      User newUser = await _auth.registerWithEmail(
        email: email,
        password: password,
        nickname: nickname,
        avatarImageFile: avatarImageFile,
      );
      MyApp.userId = newUser.uid;
      return newUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User> login({
    @required String email,
    @required String password,
  }) async {
    try {
      User newUser =
          await _auth.signInWithEmail(email: email, password: password);
      MyApp.userId = newUser.uid;
      return newUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> setStatus(String status) async {
    return await _databaseReference.child(_auth.getCurrentUser().uid).set({
      'status': status,
    });
  }

  void setupPushNotifications() {
    _cloudMessaging.registerNotification();
    _cloudMessaging.configLocalNotification();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  // Future<List<Person>> getAllPeople() async {
  //   ConnectionState connectionState = await returnConnectionState();
  //   if (connectionState == ConnectionState.online) {
  //     return getAllPeopleOnline();
  //   } else if (connectionState == ConnectionState.poor) {
  //     return getAllPeopleFromFirebase();
  //   } else {
  //     return getAllPeopleOffline();
  //   }
  // }

  // Future<List<Person>> getAllPeopleOffline() async {
  //   List<db.PersonData> peopleData = await MyApp.appDataBase.getAllPeople();
  //   List<Person> people = [];
  //   for (int i = 0; i < peopleData.length; i++) {
  //     people.add(Person.fromPersonData(peopleData[i]));
  //   }
  //   print(
  //       "Offline Request Success---------------------------------------------------");
  //   people.forEach((person) => print(person.url));
  //   print(
  //       "--------------------------------------------------------------------------");
  //   return people;
  // }

  // Future<List<Person>> getAllPeopleOnline() async {
  //   try {
  //     apiCaller.setUrl(Constants.peopleRoute);
  //     Map<String, dynamic> response =
  //         await apiCaller.getData() as Map<String, dynamic>;
  //     List<dynamic> results = response['results'];
  //     List<Person> people = results.map((i) => Person.fromJson(i)).toList();
  //     print(
  //         "Online Request Success----------------------------------------------------");
  //     people.forEach((person) => print(person.url));
  //     print(
  //         "--------------------------------------------------------------------------");
  //     return people;
  //   } catch (error, stacktrace) {
  //     print(
  //         "Online Request Failure----------------------------------------------------");
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return getAllPeopleFromFirebase();
  //   }
  // }

  // Future<List<Person>> getAllPeopleFromFirebase() async {
  //   print(
  //       "People Firebase Baybaaaaaaaaaay --------------------------------------------------");
  //   CloudFirestore firestore = CloudFirestore(
  //       collection: FirebaseFirestore.instance.collection('people'));
  //   List<QueryDocumentSnapshot> docs = await firestore.getCollection();
  //   List<Person> people = [];
  //   docs.forEach((doc) {
  //     people.add(Person.fromJson(doc.data()));
  //   });
  //   return people;
  // }

  // Future<Person> getPerson({int id}) async {
  //   Person person = await getPersonOffline(id: id);
  //   if (person != null) {
  //     return person;
  //   } else {
  //     return getPersonOnline(id: id);
  //   }
  // }

  // Future<Person> getPersonOffline({int id}) async {
  //   db.PersonData personData = await MyApp.appDataBase.getPersonById(id);
  //   if (personData != null) {
  //     Person person = Person.fromPersonData(personData);
  //     print(
  //         "Offline Request Success---------------------------------------------------");
  //     print(person.films);
  //     print(
  //         "--------------------------------------------------------------------------");
  //     return person;
  //   } else {
  //     print(
  //         "Offline Request Failure---------------------------------------------------");
  //     print("Doesn't Exist The Online Request Will Begin........");
  //     print(
  //         "--------------------------------------------------------------------------");
  //     return null;
  //   }
  // }

  // Future<Person> getPersonOnline({int id}) async {
  //   CloudFirestore firestore = CloudFirestore(
  //       collection: FirebaseFirestore.instance.collection('people'));
  //   var response;
  //   try {
  //     apiCaller.setUrl(Constants.peopleRoute + id.toString() + "/");
  //     response = await apiCaller.getData();
  //     firestore.addDocument(id: id.toString(), json: response);
  //     print(
  //         "Online Request Success------------------------------------------------");
  //   } catch (error, stacktrace) {
  //     print(
  //         "Online Request From SWAPI Failed----------------------------------------");
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     print(
  //         "Trying Firebase Cloud Firestore Now-------------------------------------");
  //     response = await firestore.getDocument(id: id.toString());
  //   }
  //   Person person = Person.fromJson(response);
  //   await MyApp.appDataBase.insertPerson(person.toPersonData());
  //   return person;
  // }

  // For Being Online Priority
  Future<ConnectionState> returnConnectionState() async {
    if (await apiCaller.returnRSC() == -1) {
      return ConnectionState.offline;
    } else if (await apiCaller.returnRSC() == -2) {
      return ConnectionState.poor;
    } else {
      return ConnectionState.online;
    }
  }

  // Future deletePersonCache() async {
  //   List<db.PersonData> peopleData = await MyApp.appDataBase.getAllPeople();
  //   peopleData.forEach((person) {
  //     if (DateTime.now().difference(DateTime.parse(person.edited)).inDays > 2) {
  //       MyApp.appDataBase.deletePerson(person);
  //     }
  //   });
  // }
}
