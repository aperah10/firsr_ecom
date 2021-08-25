import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

class UserLoginStorage {
  LocalStorage storage = new LocalStorage('usertoken');

  // 1. ======TOKEN HAS TOKEN
  Future<bool> LoginhasToken() async {
    var value = await storage.getItem('usertoken');
    print('this is token ${value}');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  // 2. ======== TOKEN PERSISTIT
  Future<void> LoginpersistToken(String usertoken) async {
    await storage.setItem('usertoken', usertoken);
  }

  // 3. ======= TOKEN DELETE ==========
  Future<void> LogindeleteToken() async {
    storage.deleteItem('usertoken');
    storage.clear();
  }
}


  // final FlutterSecureStorage storage = new FlutterSecureStorage();
  // // 1. ======TOKEN HAS TOKEN
  // Future<bool> hasToken() async {
  //   var value = await storage.read(key: 'usertoken');
  //   print('this is token ${value}');
  //   if (value != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // // 2. ======== TOKEN PERSISTIT
  // Future<void> persistToken(String usertoken) async {
  //   await storage.write(key: 'usertoken', value: usertoken);
  // }

  // // 3. ======= TOKEN DELETE ==========
  // Future<void> deleteToken() async {
  //   storage.delete(key: 'usertoken');
  //   storage.deleteAll();
  // }