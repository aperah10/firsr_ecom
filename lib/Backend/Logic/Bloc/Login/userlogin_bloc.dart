import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_ecom/Backend/Logic/Bloc/auth/userauthenticate_bloc.dart';
import 'package:first_ecom/Backend/Respo/auth/custLogin.dart';
import 'package:first_ecom/Backend/storage/login/LoginStorage.dart';

part 'userlogin_event.dart';
part 'userlogin_state.dart';

class UserloginBloc extends Bloc<UserloginEvent, UserloginState> {
  //  REPOSTIPRY FOR
  final CustomUserLoginRespo userRepository;
  // final UserLoginStorage userLoginStorage;
  final UserauthenticateBloc authenticationBloc;

  UserloginBloc(
      {required this.authenticationBloc, required this.userRepository})
      : super(UserloginInitial());

  @override
  Stream<UserloginState> mapEventToState(
    UserloginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final usertoken = await userRepository.loginnow(
            phone: event.phone, password: event.password);
        print('this is user token in login bloc ${usertoken.runtimeType}');

        if (usertoken != 'errror') {
          authenticationBloc.add(LoggedIn(usertoken: usertoken));
          yield UserloginInitial();
        }
        yield UserloginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
