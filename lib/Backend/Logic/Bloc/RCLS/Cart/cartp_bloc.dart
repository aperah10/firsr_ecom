import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_ecom/Backend/Respo/RCLS/Cart/CartRespo.dart';
import 'package:first_ecom/Backend/models/Cart/Cartm.dart';
import 'package:localstorage/localstorage.dart';

part 'cartp_event.dart';
part 'cartp_state.dart';

class CartpBloc extends Bloc<CartpEvent, CartpState> {
  final CartRespo cartRespo;
  LocalStorage storage = new LocalStorage('usertoken');

  CartpBloc({required this.cartRespo, required this.storage})
      : super(CartpInitial());

  @override
  Stream<CartpState> mapEventToState(
    CartpEvent event,
  ) async* {
    if (event is FetchCartEvent) {
      yield CartLoadingState();
      try {
        dynamic token = storage.getItem('token');
        List<CartM> cartData = await cartRespo.getCartData(token);
        yield CartLoadedState(cartData: cartData);
      } catch (e) {
        yield CartErrorState(message: e.toString());
      }
    }
  }
}
