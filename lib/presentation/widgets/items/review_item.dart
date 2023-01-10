import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/domain/models/review_model.dart';
import 'package:intl/intl.dart';

class ReviewItem extends StatelessWidget {
  final ReviewModel item;
  const ReviewItem({Key? key, required this.item,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyWhite,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                item.title,
                style: AppTextStyle.bold.copyWith(),
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(item.reviewDate),
                style: AppTextStyle.normal.copyWith(
                  color: AppColors.grey170,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildRating(item.rating),
              Text(
                item.userModel.name,
                style: AppTextStyle.normal.copyWith(
                  color: AppColors.grey170,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0,),
          Text(
            item.message,
            style: AppTextStyle.normal.copyWith(
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }

  Widget buildRating(int rating){
    return Row(
      children: [1,2,3,4,5].map((e) => Padding(
        padding: const EdgeInsets.only(right: 1.0),
        child: Icon(
          e <= rating ? Icons.star : Icons.star_border_outlined,
          color: AppColors.lightYellow,
          size: 18,
        ),
      )).toList(),
    );
  }
}
