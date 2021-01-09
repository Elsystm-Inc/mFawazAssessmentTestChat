import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:chat_app/data/models/message_model.dart' as msgModel;
import 'package:chat_app/data/models/user_model.dart' as usrModel;

part 'moor_database.g.dart';

class User extends Table {
  TextColumn get id => text()();
  TextColumn get nickname => text()();
  TextColumn get email => text()();
  TextColumn get image => text()();
  IntColumn get type => integer()();
  Set<Column> get primaryKey => {id};
}

class Message extends Table {
  TextColumn get id => text()();
  TextColumn get idFrom => text()();
  TextColumn get idTo => text()();
  TextColumn get content => text()();
  IntColumn get timestamp => integer()();
  IntColumn get type => integer()();
  TextColumn get chatId => text()();
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [
  User,
  Message,
])
class AppDataBase extends _$AppDataBase {
  // we tell the database where to store the data with this constructor
  AppDataBase() : super(_openConnection());

  static FlutterQueryExecutor _openConnection() {
    return FlutterQueryExecutor.inDatabaseFolder(
        path: "db.chatApp", logStatements: true);
  }

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  Stream<List<usrModel.User>> watchAllUsers() => select(user).map((u) {
        return usrModel.User.fromUserData(u);
      }).watch();
  Future<List<UserData>> getAllUsers() => select(user).get();
  Future updateUser(UserData userData) => update(user).replace(userData);
  Future deleteUser(UserData userData) => delete(user).delete(userData);
  Future<UserData> getUserById(String id) =>
      (select(user)..where((u) => u.id.equals(id))).getSingle();

//----------------------------------------------------------------------------------------------------------------------

  Stream<List<MessageData>> watchAllMessages() => select(message).watch();
  Future<List<MessageData>> getAllMessages() => select(message).get();
  Future updateMessage(MessageData messageData) =>
      update(message).replace(messageData);
  Future deleteMessage(MessageData messageData) =>
      delete(message).delete(messageData);
  Future<MessageData> getMessageById(String id) =>
      (select(message)..where((m) => m.id.equals(id))).getSingle();

//----------------------------------------------------------------------------------------------------------------------

  Stream<List<usrModel.User>> watchUsersExcpetMe() =>
      (select(user)..where((u) => u.type.equals(0)))
          .map((u) => usrModel.User.fromUserData(u))
          .watch();

  Future<usrModel.User> getMyUser() =>
      (select(user)..where((u) => u.type.equals(1)))
          .map((u) => usrModel.User.fromUserData(u))
          .getSingle();

  Future insertUser(UserData userData) {
    print(userData.email);
    return into(user).insert(userData);
  }

  Future insertUserIfDoesntExist(UserData userData) async {
    UserData usr = await getUserById(userData.id);
    if (usr == null) {
      return insertUser(userData);
    }
  }

  Future<void> insertMultipleEntriesIntoUsers(List<UserData> usersData) async {
    await batch((batch) {
      batch.insertAll(user, usersData, mode: InsertMode.insertOrIgnore);
    });
  }

  Future deleteAllUsers() => delete(user).go();

//----------------------------------------------------------------------------------------------------------------------

  Stream<List<msgModel.Message>> getMessagesOfEachChat(String chatId) {
    return (select(message)
          ..orderBy(
            ([
              // Primary sorting by due date
              (m) => OrderingTerm(
                  expression: m.timestamp, mode: OrderingMode.desc),
            ]),
          )
          ..where((m) => m.chatId.like("%$chatId%")))
        .map((m) => msgModel.Message.fromMessageData(m))
        .watch();
  }

  Future insertMessage(MessageData messageData) =>
      into(message).insert(messageData);

  Future insertMessageIfDoesntExist(MessageData messageData) async {
    MessageData msg = await getMessageById(messageData.id);
    if (msg == null) {
      return insertMessage(messageData);
    }
  }

  Future<void> insertMultipleEntriesIntoMessages(
      List<MessageData> messagesData) async {
    await batch((batch) {
      batch.insertAll(message, messagesData, mode: InsertMode.insertOrIgnore);
    });
  }

  Future deleteAllMessages() => delete(message).go();
}
