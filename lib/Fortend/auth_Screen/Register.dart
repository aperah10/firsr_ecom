import 'package:first_ecom/Backend/Logic/Bloc/auth/userauthenticate_bloc.dart';
import 'package:first_ecom/Backend/Respo/auth/custLogin.dart';
import 'package:first_ecom/Fortend/auth_Screen/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_ecom/Backend/Logic/Bloc/Register/register_bloc.dart';
import 'package:first_ecom/Fortend/Widget/Form/formWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_ecom/Fortend/Widget/Form/formValdation.dart';
import 'package:provider/provider.dart';

import 'Home.dart';

// ====================================================================
// NEW LOGIN SCREEN
class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup-screens';

  final CustomUserLoginRespo userRepository;
  SignUpScreen({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) {
        return RegisterBloc(
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
                "SignUp",
                style: TextStyle(fontSize: 30.0),
              ),
            ),

            SignUpForm(userRepository: userRepository)
            // // Email Edit text
          ],
        ),
      ),
    ));
  }
}

// LOGIN FORM
class SignUpForm extends StatefulWidget {
  final CustomUserLoginRespo userRepository;
  SignUpForm({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState(userRepository);
}

class _SignUpFormState extends State<SignUpForm> {
  final CustomUserLoginRespo userRepository;
  _SignUpFormState(this.userRepository);
  final _form = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();

//   /* -------------------------------------------------------------------------- */
//   /*                            signupmethod for save                           */
//   /* -------------------------------------------------------------------------- */
  _registerNow() async {
    var isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState!.save();
    var isregis = await BlocProvider.of<RegisterBloc>(context)
      ..add(SignUpButtonPressed(
          phone: phoneController.text,
          password: passwordController.text,
          email: emailController.text,
          fullname: fullnameController.text));
  }
//   /* -------------------------------------------------------------------------- */
//   /*                             end REGISTER METHOD                            */
//   /* -------------------------------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    final regformvalid = Provider.of<AllFormValdation>(context);

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        print(' register state : - ${state}');
        if (state is RegisterFailed) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Login failed."),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is RegisterSucced) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 30.0),
            child: Form(
              key: _form,
              child: Column(children: [
                /* -------------------------------------------------------------------------- */
                /*                                 FORM FIELD                                 */
                /* -------------------------------------------------------------------------- */

                // NameEdit text
                FieldF(
                    hintText: 'Name',
                    inputType: TextInputType.name,
                    controller: fullnameController,
                    formValidator: (v) => regformvalid.fullnameValidator(v)),
                FieldF(
                  hintText: 'Mobile',
                  inputType: TextInputType.phone,
                  controller: phoneController,
                  formValidator: (v) => regformvalid.mobileValidator(v),
                ),
                FieldF(
                  hintText: 'Email',
                  inputType: TextInputType.emailAddress,
                  controller: emailController,
                  formValidator: (v) => regformvalid.emailValidator(v),
                ),
                FieldF(
                    obscureTxt: true,
                    hintText: 'Password',
                    controller: passwordController,
                    formValidator: (v) => regformvalid.passwordValidator(v),
                    inputType: TextInputType.visiblePassword),

                /* -------------------------------------------------------------------------- */
                /*                             // END  FORM FIELD                            */
                /* -------------------------------------------------------------------------- */

                /* -------------------------------------------------------------------------- */
                /*                                SUBMIT BUTTON   Start                             */
                /* -------------------------------------------------------------------------- */

                Padding(
                  padding: EdgeInsets.only(top: 25.0, bottom: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: state is RegisterLoading
                                    ? CupertinoActivityIndicator()
                                    : SubmitButton(
                                        btnName: 'Signup',
                                        submitMethod: _registerNow,
                                      ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                /* -------------------------------------------------------------------------- */
                /*                          END  SUBMIT BUTTON                              */
                /* -------------------------------------------------------------------------- */
                ExtraButton(
                    btnName: 'Login', createPage: LoginScreen.routeName),
              ]),
            ),
          );
        },
      ),
    );
  }
}
