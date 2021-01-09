part of 'messages_bloc.dart';

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();
}

class GetMessagesEvent extends MessagesEvent {
  final String chatId;
  final int limit;

  GetMessagesEvent({this.chatId, this.limit});
  @override
  List<Object> get props => [this.chatId, this.limit];
}
