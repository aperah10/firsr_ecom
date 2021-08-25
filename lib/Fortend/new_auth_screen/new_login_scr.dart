import 'package:first_ecom/Backend/Respo/CNP_Respo/new_auth_respo/new_custlogin_respo.dart';
import 'package:first_ecom/Fortend/Widget/Form/formValdation.dart';
import 'package:first_ecom/Fortend/Widget/Form/formWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'new_home.dart';
import 'new_signup_scr.dart';

class NewLoginScrrens extends StatefulWidget {
  static const routeName = '/new-login-screens';

  @override
  _NewLoginScrrensState createState() => _NewLoginScrrensState();
}

class _NewLoginScrrensState extends State<NewLoginScrrens> {
  final _form = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formvalid = Provider.of<AllFormValdation>(context);

    _loginNew() async {
      var isvalid = _form.currentState!.validate();
      if (!isvalid) {
        return "enter valve";
      }
      _form.currentState!.save();
      var istoken = await Provider.of<NewCustomUserLoginRespo>(
        context,
        listen: false,
      ).newloginNow(
          phone: usernameController.text, password: passwordController.text);
      print("tis valid $isvalid");
      print("is token  $istoken");
      if (istoken == true) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Now"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                /* -------------------------------------------------------------------------- */
                /*                                 FORM FILED                                 */
                /* -------------------------------------------------------------------------- */
                FieldF(
                  hintText: 'phone',
                  controller: usernameController,
                  inputType: TextInputType.phone,
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
                /*                               END FORM FIELD                               */
                /* -------------------------------------------------------------------------- */
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
                                child: SubmitButton(
                                  btnName: 'Login',
                                  submitMethod: _loginNew,
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                /* -------------------------------------------------------------------------- */
                /*                           END FROM SUBMIT BUTTON                           */
                /* -------------------------------------------------------------------------- */
                ExtraButton(
                    btnName: 'Signup', createPage: () => NewSignUpScreen()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
