import 'package:dio/dio.dart';
import 'package:ecommerce/data/repository/product_repo.dart';
import 'package:ecommerce/logic/cubit/category%20cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryLoadingState()) {
    fetchCategory();
  }

  ProductRepo productRepo = ProductRepo();

  void fetchCategory() async {
    try {
      List<String> productCategories = await productRepo.fetchCategory();

      emit(CategoryLoadedState(productCategories));
    } on DioException catch (e) {
      emit(CategoryErrorState('${e.message}'));
    }
  }
}
