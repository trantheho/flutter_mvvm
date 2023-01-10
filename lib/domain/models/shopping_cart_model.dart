import 'product_model.dart';

class ShoppingCartModel {
  final ProductModel product;
  final int quantity;

  ShoppingCartModel({
    required this.product,
    required this.quantity,
  });

  ShoppingCartModel copyWith({ProductModel? product, int? quantity}) {
    return ShoppingCartModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
