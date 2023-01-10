import 'package:flutter_mvvm/domain/models/product_model.dart';
import 'package:flutter_mvvm/domain/models/shopping_cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shoppingCartProvider = StateNotifierProvider<ShoppingCartProvider, List<ShoppingCartModel>>(
  (ref) => ShoppingCartProvider(),
);

class ShoppingCartProvider extends StateNotifier<List<ShoppingCartModel>> {
  ShoppingCartProvider() : super([]);

  void addNewProduct(ProductModel product, int quantity) {
    final anyItem = state.isNotEmpty ? state.any((element) => element.product.id == product.id) : false;

    if (anyItem) {
      state = [
        for (final item in state)
          if (item.product.id == product.id)
            item.copyWith(quantity: item.quantity + quantity,)
          else
            item,
      ];
    } else {
      state = [
        ...state,
        ShoppingCartModel(
          product: product,
          quantity: quantity,
        ),
      ];
    }
  }

  void changeQuantity({required int quantity, required int productId,}) {
    state = [
      for (final item in state)
        if (item.product.id == productId) item.copyWith(quantity: quantity) else item,
    ];
  }

  void clearItems(){
    state = [];
  }
}
