import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/controller/base_controller.dart';

import '../../routes/app_pages.dart';

class ResetPasswordController extends BaseController {
  var hint = 'Enter Your Email'.obs;
  var icon = Icons.email.obs;
  var keyboardType = TextInputType.emailAddress.obs;
  var code = List.generate(4, (_) => ''.obs);
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  bool createPassword() {
    if (password.value.isEmpty || confirmPassword.value.isEmpty) {
      Get.snackbar('Error', 'Please fill in both fields');
      return false;
    }

    if (password.value != confirmPassword.value) {
      Get.snackbar('Error', 'Passwords do not match');
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
      icon.value = Icons.email;
      keyboardType.value = TextInputType.emailAddress;
    } else {
      hint.value = 'Enter your Phone Number';
      icon.value = Icons.phone;
      keyboardType.value = TextInputType.phone;
    }
    update();
  }

  void onLoginButtonTap() async {
    // await appPreferences.setOnboardDetails(true);
    Get.offAllNamed(Routes.login);
  }

  void onSendCodeTap() async {
    // await appPreferences.setOnboardDetails(true);
    Get.toNamed(Routes.verification_code);
  }
}
