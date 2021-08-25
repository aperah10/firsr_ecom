import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class NewCustomUserLoginRespo with ChangeNotifier {
  LocalStorage storage = new LocalStorage('usertoken');
/* -------------------------------------------------------------------------- */
/*                                this is LOGIN                               */
/* -------------------------------------------------------------------------- */
  // LOGIN PAGE
  Future<bool> newloginNow(
      {required String phone, required String password}) async {
    String Baseurl = "https://aperahwork.herokuapp.com/login/";
    try {
      var res = await http.post(Uri.parse(Baseurl),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: json.encode({"phone": phone, "password": password}));

      var data = json.decode(res.body);
      print(' this is status code :- ${res.statusCode}');

      if (data.containsKey("token")) {
        var hastoken = storage.setItem("token", data['token']);
        print('set token ${hastoken}');
        print(storage.getItem('token'));
        return true;
      }
      return false;
    } catch (SocketException) {
      // fetching error
      return false;
    }
  }

  // 2.   SIGNUP PAGE ========================
  Future<bool> registernow(
      {required String email,
      required String phone,
      required String fullname,
      required String password}) async {
    String Baseurl = "https://aperahwork.herokuapp.com/crusr";
    try {
      var res = await http.post(Uri.parse(Baseurl),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({
            "email": email,
            "fullname": fullname,
            "phone": phone,
            "password": password
          }));

      var data = json.decode(res.body) as Map;
      print(data);
      if (res.statusCode == 200 || data.containsKey("token")) {
        var hastoken = storage.setItem("token", data['token']);
        print('set token ${hastoken}');
        print(storage.getItem('token'));
        return true;
      }

      return false;
    } catch (SocketException) {
      // fetching error
      return false;
    }
  }
}
