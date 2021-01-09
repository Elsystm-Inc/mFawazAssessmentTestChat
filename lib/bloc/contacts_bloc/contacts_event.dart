part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();
}

class GetContactsEvent extends ContactsEvent {
  GetContactsEvent();
  @override
  List<Object> get props => [];
}

class GetContactStatus extends ContactsEvent {
  final String id;
  GetContactStatus({this.id});
  @override
  List<Object> get props => [this.id];
}
