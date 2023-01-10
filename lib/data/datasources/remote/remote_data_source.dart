import 'package:flutter_mvvm/domain/models/product_model.dart';

import '../../../domain/models/shopping_cart_model.dart';
import '../../../domain/models/user_model.dart';

abstract class UserDataSource{
  Future<UserModel> login({required String email, required String password});
}

abstract class ProductDataSource{
  Future<List<ProductModel>> fetchTrendingProduct();
  Future<List<ProductModel>> fetchCategory(String category);
  Future<bool> checkoutOrder(List<ShoppingCartModel> shoppingItems);
}
