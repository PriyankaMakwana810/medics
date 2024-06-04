import 'package:get/get.dart';
import 'package:medics/controller/base_controller.dart';

import '../../config/app_preferences.dart';
import '../../routes/app_pages.dart';

class LoginController extends BaseController {
  AppPreferences appPreferences = AppPreferences();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void onLoginButtonTap() async {
    // await appPreferences.setOnboardDetails(true);
    // Get.toNamed(Routes.login);
  }

  void onSignUpButtonTap() async {
    Get.toNamed(Routes.sign_up);
  }

  void onForgotPasswordTap() async {
    Get.toNamed(Routes.forgot_password);
  }

  void onGoogleLoginTap() async {
    // await appPreferences.setOnboardDetails(true);
    Get.toNamed(Routes.login);
  }

  void onHomeClick() async {
    appPreferences.setLogin(true);
    Get.offAllNamed(Routes.home);
  }

  void onFacebookLoginTap() async {
    // await appPreferences.setOnboardDetails(true);
    Get.toNamed(Routes.sign_up);
  }

  void onAppleLoginTap() async {
    // await appPreferences.setOnboardDetails(true);
    Get.toNamed(Routes.sign_up);
  }
}
