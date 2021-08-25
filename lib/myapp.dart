import 'package:first_ecom/Fortend/Widget/Form/formValdation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import 'Backend/Logic/Bloc/auth/userauthenticate_bloc.dart';
import 'Backend/Respo/auth/custLogin.dart';
import 'Fortend/auth_Screen/Home.dart';
import 'Fortend/auth_Screen/Login.dart';

// / Custom [BlocObserver] which observes all bloc and cubit instances.

/* -------------------------------------------------------------------------- */
/*                              BLOC PATTERN USED                             */
/* -------------------------------------------------------------------------- */

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();

  final userRepository = CustomUserLoginRespo();

  runApp(
    BlocProvider<UserauthenticateBloc>(
      create: (context) {
        return UserauthenticateBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: MyApp(userRepository: userRepository),
    ),
  );
}

/* -------------------------------------------------------------------------- */
/*                                    MyApp                                   */
/* -------------------------------------------------------------------------- */

class MyApp extends StatelessWidget {
  final CustomUserLoginRespo userRepository;
  MyApp({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: Locale('mn', 'MN'),
        title: ' MyApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeBuilderApp(userRepository: userRepository));
  }
}

/* -------------------------------------------------------------------------- */
/*                                    APP Started time                                     */
/* -------------------------------------------------------------------------- */

class HomeBuilderApp extends StatelessWidget {
  final CustomUserLoginRespo userRepository;

  HomeBuilderApp({Key? key, required this.userRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserauthenticateBloc, UserauthenticateState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AuthenticatedAuthenticated) {
            return HomeScreen();
          }
          if (state is AuthenticationUnauthenticated) {
            return ChangeNotifierProvider(
              create: (context) => AllFormValdation(),
              child: LoginScreen(
                userRepository: userRepository,
              ),
            );
          }
          if (state is AuthenticationLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
