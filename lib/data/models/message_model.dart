import 'package:chat_app/data/sources/moor_database/moor_database.dart';
import 'package:flutter/material.dart';

class Message {
  String idFrom;
  String idTo;
  String content;
  String timestamp;
  String type;

  Message({
    this.idFrom,
    this.idTo,
    this.content,
    this.timestamp,
    this.type,
  });

  factory Message.fromJson(Map<String, dynamic> data) {
    return Message(
      idFrom: data['idFrom'],
      idTo: data['idTo'],
      content: data['content'],
      timestamp: data['timestamp'],
      type: data['type'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'idFrom': idFrom,
        'idTo': idTo,
        'content': content,
        'timestamp': timestamp,
        'type': type,
      };

  Map<String, dynamic> toUpdateJson() => {
        'idFrom': idFrom,
        'idTo': idTo,
        'content': content,
        'timestamp': timestamp,
        'type': type,
      };

  MessageData toMessageData({@required String id, @required String chatId}) {
    return MessageData(
      id: id,
      idFrom: this.idFrom,
      idTo: this.idTo,
      chatId: chatId,
      content: this.content,
      timestamp: int.parse(this.timestamp),
      type: int.parse(this.type),
    );
  }

  factory Message.fromMessageData(MessageData messageData) {
    return Message(
      idFrom: messageData.idFrom,
      idTo: messageData.idTo,
      content: messageData.content,
      timestamp: messageData.timestamp.toString(),
      type: messageData.type.toString(),
    );
  }
}
