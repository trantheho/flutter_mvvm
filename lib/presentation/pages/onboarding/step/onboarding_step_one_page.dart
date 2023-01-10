import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/generated/l10n.dart';

class OnBoardingStepOnePage extends StatelessWidget {
  const OnBoardingStepOnePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, right: 28),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(AppImages.onBoardingOne),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  S.of(context).welcome,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bold.copyWith(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24,),
                Text(
                  S.of(context).appName,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bold.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24,),
                Text(
                  S.of(context).lorem,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.normal.copyWith(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
