import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/config/app_assets.dart';
import 'package:medics/controller/base_controller.dart';

import '../../routes/app_pages.dart';

class ResetPasswordController extends BaseController {
  var hint = 'Enter Your Email'.obs;
  var icon = SVGAssets.v_ic_email_primary.obs;
  var keyboardType = TextInputType.text.obs;
  var code = List.generate(4, (_) => ''.obs);
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isEmail = true.obs;
  TextEditingController emailOrPhoneController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  bool createPassword() {
    if (password.value.isEmpty || confirmPassword.value.isEmpty) {
      Get.snackbar('Error', 'Please fill out both passwords.',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (password.value != confirmPassword.value) {
      Get.snackbar('Error', 'Passwords do not match',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    print('Password created: ${password.value}');
    return true;
  }

  void setCode(int index, String value) {
    if (index >= 0 && index < 4) {
      code[index].value = value;
    }
  }

  String get fullCode => code.map((e) => e.value).join();

  bool get isCodeComplete => code.every((element) => element.isNotEmpty);

  void clearCode() {
    for (var i = 0; i < code.length; i++) {
      code[i].value = '';
    }
  }

  void verifyCode() {
    if (isCodeComplete) {
      // Handle code verification logic here
      print('Entered code: $fullCode');
      Get.toNamed(Routes.change_password);
    } else {
      Get.snackbar('Error', 'Please enter the complete code');
    }
  }

  void resendCode() {
    // Handle resend code logic here
    print('Resend code');
  }

  void getHint(value) {
    if (kDebugMode) {
      print(value);
    }
    if (value == 0) {
      hint.value = 'Enter your Email';
      isEmail.value = true;
      icon.value = SVGAssets.v_ic_email_primary;
      keyboardType.value = TextInputType.emailAddress;
    } else {
      isEmail.value = false;
      hint.value = 'Enter your Phone Number';
      icon.value = SVGAssets.v_ic_call;
      keyboardType.value = TextInputType.phone;
    }
  }

  void onLoginButtonTap() async {
    // await appPreferences.setOnboardDetails(true);
    Get.offAllNamed(Routes.login);
  }

  void onSendCodeTap() async {
    final input = emailOrPhoneController.text.trim();
    if (isEmail.value) {
      if (input.isEmpty) {
        Get.snackbar('Error', 'Please enter your email',
            snackPosition: SnackPosition.BOTTOM);
        return;
      } else if (!GetUtils.isEmail(input)) {
        Get.snackbar('Error', 'Please enter a valid email',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
    } else {
      if (input.isEmpty) {
        Get.snackbar('Error', 'Please enter your phone number',
            snackPosition: SnackPosition.BOTTOM);
        return;
      } else if (!GetUtils.isPhoneNumber(input)) {
        Get.snackbar('Error', 'Please enter a valid phone number',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
    }
    // await appPreferences.setOnboardDetails(true);
    Get.toNamed(Routes.verification_code, arguments: input);
  }
}
