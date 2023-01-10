import 'package:flutter_mvvm/data/repositories/product_repository/product_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shopping_cart_model.dart';
import '../repository/product_repository/product_repository.dart';

final checkoutOrderUseCaseProvider = Provider((ref){
  final productRepository = ref.read(productRepositoryProvider);

  return CheckoutOrderUseCase(productRepository);
});

class CheckoutOrderUseCase{

  CheckoutOrderUseCase(this.productRepository);

  final ProductRepository productRepository;

  Future<bool> run(List<ShoppingCartModel> shoppingItems) async {
    return await productRepository.checkoutOrder(shoppingItems);
  }
}