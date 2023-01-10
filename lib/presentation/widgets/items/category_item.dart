import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/domain/models/category_model.dart';

// ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  final CategoryModel item;
  double width;
  double height;
  double radius;
  Widget? info;
  bool active;
  Function()? onTap;

  CategoryItem({
    super.key,
    this.active = false,
    this.onTap,
    required this.item,
  })  : width = 93,
        height = 73,
        radius = 18,
        info = null;

  CategoryItem.withName({
    super.key,
    this.active = false,
    this.onTap,
    required this.item,
  })  : width = 138,
        height = 138,
        radius = 28,
        info = (item.title != null || item.title!.isNotEmpty) ? Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              item.title!,
              style: AppTextStyle.bold.copyWith(
                fontSize: 17,
                color: active ? AppColors.lightYellow : AppColors.orange,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            if(item.itemCount != null)
              Text(
              "${item.itemCount} items",
              style: AppTextStyle.medium.copyWith(
                fontSize: 10,
                color: active ? AppColors.lightYellow : AppColors.orange,
              ),
            ),
          ],
        ) : null;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black.withOpacity(0.26),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: active ? AppColors.lightYellow : Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(7, 0),
              color: Colors.black.withOpacity(0.26),
              blurRadius: 7,
              spreadRadius: 2,
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  item.imageUrl,
                  color: active ? AppColors.lightYellow : info != null ? AppColors.orange : AppColors.purple,
                  width: info != null ? 71 : 40,
                  height: info != null ? 71 : 40,
                ),
                if (info != null) info!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
