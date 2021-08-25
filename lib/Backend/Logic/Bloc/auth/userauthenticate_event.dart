part of 'userauthenticate_bloc.dart';

abstract class UserauthenticateEvent extends Equatable {
  const UserauthenticateEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends UserauthenticateEvent {}

class LoggedIn extends UserauthenticateEvent {
  final String usertoken;
  LoggedIn({required this.usertoken});

  @override
  List<Object> get props => [usertoken];

  @override
  String toString() => 'LoggedIn { usertoken: $usertoken }';
}

class LoggedOut extends UserauthenticateEvent {}
