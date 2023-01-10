import 'package:flutter/material.dart';
import 'package:flutter_mvvm/presentation/providers/checkout_provider.dart';
import 'package:flutter_mvvm/presentation/widgets/items/payment_method_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/styles.dart';
import '../../../widgets/button.dart';
import '../../../widgets/checkbox_tile.dart';
import '../../../widgets/input.dart';
import '../../../widgets/items/credit_card_item.dart';

class PaymentMethod extends StatefulWidget {
  final Function(bool) onConfirmOrder;
  const PaymentMethod({Key? key, required this.onConfirmOrder,}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool saveCreditCard = false;
  final methods = [
    PaymentType.cashOnDelivery,
    PaymentType.creditCard,
    PaymentType.other,
  ];


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 29, right: 29, top: 24,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _paymentMethods(),
            const SizedBox(height: 20,),
            const Divider(height: 1, color: Colors.grey,),
            const SizedBox(height: 10,),
            _cardList(),
            ..._cardHolderName(),
            ..._cardNumber(),
            Row(
              children: [
                Expanded(
                  child: _cardCreateDate(),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: _cvv(),
                ),
              ],
            ),
            const SizedBox(height: 13,),
            CheckboxTile(
              text: 'Save credit card details',
              onCheckChanged: (value) => saveCreditCard = value,
            ),
            const SizedBox(height: 30,),
            Consumer(
              builder: (_, ref, __) {
                ref.listen<bool?>(checkoutProvider, (_, value) {
                  if(value != null){
                    widget.onConfirmOrder(value);
                  }
                });

                return AppButton(
                  buttonColor: AppColors.lightYellow,
                  buttonText: 'Confirm Order'.toUpperCase(),
                  style: AppTextStyle.bold.copyWith(
                    fontSize: 16,
                  ),
                  onPressed: () => ref.read(checkoutProvider.notifier).checkoutOrder(),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 30,),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethods(){
    return SizedBox(
      height: 56,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: methods.length,
        itemBuilder: (__, index) => Padding(
          padding: const EdgeInsets.only(right: 10.0,),
          child: PaymentMethodItem(paymentType: methods[index]),
        ),
      ),
    );
  }

  Widget _cardList() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 14.0,),
            child: CreditCardItem(
              checked: index.isEven,
              //onTap: ,
            ),
          );
        },
      ),
    );
  }

  List<Widget> _cardHolderName(){
    return [
      const SizedBox(height: 20,),
      Text(
        'Card Holder Name',
        style: AppTextStyle.medium,
      ),
      const SizedBox(height: 10,),
      AppInput.text(
        hintText: 'Enter here',
        height: 54,
        borderColor: AppColors.grey202,
      ),
    ];
  }

  List<Widget> _cardNumber(){
    return [
      const SizedBox(height: 20,),
      Text(
        'Card Number',
        style: AppTextStyle.medium,
      ),
      const SizedBox(height: 10,),
      AppInput.text(
        hintText: 'Enter here',
        height: 54,
        borderColor: AppColors.grey202,
      ),
    ];
  }

  Widget _cardCreateDate(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        Text(
          'Month/Year',
          style: AppTextStyle.medium,
        ),
        const SizedBox(height: 10,),
        AppInput.text(
          height: 54,
          hintText: 'Enter here',
          borderColor: AppColors.grey202,
        ),
      ],
    );
  }

  Widget _cvv(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        Text(
          'CVV',
          style: AppTextStyle.medium,
        ),
        const SizedBox(height: 10,),
        AppInput.text(
          height: 54,
          hintText: 'Enter here',
          borderColor: AppColors.grey202,
        ),
      ],
    );
  }
}

