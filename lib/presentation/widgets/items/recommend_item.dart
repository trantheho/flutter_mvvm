import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/domain/models/recommend_product.dart';

class RecommendItem extends StatelessWidget {
  final RecommendProductModel item;

  const RecommendItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 263,
      height: 162,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: DecorationImage(
          image: AssetImage(item.asset),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 20,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              item.title,
              style: AppTextStyle.medium.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Text(
              item.description,
              style: AppTextStyle.medium.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
