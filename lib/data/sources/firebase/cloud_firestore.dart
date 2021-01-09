import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../main.dart';

class CloudFirestore {
  static final CloudFirestore instance = CloudFirestore._privateConstructor();
  FirebaseFirestore _fbInstance = FirebaseFirestore.instance;

  CloudFirestore._privateConstructor();

  Stream<List<User>> getContacts() {
    Stream<QuerySnapshot> contacts =
        _fbInstance.collection('users').snapshots();
    return contacts.map((qShot) => qShot.docs.map((doc) {
          User user = User.fromJson(doc.data());
          if (user.id == MyApp.userId) {
            MyApp.appDataBase.insertUserIfDoesntExist(user.toUserData(type: 1));
          } else {
            MyApp.appDataBase.insertUserIfDoesntExist(user.toUserData(type: 0));
          }
          return user;
        }).toList());
  }

  Stream<List<Message>> getMessages({String chatId, int limit}) {
    Stream<QuerySnapshot> messages = _fbInstance
        .collection('messages')
        .doc(chatId)
        .collection(chatId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots();
    return messages.map((qShot) {
      return qShot.docs.map((doc) {
        Message message = Message.fromJson(doc.data());
        MyApp.appDataBase.insertMessageIfDoesntExist(
            message.toMessageData(chatId: chatId, id: chatId + doc.id));
        return message;
      }).toList();
    });
  }

  sendMessage({Map<String, dynamic> msg, String chatId}) {
    var documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(chatId)
        .collection(chatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction(
      (transaction) async {
        transaction.set(
          documentReference,
          msg,
        );
      },
    );
  }
}

/*Future<void> addDocument({String id, Map<String, dynamic> json}) {
    return collection
        .doc(id)
        .set(json)
        .then(
            (value) => print("Document Added to Cloud Firestore with id: $id"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<Map<String, dynamic>> getDocument({String id}) async {
    DocumentSnapshot documentSnapshot = await collection.doc(id).get();
    if (documentSnapshot.exists) {
      print('Document Retrieved from Firebase');
      return documentSnapshot.data();
    } else {
      print('Document does not exist on the database');
      return null;
    }
  }

  Future<List<QueryDocumentSnapshot>> getCollection() async {
    QuerySnapshot snapshot = await collection.get();
    return snapshot.docs;
  }*/
