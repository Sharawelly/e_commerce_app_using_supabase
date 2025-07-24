import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app_using_supabase/core/api_services.dart';
import 'package:e_commerce_app_using_supabase/core/models/product_model/product_model.dart';

import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeCubitInitial());

  final ApiServices _apiServices = ApiServices();
  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];
  List<ProductModel> categoryResults = [];

  Future<void> getProducts({String? query, String? category}) async {
    emit(GetDataLoading());
    try {
      final Response response = await _apiServices.getData(
        'products_table?select=*,favorite_products(*),purchase_table(*)',
      );
      for (var product in response.data as List) {
        products.add(ProductModel.fromJson(product));
      }
      log(response.toString());
      searchProducts(query);
      getProductsByCategory(category);
      emit(GetDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetDataError());
    }
  }

  void searchProducts(String? query) {
    if (query != null) {
      for (var product in products) {
        if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
  }

  void getProductsByCategory(String? category) {
    if (category != null) {
      for (var product in products) {
        if (product.category!.trim().toLowerCase() ==
            category.trim().toLowerCase()) {
          categoryResults.add(product);
        }
      }
    }
  }
}
