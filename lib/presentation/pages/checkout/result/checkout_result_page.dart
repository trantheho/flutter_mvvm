import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/app_assets.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/presentation/widgets/button.dart';

import '../../../../generated/l10n.dart';

class CheckoutResultPage extends StatelessWidget {
  const CheckoutResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          'Thank You',
          style: AppTextStyle.medium.copyWith(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: null,
            icon: Image.asset(
              AppImages.icRemove,
              color: AppColors.orange,
              width: 24,
              height: 24,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                AppImages.onBoardingTwoImg,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 28, right: 28),
              child: Column(
                children: [
                  const SizedBox(height: 34,),
                  Text(
                    'Your Order in process',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bold.copyWith(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 34,),
                  Text(
                    S.of(context).lorem,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.normal.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppButton(
            buttonText: 'Track your order'.toUpperCase(),
            style: AppTextStyle.medium.copyWith(
              fontSize: 16,
            ),
            buttonColor: AppColors.lightYellow,
          ),
        ],
      ),
    );
  }
}
