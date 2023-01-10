import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm/domain/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/product_repository/product_repository_impl.dart';


final trendingProducts = FutureProvider<List<ProductModel>>((ref) async {
  debugPrint('call fetch trending product');
  final productRepo = ref.read(productRepositoryProvider);
  return await productRepo.fetchTrendingProduct();
});

final trendingProductProvider =
AsyncNotifierProvider<TrendingProductNotifier, List<ProductModel>>(TrendingProductNotifier.new);

class TrendingProductNotifier extends AsyncNotifier<List<ProductModel>>{
  @override
  FutureOr<List<ProductModel>> build() async {
    debugPrint('trending build');
    return ref.watch(trendingProducts.future);
  }

  void setFavorite(int productId, bool isFavorite){
    state = AsyncData([
      for(final product in state.value!)
        if(product.id == productId)
          product.copyWith(favorite: isFavorite)
        else
          product,
    ]);
  }
}

/// Category
