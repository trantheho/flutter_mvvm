import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/presentation/widgets/button.dart';
import 'package:flutter_mvvm/presentation/widgets/input.dart';

import '../../../widgets/checkbox_tile.dart';

class ShippingAddress extends StatefulWidget {
  final Function() onNext;
  const ShippingAddress({Key? key, required this.onNext,}) : super(key: key);

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  bool saveShippingAddress = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 29, right: 29, top: 24,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._fullName(),
          ..._emailAddress(),
          ..._phoneNumber(),
          ..._address(),
          Row(
            children: [
              Expanded(
                child: _zipCode(),
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: _city(),
              ),
            ],
          ),
          const SizedBox(height: 13,),
          CheckboxTile(
            text: 'Save shipping address',
            onCheckChanged: (value) => saveShippingAddress = value,
          ),
          const SizedBox(height: 30,),
          AppButton(
            buttonColor: AppColors.lightYellow,
            buttonText: 'Next'.toUpperCase(),
            style: AppTextStyle.bold.copyWith(
              fontSize: 16,
            ),
            onPressed: onNext,
          )
        ],
      ),
    );
  }

  List<Widget> _fullName(){
    return [
      Text(
        'Full Name',
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

  List<Widget> _emailAddress(){
    return [
      const SizedBox(height: 20,),
      Text(
        'Email Address',
        style: AppTextStyle.medium,
      ),
      const SizedBox(height: 10,),
      AppInput.email(
        height: 54,
        borderColor: AppColors.grey202,
      ),
    ];
  }

  List<Widget> _phoneNumber(){
    return [
      const SizedBox(height: 20,),
      Text(
        'Phone',
        style: AppTextStyle.medium,
      ),
      const SizedBox(height: 10,),
      AppInput.text(
        height: 54,
        hintText: 'Enter here',
        borderColor: AppColors.grey202,
      ),
    ];
  }

  List<Widget> _address(){
    return [
      const SizedBox(height: 20,),
      Text(
        'Address',
        style: AppTextStyle.medium,
      ),
      const SizedBox(height: 10,),
      AppInput.text(
        height: 54,
        hintText: 'Enter here',
        borderColor: AppColors.grey202,
      ),
    ];
  }

  Widget _zipCode(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        Text(
          'Zip Code',
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

  Widget _city(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        Text(
          'City',
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

  void onNext(){
    widget.onNext();
  }
}
