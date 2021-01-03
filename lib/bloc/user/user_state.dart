part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  UserState();
}

class UserInitialState extends UserState {
  UserInitialState();
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  UserLoadingState();
  @override
  List<Object> get props => [];
}

class UserProfilePictureLoadingState extends UserState {
  UserProfilePictureLoadingState();
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState {
  final User user;
  UserLoadedState(this.user);
  @override
  List<Object> get props => [user];
}

class UserProfilePictureLoadedState extends UserState {
  UserProfilePictureLoadedState();
  @override
  List<Object> get props => [];
}

class UserSignedUpState extends UserState {
  final User user;
  UserSignedUpState(this.user);
  @override
  List<Object> get props => [user];
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
  @override
  List<Object> get props => [message];
}

class UserMessageState extends UserState {
  final String message;
  UserMessageState(this.message);
  @override
  List<Object> get props => [message];
}

class VerifyEmailSuccessfullyState extends UserState {
  final String message;
  VerifyEmailSuccessfullyState(this.message);
  @override
  List<Object> get props => [message];
}

class ResendVerifyEmailSuccessfullyState extends UserState {
  final String message;
  ResendVerifyEmailSuccessfullyState(this.message);
  @override
  List<Object> get props => [message];
}

class UserLoggedOutState extends UserState {
  UserLoggedOutState();
  @override
  List<Object> get props => [];
}
