import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/app_controller.dart';
import 'package:flutter_mvvm/core/router/app_router.dart';
import 'package:flutter_mvvm/core/router/route_config.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/generated/l10n.dart';
import 'package:flutter_mvvm/presentation/pages/onboarding/step/onboarding_step_one_page.dart';
import 'package:flutter_mvvm/presentation/pages/onboarding/step/onboarding_step_two_page.dart';
import 'package:flutter_mvvm/presentation/widgets/button.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final ValueNotifier<int> stepNotifier = ValueNotifier(0);
  late final PageController pageController;

  final pages = const [
    OnBoardingStepOnePage(),
    OnBoardingStepTwoPage(),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    stepNotifier.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: ValueListenableBuilder<int>(
          valueListenable: stepNotifier,
          builder: (_, step, __) {
            return step > 0
                ? IconButton(
                    key: const Key('backButton'),
                    onPressed: () => backPage(step),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Image.asset(
                      AppImages.leftArrow,
                      color: AppColors.orange,
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: pages,
                onPageChanged: (index) => stepNotifier.value = index,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28, right: 28),
              child: SmoothPageIndicator(
                controller: pageController,
                count: 2,
                effect: const JumpingDotEffect(
                  dotWidth: 23,
                  dotHeight: 6,
                  dotColor: AppColors.lightGrey,
                  activeDotColor: AppColors.green,
                ),
              ),
            ),
            const SizedBox(
              height: 41,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28, right: 28),
              child: ValueListenableBuilder<int>(
                valueListenable: stepNotifier,
                builder: (_, step, __) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    child: AppButton(
                      key: const Key('nextButton'),
                      buttonColor: AppColors.lightYellow,
                      buttonText: S.of(context).next.toUpperCase(),
                      style: AppTextStyle.bold.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      onPressed: () => nextPage(step, appState),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextPage(int index, AppState appState) {
    if(index == pages.length -1){
      appState.updateFirstLogin();
      context.go(AppPage.auth.path);
    }

    if (index + 1 < pages.length) {
      pageController.animateToPage(++index,
          duration: const Duration(milliseconds: 350), curve: Curves.easeInOutCubic);
    }
  }

  void backPage(int index) {
    if (index - 1 >= 0) {
      pageController.animateToPage(--index,
          duration: const Duration(milliseconds: 350), curve: Curves.easeInOutCubic);
    }
  }
}
