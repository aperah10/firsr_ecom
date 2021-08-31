import 'package:first_ecom/Backend/Logic/Bloc/product/Product_Show/productshow_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

// !my imports
import 'package:first_ecom/Backend/Respo/CNP_Respo/new_auth_respo/new_custlogin_respo.dart';
import 'package:first_ecom/Fortend/Widget/Form/formValdation.dart';
import 'package:first_ecom/Fortend/new_auth_screen/new_login_scr.dart';
import 'Backend/Respo/Product/ProdRespo.dart';

import 'Backend/storage/login/LoginStorage.dart';
import 'Fortend/auth_Screen/Home.dart';
import 'Fortend/new_auth_screen/new_home.dart';
import 'Fortend/new_auth_screen/new_signup_scr.dart';
import 'Fortend/secscrren/Product_Scr/GridViewList.dart';
import 'Fortend/secscrren/Product_Scr/ListView.dart';
import 'Fortend/secscrren/Product_Scr/MixProductList.dart';
import 'ZExtraFile/AllproviderList.dart';

main() {
  // final userRepository = CustomUserLoginRespo();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final CustomUserLoginRespo userRepository;

  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalStorage storage = new LocalStorage('usertoken');

    return MultiProvider(
      providers: MainBloc.allBlocs(),
      //     [
      //   ChangeNotifierProvider(create: (ctx) => NewCustomUserLoginRespo()),
      //   ChangeNotifierProvider(create: (ctx) => AllFormValdation()),
      //   BlocProvider(
      //       create: (ctx) => ProductshowBloc(prodRespo: ProductDataRespo()))
      // ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: storage.ready,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (storage.getItem('token') == null) {
              return NewLoginScrrens();
            }

            return NewHomeScreen();
          },
        ),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          NewHomeScreen.routeName: (ctx) => NewHomeScreen(),
          NewLoginScrrens.routeName: (ctx) => NewLoginScrrens(),
          NewSignUpScreen.routeName: (ctx) => NewSignUpScreen(),
          ProductGridView.routeName: (ctx) => ProductGridView(),
          ProductListView.routeName: (ctx) => ProductListView(),
        },
      ),
    );
  }
}
