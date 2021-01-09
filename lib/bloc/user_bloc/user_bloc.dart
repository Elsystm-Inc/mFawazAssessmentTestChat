import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/data/repositores/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    try {
      if (event is RegistrationEvent) {
        User user = await UserRepository.instance.register(
          email: event.email,
          nickname: event.nickname,
          password: event.password,
          avatarImageFile: event.image,
        );
        yield UserLoadedState(user);
      } else if (event is LoginEvent) {
        User user = await UserRepository.instance.login(
          email: event.email,
          password: event.password,
        );
        yield UserLoadedState(user);
      } else if (event is SetStatusEvent) {
        //Stream<um.User> u = await ContactsRepository.instance.getContacts();
        // await for (var value in u) {
        // print("Chicken Dinner >> ${value.nickname}");
        //}

        await UserRepository.instance.setStatus(event.status);

        print("Attention Please!: 3- SetStatusEvent");

        yield StatusSettedState();
      } else if (event is SetupPushNotificationsEvent) {
        UserRepository.instance.setupPushNotifications();
        print("Attention Please!: 5- SetupPushNotificationsEvent");
        yield SettedUpPushNotificationsState();
      } else if (event is LogoutEvent) {
        await UserRepository.instance.logout();
        await MyApp.appDataBase.deleteAllMessages();
        await MyApp.appDataBase.deleteAllUsers();
        print("Attention Please!: 4- LogoutEvent");
        yield LoggedOutState();
      }
    } catch (error) {
      print(error);
    }
  }
}
