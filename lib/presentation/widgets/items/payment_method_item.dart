import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';


enum PaymentType{
  cashOnDelivery,
  creditCard,
  other,
}

class PaymentMethodItem extends StatelessWidget {
  final bool active;
  final PaymentType paymentType;
  final void Function()? onTap;
  const PaymentMethodItem({Key? key, this.active = false, required this.paymentType, this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: active ? AppColors.lightYellow : Colors.white,
        border: Border.all(color: AppColors.lightYellow,),
        borderRadius: BorderRadius.circular(18.0),
      ),
      padding: const EdgeInsets.fromLTRB(30, 16, 30, 16),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            _textFromType(paymentType),
            style: AppTextStyle.medium.copyWith(fontSize: 16.0,),
          ),
        ),
      ),
    );
  }

  String _textFromType(PaymentType paymentType){
    switch(paymentType){
      case PaymentType.cashOnDelivery:
        return 'Cash on Delivery';
      case PaymentType.creditCard:
        return 'Credit Card';
      case PaymentType.other:
        return 'Other';
    }
  }
}