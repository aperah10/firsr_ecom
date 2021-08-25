part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends RegisterEvent {
  String email, password, fullname, phone;
  SignUpButtonPressed(
      {required this.email,
      required this.fullname,
      required this.phone,
      required this.password});
}
