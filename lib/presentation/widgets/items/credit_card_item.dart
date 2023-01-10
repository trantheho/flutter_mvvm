import 'package:flutter/material.dart';

import '../../../core/utils/app_utils.dart';
import '../../../core/utils/styles.dart';

class CreditCardItem extends StatelessWidget {
  final bool checked;
  final Function()? onTap;
  const CreditCardItem({Key? key, this.checked = false, this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 216,
      height: 141,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            checked ? AppImages.activeCard : AppImages.card,
          ),
          fit: BoxFit.contain,
        ),
      ),
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onTap,
        child: checked ? Align(
          alignment: const Alignment(0.7, 1.1),
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2.0,
                  offset: Offset(1,1),
                )
              ]
            ),
            child: const Center(
              child: Icon(Icons.check, color: AppColors.lightYellow,),
            ),
          ),
        ) : const SizedBox.shrink(),
      ),
    );
  }
}
