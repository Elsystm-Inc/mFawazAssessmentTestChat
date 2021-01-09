import 'package:chat_app/utils/constant.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/data/sources/firebase/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import '../../main.dart';

enum ConnectionState {
  online,
  offline,
  poor,
}

class ContactsRepository {
  static final ContactsRepository instance =
      ContactsRepository._privateConstructor();
  final CloudFirestore _firestore = CloudFirestore.instance;
  final DatabaseReference _databaseReference =
      FirebaseDatabase(databaseURL: Constants.realtimeDbUrl).reference();

  ContactsRepository._privateConstructor();

  Stream getContactStatus(String id) => _databaseReference.child(id).onValue;

  Stream<List<User>> getContacts(ConnectionState connectionState) {
    if (connectionState == ConnectionState.online) {
      return getContactsOnline();
    } else if (connectionState == ConnectionState.poor) {
      return getContactsOffline();
    } else {
      return getContactsOffline();
    }
  }

  Stream<List<User>> getContactsOnline() => _firestore.getContacts();

  Stream<List<User>> getContactsOffline() => MyApp.appDataBase.watchAllUsers();
}
