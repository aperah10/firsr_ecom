import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_ecom/Backend/Respo/auth/custLogin.dart';
import 'package:first_ecom/Backend/storage/login/LoginStorage.dart';

part 'userauthenticate_event.dart';
part 'userauthenticate_state.dart';

class UserauthenticateBloc
    extends Bloc<UserauthenticateEvent, UserauthenticateState> {
  final CustomUserLoginRespo userRepository;
  // final UserLoginStorage userLoginStorage;

  UserauthenticateBloc({required this.userRepository})
      : super(UserauthenticateInitial());

  @override
  Stream<UserauthenticateState> mapEventToState(
    UserauthenticateEvent event,
  ) async* {
    print(event);
    if (event is AppStarted) {
      try {
        bool hasToken = await userRepository.LoginhasToken();
        // bool hasToken = await userLoginStorage.LoginhasToken();
        if (hasToken) {
          yield AuthenticatedAuthenticated();
        } else {
          yield AuthenticationUnauthenticated();
        }
      } catch (e) {
        print(e);
      }
    }
    //  2. WHEN EVENT IS LOGIN
    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.LoginpersistToken(event.usertoken);
      // await userLoginStorage.LoginpersistToken(event.usertoken);
      yield AuthenticatedAuthenticated();
    }

    // 3. WHEN EVENT IS LOGGOUT
    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.LogindeleteToken();
      // await userLoginStorage.LogindeleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
