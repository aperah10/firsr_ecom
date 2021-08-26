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

/* -------------------------------------------------------------------------- */
/*                                SIGNED EVENT                                */
/* -------------------------------------------------------------------------- */
class SignedIn extends UserauthenticateEvent {
  final String regtoken;
  SignedIn({required this.regtoken});

  @override
  List<Object> get props => [regtoken];

  @override
  String toString() => 'LoggedIn { regtoken: $regtoken }';
}

class LoggedOut extends UserauthenticateEvent {}
