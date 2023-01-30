import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/presentation/providers/shopping_cart_provider.dart';
import 'package:flutter_mvvm/presentation/widgets/items/product_order_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_controller.dart';
import '../../../core/router/route_config.dart';

class ShoppingCardPage extends StatefulWidget {
  const ShoppingCardPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCardPage> createState() => _ShoppingCardPageState();
}

class _ShoppingCardPageState extends State<ShoppingCardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Consumer(
                builder: (_,ref,__) {
                  final cart = ref.watch(shoppingCartProvider);

                  return cart.isEmpty
                      ? const Center(
                          child: Text('No order'),
                        )
                      : ListView.builder(
                          itemCount: cart.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 28),
                              child: ProductOrderItem(
                                order: cart[index],
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 42, right: 29.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: null,
            child: Text(
              'Item details',
              style: AppTextStyle.medium.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          Consumer(
            builder: (_,ref,__) {
              final shoppingCart = ref.watch(shoppingCartProvider);

              return TextButton(
                onPressed: (){
                  if(shoppingCart.isEmpty){
                    appController.dialog.showDefaultDialog(
                      context: context,
                      title: "No order",
                      message: "Please add more product",
                    );
                  }
                  else{
                    toCheckout();
                  }
                },
                child: Text(
                  'Place Order',
                  style: AppTextStyle.normal.copyWith(
                    fontSize: 16,
                    color: AppColors.orange,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void toCheckout() {
    context.pushNamed(
      AppPage.checkout.name,
    );
  }
}
