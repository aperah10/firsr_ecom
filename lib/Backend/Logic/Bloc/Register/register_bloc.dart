import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_ecom/Backend/Logic/Bloc/auth/userauthenticate_bloc.dart';
import 'package:first_ecom/Backend/Respo/auth/custLogin.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final CustomUserLoginRespo userRepository;
  final UserauthenticateBloc authenticationBloc;

  RegisterBloc({required this.userRepository, required this.authenticationBloc})
      : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is SignUpButtonPressed) {
      yield RegisterLoading();

      try {
        var user = await userRepository.registernow(
            email: event.email,
            phone: event.phone,
            fullname: event.fullname,
            password: event.password);
        print('this is Register token : -  ${user}');
        if (user != "errror") {
          authenticationBloc.add(SignedIn(regtoken: user));
          // yield RegisterSucced(user: user);
          yield RegisterSucced();
        } else {
          yield RegisterInitial();
        }
      } catch (e) {
        yield RegisterFailed(message: e.toString());
      }
    }
  }
}
