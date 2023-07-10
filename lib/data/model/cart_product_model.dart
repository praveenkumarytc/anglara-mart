import 'package:ecommerce/data/model/product_model.dart';

class CartProductModel extends ProductModel {
  double quantity;

  CartProductModel({
    required this.quantity,
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
  }) : super(
          id: id,
          title: title,
          price: price,
          description: description,
          category: category,
          image: image,
          rating: rating,
        );

  factory CartProductModel.fromProductModel(ProductModel productModel, double quantity) {
    return CartProductModel(
      quantity: quantity,
      id: productModel.id,
      title: productModel.title,
      price: productModel.price,
      description: productModel.description,
      category: productModel.category,
      image: productModel.image,
      rating: productModel.rating,
    );
  }

  CartProductModel copyWith({double? quantity}) {
    return CartProductModel(
      quantity: quantity ?? this.quantity,
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = super.toJson();
    json["quantity"] = quantity;
    return json;
  }
}
