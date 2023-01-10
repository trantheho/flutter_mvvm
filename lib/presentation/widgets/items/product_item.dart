import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/domain/models/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final Function()? onTap;
  const ProductItem({Key? key, required this.product, this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: product.name,
      child: Material(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: AssetImage(product.imageUrl),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppImages.icHeart,
                    color: product.favorite ? AppColors.pink : Colors.white,
                  ),
                  const Spacer(),
                  Text(
                    product.name,
                    style: AppTextStyle.medium.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    product.priceString,
                    style: AppTextStyle.medium.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
