import 'package:first_ecom/Backend/Logic/Bloc/auth/userauthenticate_bloc.dart';
import 'package:first_ecom/Fortend/Widget/drawer/dra.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

import 'new_login_scr.dart';

class NewHomeScreen extends StatelessWidget {
  static const routeName = '/new-home-screens';

  NewHomeScreen({
    Key? key,
  }) : super(key: key);
  LocalStorage storage = new LocalStorage('usertoken');

  @override
  Widget build(BuildContext context) {
    /* -------------------------------------------------------------------------- */
    /*                                LOGOUT BUTTON                               */
    /* -------------------------------------------------------------------------- */

    _logoutnew() async {
      await storage.clear();
      Navigator.of(context).pushReplacementNamed(NewLoginScrrens.routeName);
    }

    return Scaffold(
      // ! DRAWER FOR HOME PAGE
      drawer: MyDrawerList(),
      // ? END DRAWER
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _logoutnew,
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
