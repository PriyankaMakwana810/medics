import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medics/config/app_strings.dart';
import 'package:medics/styles/color_constants.dart';

import '../../config/app_assets.dart';
import '../../custom_widgets/button.dart';
import 'onboarding_controller.dart';

class IntroView extends GetView<OnboardingController> {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (OnboardingController controller) {
      return Scaffold(
        backgroundColor: whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(SVGAssets.appLogo),
              const SizedBox(height: 40),
              const Text("Let's get started!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 10),
              const Text(
                "Login to enjoy the features we've provided, and stay healthy!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: textColorDisable,
                ),
              ),
              const SizedBox(height: 30),
              CustomFilledButton(
                label: AppStrings.login,
                onPressed: controller.onLoginButtonTap,
              ),
              const SizedBox(height: 20),
              CustomOutlinedButton(
                label: AppStrings.signUp,
                onPressed: controller.onSignUpButtonTap,
              )
            ],
          ),
        ),
      );
    });
  }
}
