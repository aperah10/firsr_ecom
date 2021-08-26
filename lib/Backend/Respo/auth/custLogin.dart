import 'dart:convert';
import 'package:first_ecom/Backend/storage/login/LoginStorage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class CustomUserLoginRespo {
  final userloginStorage = UserLoginStorage();
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
        body: json.encode({"phone": phone, "password": password}),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      var data = json.decode(res.body);
      print(' this is status code :- ${res.statusCode}');

      if (res.statusCode == 200 || data.containsKey("token")) {
        // print(' this storag read key  ${storage.read(key: 'token')}');
        return data["token"];
      }
      return 'errror';
    } catch (SocketException) {
      // fetching error
      return "err ${SocketException}";
      // return false;
    }
  }

  // // 2.   SIGNUP PAGE ========================
  Future<String> registernow(
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
      print(' this is status code :- ${res.statusCode}');
      if (res.statusCode == 200 || data.containsKey("regtoken")) {
        // var hastoken = storage.setItem("token", data['token']);
        // print('set token ${hastoken}');
        // print(storage.getItem('token'));
        print('register data token  in RESPO:- ${data["token"]}');
        print('register token in RESPO:- ${data.containsKey("token")}');
        return data['token'];
        // return true;
      }

      // return false;
      return 'errror';
    } catch (SocketException) {
      print("error $SocketException");
      // return false;
      return 'errror';
    }
  }
}

//   Future<String> login(String phone, String password) async {
//     Response response = await _dio.post(loginUrl, data: {
//       "email": phone,
//       "password": password,
//     });
//     return response.data["token"];
//   }

// }
