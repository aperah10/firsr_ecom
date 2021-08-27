import 'package:first_ecom/Backend/Logic/Bloc/product/Product_Show/productshow_bloc.dart';
import 'package:first_ecom/Backend/Respo/Product/ProdRespo.dart';
import 'package:first_ecom/Fortend/Widget/AppBarWid.dart';
import 'package:first_ecom/Fortend/auth_Screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MixProductList extends StatefulWidget {
  MixProductList({Key? key}) : super(key: key);

  @override
  _MixProductListState createState() => _MixProductListState();
}

class _MixProductListState extends State<MixProductList> {
  ProductshowBloc prodBloc = ProductshowBloc(prodRespo: ProductDataRespo());

  @override
  void initState() {
    prodBloc = BlocProvider.of<ProductshowBloc>(context);
    prodBloc.add(FetchProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          titlename: 'Product',
          createPage: HomeScreen.routeName,
        ),
        body: BlocConsumer<ProductshowBloc, ProductshowState>(
            listener: (context, state) {},
            builder: (context, state) {
              print("produc page state: $state");
              if (state is ProductLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }));
  }
}
