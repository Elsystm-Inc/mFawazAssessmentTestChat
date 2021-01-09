part of 'messages_bloc.dart';

abstract class MessagesState {
  const MessagesState();
}

class MessagesInitial extends MessagesState {}

class MessageStreamLoadedState extends MessagesState {
  Stream<List<Message>> messageStream;
  MessageStreamLoadedState(this.messageStream);
}

class MessagesLoadingState extends MessagesState {}
