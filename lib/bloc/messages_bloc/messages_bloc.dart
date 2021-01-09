import 'dart:async';
//import 'dart:io';
import 'package:chat_app/data/models/message_model.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app/data/repositores/messages_repository.dart';
import 'package:chat_app/utils/api_caller.dart';
import 'package:equatable/equatable.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc() : super(MessagesInitial());

  Future<ConnectionState> returnConnectionState() async {
    if (await APICaller().returnRSC() == -1) {
      return ConnectionState.offline;
    } else if (await APICaller().returnRSC() == -2) {
      return ConnectionState.poor;
    } else {
      return ConnectionState.online;
    }
  }

  @override
  Stream<MessagesState> mapEventToState(
    MessagesEvent event,
  ) async* {
    try {
      if (event is GetMessagesEvent) {
        ConnectionState connectionState = await returnConnectionState();
        Stream<List<Message>> messageStream = MessagesRepository.instance
            .getMessages(
                chatId: event.chatId,
                limit: event.limit,
                connectionState: connectionState);
        yield MessageStreamLoadedState(messageStream);
      }
    } catch (error) {
      print(error);
    }
  }
}
