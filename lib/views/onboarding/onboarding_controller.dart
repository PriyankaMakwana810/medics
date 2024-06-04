import 'package:get/get.dart';

import '../../config/app_preferences.dart';
import '../../controller/base_controller.dart';
import '../../routes/app_pages.dart';

class OnboardingController extends BaseController {
  AppPreferences appPreferences = AppPreferences();

  @override
  void onInit() {
    // setOnboarding();
    super.onInit();
  }

  void setOnboarding() async {
    appPreferences.setOnboardDetails(true);
    Get.offNamedUntil(Routes.intro, (route) => false);
  }

  void onLoginButtonTap() async {
    // await appPreferences.setOnboardDetails(true);
    Get.toNamed(Routes.login);
  }

  void onSignUpButtonTap() async {
    // await appPreferences.setOnboardDetails(true);
    Get.toNamed(Routes.sign_up);
  }

  @override
  void dispose() {
    // Dispose everything
    super.dispose();
  }
}
