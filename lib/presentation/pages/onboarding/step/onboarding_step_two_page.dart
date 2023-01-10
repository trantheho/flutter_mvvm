import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/generated/l10n.dart';

class OnBoardingStepTwoPage extends StatelessWidget {
  const OnBoardingStepTwoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  S.of(context).description2,
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
      ],
    );
  }
}
