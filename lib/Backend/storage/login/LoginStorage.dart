import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

class UserLoginStorage {
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  // 1. ======TOKEN HAS TOKEN
  Future<bool> loginhasToken() async {
    var value = await storage.read(key: 'usertoken');
    print('LOGIN TOKEN IN LOCAL STRAOGE :-  ${value}');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  // 2. ======== TOKEN PERSISTIT
  Future<void> loginpersistToken(String usertoken) async {
    await storage.write(key: 'usertoken', value: usertoken);
  }

  // 3. ======= TOKEN DELETE ==========
  Future<void> logindeleteToken() async {
    storage.delete(key: 'usertoken');
    storage.deleteAll();
  }

  /* -------------------------------------------------------------------------- */
  /*                             REGISTER TOKEN NEW                             */
  /* -------------------------------------------------------------------------- */

  // Future<bool> reghasToken() async {
  //   var value = await storage.read(key: 'regtoken');
  //   print('REGISTER TOKEN IN LOCALL STRAOGE :-  ${value}');
  //   if (value != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // // 2. ======== TOKEN PERSISTIT
  // Future<void> regpersistToken(String usertoken) async {
  //   await storage.write(key: 'regtoken', value: usertoken);
  // }

}
