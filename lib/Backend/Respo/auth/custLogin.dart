import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class CustomUserLoginRespo {
  // // STORAGE FOR TOKEN DATA
  LocalStorage storage = new LocalStorage('usertoken');

  // 1. ======TOKEN HAS TOKEN
  Future<bool> loginhasToken() async {
    var value = await storage.getItem('usertoken');
    print('this is token ${value}');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  // 2. ======== TOKEN PERSISTIT
  Future<void> loginpersistToken(String usertoken) async {
    await storage.setItem('usertoken', usertoken);
  }

  // 3. ======= TOKEN DELETE ==========
  Future<void> logindeleteToken() async {
    storage.deleteItem('usertoken');
    storage.clear();
  }

/* -------------------------------------------------------------------------- */
/*                                this is LOGIN                               */
/* -------------------------------------------------------------------------- */
  // LOGIN PAGE
  Future<String> loginnow(
      {required String phone, required String password}) async {
    String Baseurl = "https://aperahwork.herokuapp.com/login/";
    try {
      var res = await http.post(
        Uri.parse(Baseurl),
        // body: jsonEncode(res),
        body: {
          "username": phone,
          "password": password,
        },
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      var data = json.decode(res.body) as Map;
      print(' this is status code :- ${res.statusCode}');
      if (res.statusCode == 200) {
        return "success";
      }
      if (res.statusCode == 404) {
        return "not Valid ";
      } else {
        print(res.body);
        // server error
        return "err";
      }
    } catch (SocketException) {
      // fetching error
      return "err ${SocketException}";
    }
    //   if (data.containsKey("token")) {
    //     storage.setItem("token", data['token']);
    //     print(storage.getItem('token'));
    //     return true;
    //   }
    //   return false;
    // } catch (e) {
    //   print("e loginNow");
    //   print(e);
    //   return false;
    // }
  }

  // // 2.   SIGNUP PAGE ========================
  // Future<bool> registernow(
  //     String email, String phone, String fullname, String password) async {
  //   String Baseurl = "https://reqres.in/api/register";
  //   try {
  //     var res = await http.post(Uri.parse(Baseurl),
  //         headers: {
  //           "Content-Type": "application/json",
  //         },
  //         body: json.encode({
  //           "email": email,
  //           "fullname": fullname,
  //           "phone": phone,
  //           "password": password
  //         }));

  //     var data = json.decode(res.body) as Map;
  //     print(data);
  //     if (data["error"] == false) {
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     print("e loginNow");
  //     print(e);
  //     return false;
  //   }
  // }
}
