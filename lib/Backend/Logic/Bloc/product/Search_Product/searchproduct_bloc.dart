import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_ecom/Backend/Respo/Product/SerachRespo.dart';
import 'package:first_ecom/Backend/models/Product/Product_m.dart';
import 'package:flutter/cupertino.dart';

part 'searchproduct_event.dart';
part 'searchproduct_state.dart';

class SearchproductBloc extends Bloc<SearchproductEvent, SearchproductState> {
  final SearchPRespo searchRepository;
  SearchproductBloc({required this.searchRepository})
      : super(SearchproductInitial());

  @override
  Stream<SearchproductState> mapEventToState(
    SearchproductEvent event,
  ) async* {
    if (event is SearchProd) {
      yield SearchproductInitial();
      try {
        List<ProductM> prod = await searchRepository.getSearchP(event.query);
        print('SEARCH BLOC ${prod}');
        yield SearchLoadedState(productData: prod);
      } catch (e) {
        yield SearachErrorState(message: e.toString());
      }
    }
  }
}
