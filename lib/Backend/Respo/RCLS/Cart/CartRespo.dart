import 'dart:convert';
import 'package:first_ecom/Backend/models/Cart/Cartm.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

/* -------------------------------------------------------------------------- */
/*           
              !     SHOW ALL PRODUCT LIST WITH TWO PATTERN :-  
              ! 1. MAKEING ANOTHER ABSTRACT CLASS :- LIKE THIS PAGE 
              ! 2. WITHOUT ANY ABSTRACT CLASS :- REGISTER, LOGIN PAGE   
                                                                                */
/* -------------------------------------------------------------------------- */
LocalStorage storage = new LocalStorage('usertoken');
var token = storage.getItem('token');

abstract class CartRespo {
  Future<List<CartM>> getCartData(dynamic token);
}

class CartDataRespo extends CartRespo {
  @override
  Future<List<CartM>> getCartData(dynamic token) async {
    String baseUrl = 'https://aperahwork.herokuapp.com/cart/';
    try {
      var res = await http.get(Uri.parse(baseUrl), headers: {
        "Authorization": "token $token",
      });
      print('Cart Respo :- $token');
      print('Cart RESPO :- ${res.statusCode}');
      if (res.statusCode == 200) {
        var datar = jsonDecode(res.body);
        print('datatr $datar');
        MainCartM mpt = MainCartM.fromJson({'productData': datar});
        print('Cart RESPO MPT:- $mpt');
        // List<ProductM> productData = MainProductM.fromJson({'datar':datar});
        List<CartM> cartData = mpt.cartData;
        print('Cart RESPO PRODDATA :- $cartData');

        return cartData;
      } else {
        // server error
        return Future.error("Server Error !");
      }
    } catch (SocketException) {
      // fetching error
      // may be timeout, no internet or dns not resolved
      return Future.error("Error Fetching Data !");
    }
  }
}
