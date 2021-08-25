import 'package:first_ecom/Backend/Logic/Bloc/Login/userlogin_bloc.dart';
import 'package:first_ecom/Backend/Logic/Bloc/auth/userauthenticate_bloc.dart';
import 'package:first_ecom/Fortend/Widget/Form/formValdation.dart';
import 'package:first_ecom/Fortend/new_auth_screen/new_login_scr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'Backend/Respo/auth/custLogin.dart';
import 'Fortend/auth_Screen/Login.dart';
import 'Fortend/auth_Screen/Home.dart';
import 'Fortend/new_auth_screen/new_home.dart';

main() {
  final userRepository = CustomUserLoginRespo();
  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final CustomUserLoginRespo userRepository;

  MyApp({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalStorage storage = new LocalStorage('usertoken');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AllFormValdation()),
        // BlocProvider(create: (ctx)=>UserloginBloc(authenticationBloc: authenticationBloc, userRepository: userRepository))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: storage.ready,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (storage.getItem('token') == null) {
              return NewLoginScrrens();
            }
            return HomeScreen();
          },
        ),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          LoginScreen.routeName: (ctx) =>
              LoginScreen(userRepository: userRepository),
          NewHomeScreen.routeName: (ctx) => NewHomeScreen(),
          NewLoginScreen.routeName: (ctx) => NewLoginScreen(),
        },
      ),
    );
  }
}
