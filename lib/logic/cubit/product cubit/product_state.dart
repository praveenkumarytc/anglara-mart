import 'package:ecommerce/data/model/product_model.dart';

abstract class ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  List<ProductModel>? products;
  ProductLoadedState(this.products);
}

class ProductErrorState extends ProductState {
  String? error;
  ProductErrorState(this.error);
}
