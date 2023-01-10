import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/app_assets.dart';
import 'package:flutter_mvvm/domain/models/shopping_cart_model.dart';
import 'package:flutter_mvvm/presentation/providers/shipping_cart_provider.dart';
import 'package:flutter_mvvm/presentation/widgets/quantity_count.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/utils/styles.dart';
import '../../../domain/models/product_model.dart';

class ProductOrderItem extends StatefulWidget {
  final ShoppingCartModel order;
  const ProductOrderItem({Key? key, required this.order,}) : super(key: key);

  @override
  State<ProductOrderItem> createState() => _ProductOrderItemState();
}

class _ProductOrderItemState extends State<ProductOrderItem> {
  final ValueNotifier<int> quantityNotifier = ValueNotifier(1);
  late final ValueKey key;

  @override
  void initState() {
    super.initState();
    key = ValueKey(widget.order.product.name);
    quantityNotifier.value = widget.order.quantity;
  }

  @override
  void dispose() {
    quantityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 137,
      child: Slidable(
        key: key,
        endActionPane: const ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: null,
              icon: Icons.delete,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ],
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(18.0),
              bottomRight: Radius.circular(18.0),
            ),
          ),
          child: Row(
            children: [
              _buildCover(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.order.product.productType.toUpperCase(),
                        style: AppTextStyle.normal.copyWith(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        widget.order.product.name,
                        style: AppTextStyle.medium.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ValueListenableBuilder<int>(
                              valueListenable: quantityNotifier,
                              builder: (_, quantity, __) {
                                final price = (widget.order.product.price * quantity).toStringAsFixed(1);
                                return Text(
                                  '\$$price',
                                  style: AppTextStyle.normal.copyWith(
                                    fontSize: 18,
                                    color: AppColors.orange,
                                  ),
                                );
                              }
                          ),
                          Consumer(
                            builder: (_,ref, __) {
                              final shoppingCart = ref.read(shoppingCartProvider.notifier);

                              return QuantityCount(
                                backgroundColor: AppColors.grey239,
                                radius: 18.0,
                                buttonColor: AppColors.grey177,
                                initCount: widget.order.quantity,
                                itemCountChange: (quantity){
                                  quantityNotifier.value = quantity;
                                  shoppingCart.changeQuantity(quantity: quantity, productId: widget.order.product.id,);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCover() {
    return Container(
      width: 93.0,
      height: 113.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        image: DecorationImage(
          image: AssetImage(widget.order.product.imageUrl),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            color: AppColors.lightYellow,
          ),
          //margin: EdgeInsets.only(left: 1, right: 1,),
          child: Center(
            child: Text(
              widget.order.product.priceString,
              style: AppTextStyle.medium.copyWith(fontSize: 18,),
            ),
          ),
        ),
      ),
    );
  }
}
