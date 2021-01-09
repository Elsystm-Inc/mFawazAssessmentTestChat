import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/data/sources/firebase/cloud_firestore.dart';

import 'dart:async';

import '../../main.dart';

enum ConnectionState {
  online,
  offline,
  poor,
}

class MessagesRepository {
  static final MessagesRepository instance =
      MessagesRepository._privateConstructor();
  //final _auth = FbAuth.instance;
  final CloudFirestore _firestore = CloudFirestore.instance;

  MessagesRepository._privateConstructor();

  Stream<List<Message>> getMessages(
      {String chatId, int limit, ConnectionState connectionState}) {
    if (connectionState == ConnectionState.online) {
      return getMessagesOnline(chatId, limit);
    } else if (connectionState == ConnectionState.poor) {
      return getMessagesOffline(chatId);
    } else {
      return getMessagesOffline(chatId);
    }
  }

  Stream<List<Message>> getMessagesOnline(String chatId, int limit) =>
      _firestore.getMessages(chatId: chatId, limit: limit);

  Stream<List<Message>> getMessagesOffline(String chatId) =>
      MyApp.appDataBase.getMessagesOfEachChat(chatId);

  // For Being Online Priority

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
// Future deletePersonCache() async {
//   List<db.PersonData> peopleData = await MyApp.appDataBase.getAllPeople();
//   peopleData.forEach((person) {
//     if (DateTime.now().difference(DateTime.parse(person.edited)).inDays > 2) {
//       MyApp.appDataBase.deletePerson(person);
//     }
//   });
// }
