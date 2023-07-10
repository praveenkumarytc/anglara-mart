import 'package:dio/dio.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/logic/cubit/product%20cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/product_repo.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductLoadingState());

  ProductRepo productRepo = ProductRepo();

  void fetchProduct(String category) async {
    try {
      emit(ProductLoadingState());
      List<ProductModel> products = await productRepo.fetchProduct(category);

      emit(ProductLoadedState(products));
    } on DioException catch (e) {
      emit(ProductErrorState('${e.message}'));
    }
  }
}
