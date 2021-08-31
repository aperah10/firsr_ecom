// To parse this JSON data, do
//
//     final cartM = cartMFromMap(jsonString);

import 'dart:convert';

import 'dart:convert';

MainCartM mainProductMFromJson(String str) =>
    MainCartM.fromJson(json.decode(str));

String mainProductMToJson(MainCartM data) => json.encode(data.toJson());

class MainCartM {
  List<CartM> cartData;
  MainCartM({required this.cartData});

  factory MainCartM.fromJson(Map<String, dynamic> json) => MainCartM(
        cartData:
            List<CartM>.from(json["cartData"].map((x) => CartM.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cartData": List<dynamic>.from(cartData.map((x) => x.toJson())),
      };
}

// ! CART LIST MODEL MAIN
// CartM cartMFromJson(String str) => CartM.fromJson(json.decode(str));

// String cartMToJson(CartM data) => json.encode(data.toJson());

class CartM {
  CartM({
    this.id,
    this.quantity,
    this.createdOn,
    this.product,
    this.customerCart,
  });

  late String? id;
  late int? quantity;
  late DateTime? createdOn;
  late String? product;
  late String? customerCart;

  factory CartM.fromJson(Map<String, dynamic> json) => CartM(
        id: json["id"],
        quantity: json["quantity"],
        createdOn: DateTime.parse(json["created_on"]),
        product: json["product"],
        customerCart: json["customer_cart"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "created_on": createdOn,
        "product": product,
        "customer_cart": customerCart,
      };
}
