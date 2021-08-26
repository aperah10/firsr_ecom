import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_ecom/Backend/Respo/auth/custLogin.dart';
import 'package:first_ecom/Backend/storage/login/LoginStorage.dart';

part 'userauthenticate_event.dart';
part 'userauthenticate_state.dart';

class UserauthenticateBloc
    extends Bloc<UserauthenticateEvent, UserauthenticateState> {
  // final CustomUserLoginRespo userRepository;
  final UserLoginStorage userLoginStorage;

  UserauthenticateBloc(
      {
      // required this.userRepository,
      required this.userLoginStorage})
      : super(UserauthenticateInitial());

  // @override
  // UserauthenticateBloc get initialState =>
  //  UserauthenticateInitial();

  @override
  Stream<UserauthenticateState> mapEventToState(
    UserauthenticateEvent event,
  ) async* {
    print(event);
    if (event is AppStarted) {
      try {
        // bool hasToken = await userRepository.loginhasToken();
        bool hasToken = await userLoginStorage.loginhasToken();
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
      // await userRepository.loginpersistToken(event.usertoken);
      await userLoginStorage.loginpersistToken(event.usertoken);
      yield AuthenticatedAuthenticated();
    }

    // 3. WHEN EVENT IS LOGGOUT
    if (event is LoggedOut) {
      yield AuthenticationLoading();
      // await userRepository.logindeleteToken();
      await userLoginStorage.logindeleteToken();
      yield AuthenticationUnauthenticated();
    }

    /* -------------------------------------------------------------------------- */
    /*                           REGISTER TOKEN CHECKING                          */
    /* -------------------------------------------------------------------------- */
    try {
      // bool hasToken = await userRepository.loginhasToken();
      bool reghasToken = await userLoginStorage.reghasToken();
      print('this is register token $reghasToken');
      if (reghasToken) {
        yield AuthenticatedAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    } catch (e) {
      print(e);
    }
    //  2. WHEN EVENT IS LOGIN
    if (event is SignedIn) {
      yield AuthenticationLoading();
      await userLoginStorage.regpersistToken(event.regtoken);
      yield AuthenticatedAuthenticated();
    }
  }
}
