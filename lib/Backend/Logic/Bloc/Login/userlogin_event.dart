part of 'userlogin_bloc.dart';

abstract class UserloginEvent extends Equatable {
  const UserloginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends UserloginEvent {
  final String phone;
  final String password;
  LoginButtonPressed({required this.phone, required this.password});

  @override
  List<Object> get props => [phone, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $phone, password: $password }';
}
