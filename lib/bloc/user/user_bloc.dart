import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mfawazTestChat/data/repositores/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/model/user_model.dart';
import '../../main.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(null);

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    yield UserLoadingState();
    try {
      if (event is GetUser) {
        Root.user = await userRepository.fetchUserData();
        yield UserLoadedState(Root.user);
      } else if (event is LoginUser) {
        Root.user = await userRepository.login(event.email, event.password, event.platform, event.firebaseToken);
        yield UserLoadedState(Root.user);
      } else if (event is ForgotPassword) {
        final String message = await userRepository.forgetPassword(event.email);
        yield UserMessageState(message);
      } else if (event is LogoutUser) {
        Root.user = await userRepository.logout();
        yield UserLoggedOutState();
      }
    } catch (error) {
      debugPrint("Error happened in SettingsBloc of type ${error.runtimeType} with output ' ${error.toString()} '");
      yield UserErrorState(error.toString());
    }
  }
}
