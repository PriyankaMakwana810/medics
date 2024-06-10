import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:medics/config/app_strings.dart';
import 'package:medics/styles/color_constants.dart';
import 'package:medics/views/onboarding/onboarding_controller.dart';

import '../../config/app_dimention.dart';

class OnBoardingView extends GetView<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const titleStyle = TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    List<PageViewModel> pageViewModelList = [
      PageViewModel(
        title: "",
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/doctor1.png', width: 250, height: 450),
            SizedBox(height: 30),
            Text(
              AppStrings.onboardingText1,
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: "",
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/doctor2.png', width: 250, height: 450),
            SizedBox(height: 30),
            Text(
              AppStrings.onboardingText2,
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: "",
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/doctor3.png', width: 250, height: 450),
            SizedBox(height: 30),
            Text(
              AppStrings.onboardingText3,
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        decoration: pageDecoration,
      ),
    ];
    Dimensions.screenWidth = MediaQuery.of(context).size.width;
    Dimensions.screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder(builder: (OnboardingController controller) {
      return Scaffold(
        backgroundColor: whiteColor,
        body: Stack(children: [
          IntroductionScreen(
            pages: pageViewModelList,
            showSkipButton: false,
            showNextButton: true,
            next: const Icon(Icons.arrow_circle_right_rounded,
                size: 50, color: colorPrimary),
            done: const Icon(Icons.arrow_circle_right_rounded,
                size: 50, color: colorPrimary),
            nextStyle: TextButton.styleFrom(alignment: Alignment.bottomRight),
            doneStyle: TextButton.styleFrom(alignment: Alignment.bottomRight),
            onDone: () {
              controller.setOnboarding();
            },

            // controlsMargin: const EdgeInsets.all(16),
            // controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            dotsDecorator: const DotsDecorator(
              size: Size(22.0, 4.0),
              color: textColorDisable,
              activeColor: colorPrimary,
              activeSize: Size(22.0, 4.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
              ),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            right: 16.0,
            child: TextButton(
              onPressed: () {
                controller.setOnboarding();
              },
              child: const Text(
                "Skip",
                style: TextStyle(color: textColorDisable),
              ),
            ),
          ),
        ]),
      );
    });
  }
}
