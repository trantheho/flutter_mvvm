import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm/core/app_controller.dart';
import 'package:flutter_mvvm/presentation/providers/shipping_cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/checkout_order_usecase.dart';


final checkoutProvider = StateNotifierProvider.autoDispose<CheckoutProvider, bool?>((ref) {
  final checkoutUseCase = ref.read(checkoutOrderUseCaseProvider);

  return CheckoutProvider(ref, checkoutUseCase);
});

class CheckoutProvider extends StateNotifier<bool?> {

  CheckoutProvider(this.ref, this.checkoutOrderUseCase,) : super(null);

  final Ref ref;
  final CheckoutOrderUseCase checkoutOrderUseCase;


  Future<void> checkoutOrder() async {
    try{
      final shoppingItems = ref.watch(shoppingCartProvider);
      appController.loading.show();
      state = await checkoutOrderUseCase.run(shoppingItems);
      if(state != null && state!) {
        ref.read(shoppingCartProvider.notifier).clearItems();
      }
      appController.loading.hide();
    }
    catch (e){
      state = false;
      appController.loading.hide();
    }
  }
}