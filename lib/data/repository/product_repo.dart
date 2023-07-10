import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce/data/model/product_category_model.dart';
import 'package:ecommerce/data/model/product_model.dart';
import 'package:ecommerce/data/repository/api/api.dart';

class ProductRepo {
  API api = API();

  Future<List<String>> fetchCategory() async {
    try {
      Response response = await api.getData.get('/products/categories');

      return categoryModelFromJson(jsonEncode(response.data));
    } catch (expections) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProduct(String category) async {
    try {
      Response response = await api.getData.get('/products/category/$category');
      List<dynamic> productsMap = response.data;
      return productsMap.map((product) => ProductModel.fromJson(product)).toList();
    } catch (expections) {
      rethrow;
    }
  }
}
