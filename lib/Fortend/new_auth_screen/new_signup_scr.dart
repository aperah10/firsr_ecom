import 'package:first_ecom/Backend/Respo/CNP_Respo/new_auth_respo/new_custlogin_respo.dart';
import 'package:first_ecom/Fortend/Widget/Form/formValdation.dart';
import 'package:first_ecom/Fortend/Widget/Form/formWidget.dart';
import 'package:first_ecom/Fortend/new_auth_screen/new_home.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'new_login_scr.dart';

class NewSignUpScreen extends StatefulWidget {
  @override
  _NewSignUpScreenState createState() => _NewSignUpScreenState();
}

class _NewSignUpScreenState extends State<NewSignUpScreen> {
  final _form = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();

  _registerNow() async {
    var isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState!.save();
    bool isregis = await Provider.of<NewCustomUserLoginRespo>(
      context,
      listen: false,
    ).registernow(
        phone: phoneController.text,
        password: passwordController.text,
        email: emailController.text,
        fullname: fullnameController.text);
    if (isregis) {
      Navigator.of(context).pushReplacementNamed(NewHomeScreen.routeName);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Something is wrong.Try Again"),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    /* -------------------------------------------------------------------------- */
    /*                           FORM VALIDTION PROVIDER                          */
    /* -------------------------------------------------------------------------- */
    final regformvalid = Provider.of<AllFormValdation>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //        // Login Back Button Section
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
                  "Sign Up",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),

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

              // Login Button
              Center(
                  child: SubmitButton(
                btnName: 'Signup',
                submitMethod: _registerNow,
              )),

              ExtraButton(
                  btnName: 'Login', createPage: () => NewLoginScrrens()),
            ],
          ),
        ),
      ),
    );
  }
}
