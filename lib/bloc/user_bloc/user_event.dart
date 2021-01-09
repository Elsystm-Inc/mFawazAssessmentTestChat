part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class RegistrationEvent extends UserEvent {
  final String email;
  final String nickname;
  final String password;
  final File image;

  RegistrationEvent(
      {@required this.email,
      @required this.nickname,
      @required this.password,
      @required this.image});
  @override
  List<Object> get props =>
      [this.email, this.nickname, this.password, this.image];
}

class LoginEvent extends UserEvent {
  final String email;
  final String password;

  LoginEvent({this.email, this.password});
  @override
  List<Object> get props => [this.email, this.password];
}

class SetStatusEvent extends UserEvent {
  final String status;

  SetStatusEvent({this.status});
  @override
  List<Object> get props => [this.status];
}

class LogoutEvent extends UserEvent {
  LogoutEvent();
  @override
  List<Object> get props => [];
}

class SetupPushNotificationsEvent extends UserEvent {
  SetupPushNotificationsEvent();
  @override
  List<Object> get props => [];
}
