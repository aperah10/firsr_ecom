import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_ecom/Backend/Respo/auth/custLogin.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final CustomUserLoginRespo userRepository;

  RegisterBloc({required this.userRepository}) : super(RegisterInitial());

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
        if (user != "errror") {
          yield RegisterSucced(user: user);
        }
        yield RegisterInitial();
      } catch (e) {
        yield RegisterFailed(message: e.toString());
      }
    }
  }
}
