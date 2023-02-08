import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/router/route_config.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/presentation/widgets/app_bar.dart';
import 'package:flutter_mvvm/presentation/widgets/button.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/l10n.dart';

class CheckoutResultPage extends StatelessWidget {
  const CheckoutResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Thank You',
          style: AppTextStyle.medium.copyWith(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.go(AppPage.cart.path),
          icon: Image.asset(
            AppImages.icRemove,
            color: AppColors.orange,
            width: 24,
            height: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 28.0,
          right: 28.0,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  AppImages.onBoardingThree,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Your Order in process',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bold.copyWith(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 34,
                  ),
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
            AppButton(
              buttonText: 'Track your order'.toUpperCase(),
              style: AppTextStyle.medium.copyWith(
                fontSize: 16,
              ),
              buttonColor: AppColors.lightYellow,
            ),
            SizedBox(
              height: context.padding.bottom + 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
