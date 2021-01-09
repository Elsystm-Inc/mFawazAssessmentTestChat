part of 'contacts_bloc.dart';

abstract class ContactsState {
  const ContactsState();
}

class ContactsInitial extends ContactsState {}

class ContactStreamLoadedState extends ContactsState {
  Stream<List<User>> contactStream;
  ContactStreamLoadedState(this.contactStream);
}

class ContactsStatusLoadedState extends ContactsState {
  Stream<Event> contactStatusStream;
  ContactsStatusLoadedState(this.contactStatusStream);
}

class ContactsLoadingState extends ContactsState {}
