import 'package:first_ecom/Backend/Logic/Bloc/auth/userauthenticate_bloc.dart';
import 'package:first_ecom/Fortend/Widget/Form/formValdation.dart';
import 'package:first_ecom/Fortend/Widget/Form/formWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// my imports
import 'package:first_ecom/Backend/Logic/Bloc/Login/userlogin_bloc.dart';
import 'package:first_ecom/Backend/Respo/auth/custLogin.dart';
import 'package:provider/provider.dart';

import 'Home.dart';

// ====================================================================
// NEW LOGIN SCREEN
class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screens';

  final CustomUserLoginRespo userRepository;
  LoginScreen({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) {
        return UserloginBloc(
          authenticationBloc: BlocProvider.of<UserauthenticateBloc>(context),
          userRepository: userRepository,
        );
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 30.0, top: 50.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: Color(0xffc5ccd6),
                    size: 30.0,
                  ),
                )),

            // Login Text Section
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 30.0),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 30.0),
              ),
            ),

            LoginForm(userRepository: userRepository)
            // // Email Edit text
          ],
        ),
      ),
    ));
  }
}

// LOGIN FORM
class LoginForm extends StatefulWidget {
  final CustomUserLoginRespo userRepository;
  LoginForm({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(userRepository);
}

class _LoginFormState extends State<LoginForm> {
  final CustomUserLoginRespo userRepository;
  _LoginFormState(this.userRepository);
  final _form = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formvalid = Provider.of<AllFormValdation>(context);

    _onLoginButtonPressed() async {
      var isvalid = _form.currentState!.validate();
      if (!isvalid) {
        return "Enter the Correct Value";
      }
      _form.currentState!.save();

      var isToken = BlocProvider.of<UserloginBloc>(context).add(
        LoginButtonPressed(
          phone: usernameController.text,
          password: passwordController.text,
        ),
      );
    }

    return BlocListener<UserloginBloc, UserloginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Login failed."),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is LoginSucccess) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }
      },
      child: BlocBuilder<UserloginBloc, UserloginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 80.0),
            child: Form(
              key: _form,
              child: Column(children: [
                /* -------------------------------------------------------------------------- */
                /*                                 FORM FIELD                                 */
                /* -------------------------------------------------------------------------- */
                FieldF(
                  hintText: 'phone',
                  controller: usernameController,
                  inputType: TextInputType.emailAddress,
                  formValidator: (String? val) =>
                      formvalid.mobileValidator(val),
                ),
                FieldF(
                    obscureTxt: true,
                    hintText: 'Password',
                    controller: passwordController,
                    inputType: TextInputType.visiblePassword,
                    formValidator: (String? val) =>
                        formvalid.passwordValidator(val)),

                /* -------------------------------------------------------------------------- */
                /*                              FORGETEN PASSWORD                             */
                /* -------------------------------------------------------------------------- */
                Align(
                  alignment: Alignment.centerRight,
                  child: new InkWell(
                      child: new Text(
                        "Forget password?",
                        style: TextStyle(color: Colors.black45, fontSize: 12.0),
                      ),
                      onTap: () {}),
                ),

                /* -------------------------------------------------------------------------- */
                /*                                SUBMIT BUTTON   Start                             */
                /* -------------------------------------------------------------------------- */

                Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                          height: 60,
                          child:
                              // state is LoginLoading
                              Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: state is LoginLoading
                                    ? CupertinoActivityIndicator()
                                    : SubmitButton(
                                        btnName: 'Login',
                                        submitMethod: _onLoginButtonPressed,
                                      ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
