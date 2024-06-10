import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:medics/styles/color_constants.dart';

import '../../config/app_dimention.dart';
import '../../config/app_preferences.dart';
import '../../controller/base_controller.dart';
import '../../routes/app_pages.dart';
import '../../utils/utility.dart';

class SplashController extends BaseController {
  AppPreferences appPreferences = AppPreferences();

  @override
  void onInit() {
/*    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));*/
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.bottom]);

    splashTimer();
    super.onInit();
  }

  void splashTimer() async {
    var duration = Duration(
      seconds: Dimensions.screenLoadTime,
    );
    Future.delayed(duration, () async {
      printf("Navigate to next screen");
      try {
        bool? onboardDone = await AppPreferences().getOnboardDetails();
        bool? login = await AppPreferences().getLogin();

        if (onboardDone != null && onboardDone == true) {
          if (login != null && login == true) {
            Get.offNamedUntil(Routes.home, (route) => false);
          } else {
            Get.offNamedUntil(Routes.intro, (route) => false);
          }
        } else {
          Get.offNamedUntil(Routes.onboarding, (route) => false);
        }
      } catch (e, e1) {
        printf("Login error:$e \n $e1");
        // Get.offNamedUntil(Routes.login, (route) => false);
      }
    });
  }
}
