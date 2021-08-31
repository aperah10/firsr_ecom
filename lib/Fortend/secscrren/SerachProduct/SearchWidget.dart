import 'package:first_ecom/Backend/models/Product/Product_m.dart';
import 'package:first_ecom/Fortend/secscrren/SingleProductDeltails/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

// ! BUILD ERROR
Widget buildError(String message) {
  return Center(
    child: Text(message),
  );
}

// ! BUILD LOADING
Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

// ? BUILD HINT LIST

Widget buildHintsList(List<ProductM> prod) {
  //SearchFoodBloc searchBloc;
  return Container(
    child: Column(
      children: [
        new ListView.builder(
            itemCount: prod.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                // ! add PRODUCT ITEM DEIALS
                                ItemDetailsScreen(prod: prod[index])));
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 90,
                            width: 100,
                            child: Image.network(prod[index].pic ?? '')),
                        SizedBox(height: 30),
                        Text(prod[index].title ?? ''),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ],
    ),
  );
}
