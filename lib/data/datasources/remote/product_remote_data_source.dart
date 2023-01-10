import 'package:flutter_mvvm/data/datasources/remote/remote_data_source.dart';
import 'package:flutter_mvvm/domain/models/product_model.dart';
import 'package:flutter_mvvm/domain/models/shopping_cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((ref){
  return ProductRemoteDataSource();
});

class ProductRemoteDataSource extends ProductDataSource {

  @override
  Future<List<ProductModel>> fetchCategory(String category) async {
    // call api to get list product with category

    return [];
  }

  @override
  Future<List<ProductModel>> fetchTrendingProduct() async {
    // call api to get trending product

    return [];
  }

  @override
  Future<bool> checkoutOrder(List<ShoppingCartModel> shoppingItems) async {
    return Future.delayed(const Duration(seconds: 1)).then((value) => true);
  }
}