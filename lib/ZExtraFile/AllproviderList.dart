import 'package:first_ecom/Backend/Logic/Bloc/product/Product_Show/productshow_bloc.dart';
import 'package:first_ecom/Backend/Respo/CNP_Respo/new_auth_respo/new_custlogin_respo.dart';
import 'package:first_ecom/Backend/Respo/Product/ProdRespo.dart';
import 'package:first_ecom/Backend/storage/login/LoginStorage.dart';
import 'package:first_ecom/Fortend/Widget/Form/formValdation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MainBloc {
  static List<SingleChildWidget> allBlocs() {
    return [
      ChangeNotifierProvider(create: (ctx) => NewCustomUserLoginRespo()),
      ChangeNotifierProvider(create: (ctx) => AllFormValdation()),
      BlocProvider(
          create: (ctx) => ProductshowBloc(prodRespo: ProductDataRespo())),
    ];
  }
}
