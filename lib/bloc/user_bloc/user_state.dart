part of 'user_bloc.dart';

abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {}

class UserLoadedState extends UserState {
  final User user;

  UserLoadedState(this.user);
}

class UserLoadingState extends UserState {}

class StatusSettedState extends UserState {}

class SettedUpPushNotificationsState extends UserState {}

class LoggedOutState extends UserState {}
