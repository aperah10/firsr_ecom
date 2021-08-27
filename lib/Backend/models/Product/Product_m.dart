import 'dart:convert';

MainProductM mainProductMFromJson(String str) =>
    MainProductM.fromJson(json.decode(str));

String mainProductMToJson(MainProductM data) => json.encode(data.toJson());

class MainProductM {
  MainProductM({
    required this.productData,
  });

  List<ProductM> productData;

  // factory MainProductM.fromJson(Map<String, dynamic> json) => MainProductM(
  //     data: List<ProductM>.from(json["data"].map((x) => ProductM.fromJson(x))),
  // );
  factory MainProductM.fromJson(Map<String, dynamic> json) => MainProductM(
        productData: List<ProductM>.from(
            json["productData"].map((x) => ProductM.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productData": List<dynamic>.from(productData.map((x) => x.toJson())),
      };
}

class ProductM {
  ProductM({
    this.id,
    this.title,
    this.description,
    this.salesPrice,
    this.discountPrice,
    this.ourPrice,
    this.category,
    this.date,
    this.stock,
    this.pic,
    this.offers,
    this.uplod,
  });

  late String? id;
  late String? title;
  late String? description;
  late int? salesPrice;
  late int? discountPrice;
  late int? ourPrice;
  late String? category;
  late String? date;
  late int? stock;
  late String? pic;
  late int? offers;
  late String? uplod;

  factory ProductM.fromJson(Map<String, dynamic> json) => ProductM(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        salesPrice: json["sales_price"],
        discountPrice: json["discount_price"],
        ourPrice: json["our_price"],
        category: json["category"],
        date: json["date"],
        stock: json["stock"],
        pic: json["pic"],
        offers: json["offers"],
        uplod: json["uplod"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "sales_price": salesPrice,
        "discount_price": discountPrice,
        "our_price": ourPrice,
        "category": category,
        "date": date,
        "stock": stock,
        "pic": pic,
        "offers": offers,
        "uplod": uplod,
      };
}
