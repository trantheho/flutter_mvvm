import '../../models/product_model.dart';
import '../../models/shopping_cart_model.dart';

abstract class ProductRepository{
  Future<List<ProductModel>> fetchTrendingProduct();
  Future<List<ProductModel>> fetchCategory(String category);
  Future<bool> checkoutOrder(List<ShoppingCartModel> shoppingItems);
}