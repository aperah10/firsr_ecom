import 'package:first_ecom/Backend/Logic/Bloc/auth/userauthenticate_bloc.dart';
import 'package:first_ecom/Backend/storage/login/LoginStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Login.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screens';
  HomeScreen({
    Key? key,
  }) : super(key: key);

  final userstorage = UserLoginStorage();
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    /* -------------------------------------------------------------------------- */
    /*                                CHECK LOGOUT                                */
    /* -------------------------------------------------------------------------- */
    _seclogoutnew() async {
      await storage.delete(key: 'usertoken');
      storage.deleteAll();
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _seclogoutnew,
            //     () {
            //   BlocProvider.of<UserauthenticateBloc>(context).add(LoggedOut());
            // },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text("Hello, home page "),
          ),
        ],
      ),
    );
  }
}
