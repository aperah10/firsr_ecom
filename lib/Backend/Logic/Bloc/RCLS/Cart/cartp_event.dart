part of 'cartp_bloc.dart';

abstract class CartpEvent extends Equatable {
  CartpEvent();

  @override
  List<Object> get props => [];
}

class FetchCartEvent extends CartpEvent {
  @override
  List<Object> get props => [];
}

class CartInitializedEvent extends CartpEvent {}

class ItemAddingCartEvent extends CartpEvent {
  // List<ShopItem> cartItems;

  // ItemAddingCartEvent({this.cartItems});
}

class ItemAddedCartEvent extends CartpEvent {
  // List<ShopItem> cartItems;

  // ItemAddedCartEvent({this.cartItems});
}

class ItemDeleteCartEvent extends CartpEvent {
  // List<ShopItem> cartItems;
  // int index;
  // ItemDeleteCartEvent({this.cartItems, this.index});
}
