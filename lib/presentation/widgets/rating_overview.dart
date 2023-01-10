import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/presentation/widgets/avatar_stack.dart';

class RatingOverview extends StatelessWidget {
  const RatingOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.icStar,
        ),
        const SizedBox(width: 9,),
        Text(
          '4.5',
          style: AppTextStyle.medium.copyWith(
            fontSize: 18,
            color: Colors.black,
          )
        ),
        const SizedBox(width: 9,),
        Text(
            '(128 reviews)',
            style: AppTextStyle.normal.copyWith(
              fontSize: 14,
              color: AppColors.grey170,
            )
        ),
        const Spacer(),
        AvatarStack(
          imageList: const [
            'https://scr.vn/wp-content/uploads/2020/08/Nh%C3%B3c-Maruko-d%E1%BB%85-th%C6%B0%C6%A1ng-1024x1024.jpeg',
            'https://demoda.vn/wp-content/uploads/2022/09/avatar-facebook-doc-ff.jpg',
            'https://phunugioi.com/wp-content/uploads/2022/11/hinh-anh-avatar-ff-nam-toc-trang.jpg',
          ],
          totalCount: 128,
          imageRadius: 42,
          imageBorderColor: Colors.white,
          backgroundColor: Colors.lightBlue,
          extraCountBorderColor: AppColors.greyWhite,
          extraCountTextStyle: AppTextStyle.medium.copyWith(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
