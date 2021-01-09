import 'dart:async';
//import 'dart:io';
import 'package:chat_app/data/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app/data/repositores/contacts_repository.dart';
import 'package:chat_app/utils/api_caller.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitial());

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
  Stream<ContactsState> mapEventToState(
    ContactsEvent event,
  ) async* {
    try {
      if (event is GetContactsEvent) {
        ConnectionState connectionState = await returnConnectionState();
        Stream<List<User>> contactStream =
            ContactsRepository.instance.getContacts(connectionState);
        yield ContactStreamLoadedState(contactStream);
      } else if (event is GetContactStatus) {
        Stream contactStatusStream =
            ContactsRepository.instance.getContactStatus(event.id);
        yield ContactsStatusLoadedState(contactStatusStream);
      }
    } catch (error) {
      print(error);
    }
  }
}
