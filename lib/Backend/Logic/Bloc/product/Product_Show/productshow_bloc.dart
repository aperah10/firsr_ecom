import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_ecom/Backend/Respo/Product/ProdRespo.dart';
import 'package:first_ecom/Backend/models/Product/Product_m.dart';

part 'productshow_event.dart';
part 'productshow_state.dart';

class ProductshowBloc extends Bloc<ProductshowEvent, ProductshowState> {
  final ProductRespo prodRespo;
  ProductshowBloc({required this.prodRespo}) : super(ProductshowInitial());

  @override
  Stream<ProductshowState> mapEventToState(
    ProductshowEvent event,
  ) async* {
    if (event is FetchProductEvent) {
      yield ProductLoadingState();

      try {
        List<ProductM> productData = await prodRespo.getProduct();
        yield ProductLoadedState(productData: productData);
      } catch (e) {
        yield ProductErrorState(message: e.toString());
      }
    }
  }
}
