import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class AllFormValdation with ChangeNotifier {
  mobileValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter the Mobile Number';
    }

    return null;
    notifyListeners();
  }

  emailValidator(String? val) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (val == null || val.isEmpty) {
      return 'Enter the Email';
    }

    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(val)) {
      return "enter valid email";
    }
  }

  fullnameValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter the Fullname';
    }
    return null;
  }

  passwordValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter the Password';
    }
    return null;
  }
}
