import '../../../data/model/cart_product_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartProductModel> cartItems;
  final double totalCartValue;

  CartLoaded(this.cartItems, this.totalCartValue);
}

class CartError extends CartState {
  final String error;

  CartError(this.error);
}
