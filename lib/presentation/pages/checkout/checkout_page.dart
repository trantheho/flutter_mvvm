import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/app_controller.dart';
import 'package:flutter_mvvm/core/utils/app_assets.dart';
import 'package:flutter_mvvm/core/utils/app_helper.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/presentation/widgets/app_bar.dart';
import 'package:go_router/go_router.dart';

import 'checkout_progress/payment_method.dart';
import 'checkout_progress/shipping_address.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> with SingleTickerProviderStateMixin {
  late final PageController pageController;
  final ValueNotifier<int> stepNotifier = ValueNotifier(1);
  int currentStep = 1;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true,);
  }

  @override
  void dispose() {
    stepNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => appController.hideKeyboard(context),
      child: Scaffold(
        appBar: MyAppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Checkout',
            style: AppTextStyle.medium.copyWith(
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: onBack,
            icon: Image.asset(
              AppImages.leftArrow,
              color: Colors.black,
              width: 24,
              height: 24,
            ),
          ),
        ),
        body: Column(
          children: [
            _checkoutProgressIndicator(),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ShippingAddress(
                    onNext: () {
                      changePage(1);
                    },
                  ),
                  PaymentMethod(
                    onConfirmOrder: (checkoutResult) {
                      if(checkoutResult){
                        appController.toast.showToast(context: context, message: "Checkout is success");
                      }
                      else{
                        appController.toast.showToast(context: context, message: "Checkout was failed");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkoutProgressIndicator() {
    return Container(
      color: AppColors.lightGrey,
      padding: const EdgeInsets.all(16.0),
      child: ValueListenableBuilder<int>(
          valueListenable: stepNotifier,
          builder: (_, step, __) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 19,
                          top: 19,
                        ),
                        child: SizedBox(
                          height: 32,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    )),
                                    Expanded(
                                        child: Container(
                                      height: 2,
                                      color: step == 1 ? AppColors.grey203 : AppColors.orange,
                                    )),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.orange, width: 4),
                                    color: step > 1 ? AppColors.orange : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Shipping Address',
                        style: AppTextStyle.medium.copyWith(
                          color: step > 1 ? AppColors.orange : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 19,
                          top: 19,
                        ),
                        child: SizedBox(
                          height: 32,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      height: 2,
                                      color: AppColors.grey203,
                                    )),
                                    Expanded(
                                        child: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    )),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: step > 1 ? AppColors.orange : AppColors.grey203, width: 4),
                                    color: step > 1 ? Colors.white : AppColors.grey203,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Payment Method',
                        style: AppTextStyle.medium.copyWith(
                          color: step > 1 ? Colors.black : AppColors.grey203,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  void changePage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 350),
      curve: Curves.fastOutSlowIn,
    );
    currentStep = pageIndex + 1;
    stepNotifier.value = currentStep;
  }

  void onBack(){
    if(currentStep == 1) context.pop();
    if(currentStep > 1) changePage(0);
  }
}
