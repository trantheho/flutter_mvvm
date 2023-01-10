import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/datasources/remote/remote_data_source.dart';
import 'package:flutter_mvvm/domain/models/product_model.dart';
import 'package:flutter_mvvm/domain/models/shopping_cart_model.dart';
import 'package:flutter_mvvm/domain/repository/product_repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_assets.dart';
import '../../datasources/remote/product_remote_data_source.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref){
  final remoteDataSource = ref.read(productRemoteDataSourceProvider);

  return ProductRepositoryImpl(remoteDataSource);
});

class ProductRepositoryImpl extends ProductRepository {

  ProductRepositoryImpl(this.productRemoteDataSource);

  final ProductRemoteDataSource productRemoteDataSource;


  @override
  Future<List<ProductModel>> fetchTrendingProduct() async {
    debugPrint(' fetch trending product in api');
    await Future.delayed(const Duration(seconds: 1));
    return [
      ProductModel(
        imageUrl: AppImages.avocado,
        name: "Avocado",
        price: 6.7,
        priceString: r"$6.7",
        favorite: true,
        productType: 'fruits',
        id: 1,
      ),
      ProductModel(
        imageUrl: AppImages.brocoli,
        name: "Brocoli",
        price: 8.7,
        priceString: "\$8.7",
        favorite: false,
        productType: 'fruits',
        id: 2,
      ),
      ProductModel(
        imageUrl: AppImages.tomatoes,
        name: "Tomatoes",
        price: 4.9,
        priceString: r"$4.9",
        favorite: false,
        productType: 'fruits',
        id: 3,
      ),
      ProductModel(
        imageUrl: AppImages.grapes,
        name: "Grapes",
        price: 7.2,
        priceString: r"$7.2",
        favorite: false,
        productType: 'fruits',
        id: 4,
      ),
    ];
  }

  @override
  Future<List<ProductModel>> fetchCategory(String category) async {
    return await productRemoteDataSource.fetchCategory(category);
  }

  @override
  Future<bool> checkoutOrder(List<ShoppingCartModel> shoppingItems) async {
    return await productRemoteDataSource.checkoutOrder(shoppingItems);
  }
}
