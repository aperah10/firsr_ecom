import 'dart:convert';
import 'package:first_ecom/Backend/models/Product/Product_m.dart';
import 'package:http/http.dart' as http;

/* -------------------------------------------------------------------------- */
/*           
              !     SHOW ALL PRODUCT LIST WITH TWO PATTERN :-  
              ! 1. MAKEING ANOTHER ABSTRACT CLASS :- LIKE THIS PAGE 
              ! 2. WITHOUT ANY ABSTRACT CLASS :- REGISTER, LOGIN PAGE   
                                                                                */
/* -------------------------------------------------------------------------- */

abstract class ProductRespo {
  Future<List<ProductM>> getProduct();
}

class ProductDataRespo extends ProductRespo {
  String baseUrl = 'https://aperahwork.herokuapp.com/p/';
  @override
  Future<List<ProductM>> getProduct() async {
    try {
      var res = await http.get(Uri.parse(baseUrl));
      // print(res.statusCode);
      if (res.statusCode == 200) {
        var datar = jsonDecode(res.body);

        MainProductM mpt = MainProductM.fromJson({'productData': datar});
        // print(mpt);
        // List<ProductM> productData = MainProductM.fromJson({'datar':datar});
        List<ProductM> productData = mpt.productData;
        // print(productData);

        return productData;
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



/* -------------------------------------------------------------------------- */
/*           
              !    SHOW SINGLE PRODUCT LIST :-  
                
                                                                                */
/* -------------------------------------------------------------------------- */