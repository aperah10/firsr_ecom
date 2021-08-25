part of 'userlogin_bloc.dart';

abstract class UserloginEvent extends Equatable {
  const UserloginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends UserloginEvent {
  final String username;
  final String password;
  LoginButtonPressed({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}
