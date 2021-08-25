import 'package:first_ecom/Backend/Logic/Bloc/auth/userauthenticate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewHomeScreen extends StatelessWidget {
  static const routeName = '/new-home-screens';
  NewHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<UserauthenticateBloc>(context).add(LoggedOut());
            },
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
