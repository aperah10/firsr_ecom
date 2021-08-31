import 'package:first_ecom/Backend/Logic/Bloc/product/Product_Show/productshow_bloc.dart';
import 'package:first_ecom/Backend/Respo/Product/ProdRespo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ! my import
import 'package:first_ecom/Fortend/Widget/Grid_List_prod.dart/GridWidget.dart';

class ProductGridView extends StatefulWidget {
  static const routeName = '/grid-product-screens';
  ProductGridView({
    Key? key,
  }) : super(key: key);

  @override
  _ProductGridViewState createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  ProductshowBloc prodBloc = ProductshowBloc(prodRespo: ProductDataRespo());

  @override
  void initState() {
    prodBloc = BlocProvider.of<ProductshowBloc>(context);
    prodBloc.add(FetchProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductshowBloc, ProductshowState>(
        listener: (context, state) {},
        builder: (context, state) {
          print("produc page state: $state");
          if (state is ProductLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProductErrorState) {
            return Center(child: Text(' this is eror ${state.message}'));
          }
          if (state is ProductLoadedState) {
            return Scaffold(
                body: GridViewWidget(
              productstate: state.productData,
            ));
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
