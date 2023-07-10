import '../../../data/model/cart_product_model.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final CartProductModel cartProduct;

  AddToCartEvent(this.cartProduct);
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;

  RemoveFromCartEvent(this.productId);
}

class UpdateQuantityEvent extends CartEvent {
  final int productId;
  final double quantity;

  UpdateQuantityEvent(this.productId, this.quantity);
}

class FetchCartEvent extends CartEvent {}
