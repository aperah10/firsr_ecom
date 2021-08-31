part of 'productshow_bloc.dart';

abstract class ProductshowState extends Equatable {}

class ProductshowInitial extends ProductshowState {
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductshowState {
  @override
  List<Object> get props => [];
}

class ProductLoadedState extends ProductshowState {
  List<ProductM> productData;
  ProductLoadedState({required this.productData});

  @override
  List<Object> get props => [];
}

class ProductErrorState extends ProductshowState {
  String message;
  ProductErrorState({required this.message});
  @override
  List<Object> get props => [];
}
