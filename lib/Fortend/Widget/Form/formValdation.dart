import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllFormValdation with ChangeNotifier {
  mobileValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter the Mobile Number';
    }
    return null;
  }

  emailValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter the Email';
    }
    return null;
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
