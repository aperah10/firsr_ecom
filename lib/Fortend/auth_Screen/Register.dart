// import 'package:first_ecom/Fortend/Widget/Form/formWidget.dart';
// import 'package:first_ecom/Fortend/auth_Screen/Home.dart';
// import 'package:flutter/material.dart';

// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: initScreen(context),
//       ),
//     );
//   }

//   initScreen(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
// //        // Login Back Button Section
//         Container(
//             margin: EdgeInsets.only(left: 30.0, top: 50.0),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//               child: Icon(
//                 Icons.keyboard_backspace,
//                 color: Color(0xffc5ccd6),
//                 size: 30.0,
//               ),
//             )),

//         // Login Text Section
//         Container(
//           margin: EdgeInsets.only(top: 20.0, left: 30.0),
//           child: Text(
//             "Sign Up",
//             style: TextStyle(fontSize: 30.0),
//           ),
//         ),

//         // NameEdit text
//         FieldF(hintText: 'Name', ,inputType: TextInputType.name),
//         FieldF(hintText: 'Email', inputType: TextInputType.emailAddress),
//         FieldF(
//             obscureTxt: true,
//             hintText: 'Password',
//             inputType: TextInputType.visiblePassword),

//         // Login Button
//         Center(
//             child: SubmitButton( btnName: 'Signup',)),

//         // ExtraButton(btnName:'Login',createPage:()=> LoginScreen()),
//       ],
//     );
//   }
// }
