import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/views/reset_password/reset_password_controller.dart';

import '../../config/app_dimention.dart';
import '../../config/app_strings.dart';
import '../../custom_widgets/button.dart';
import '../../custom_widgets/custom_dialogs.dart';
import '../../styles/color_constants.dart';
import '../../styles/text_style.dart';

class ChangePasswordView extends StatelessWidget {
  final ResetPasswordController controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30.0, left: 20, right: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Create New Password', style: AppTextStyles.heading1),
              const SizedBox(height: 12.0),
              const Wrap(children: [
                Text('Create your new password to login',
                    style: AppTextStyles.heading2),
              ]),
              const SizedBox(height: 24),
              Obx(() => TextField(
                    obscureText: !controller.isPasswordVisible.value,
                style: TextStyle(
                    fontSize: Dimensions.fontSizeDefault,
                    color: textColor,
                    fontWeight: FontWeight.normal),
                    onChanged: (value) => controller.password.value = value,
                keyboardType:  TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                          fontSize: Dimensions.fontSizeDefault, color: textColorDisable),
                      filled: true,
                      fillColor: textFieldFilled,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: textColorDisable),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: textColorDisable),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: textColorDisable),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  )),
              const SizedBox(height: 16),
              Obx(() => TextField(
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    cursorColor: colorPrimary,
                    style: TextStyle(
                        fontSize: Dimensions.fontSizeDefault,
                        color: textColor,
                        fontWeight: FontWeight.normal),
                    onChanged: (value) =>
                        controller.confirmPassword.value = value,
                    keyboardType:  TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(
                          fontSize: Dimensions.fontSizeDefault, color: textColorDisable),
                      filled: true,
                      fillColor: textFieldFilled,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(controller.isConfirmPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: textColorDisable),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: textColorDisable),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: textColorDisable),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  )),
              const SizedBox(height: 24),
              CustomFilledButton(
                label: AppStrings.create_password,
                onPressed: () {
                  if (controller.createPassword()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SuccessDialog(
                          title: 'Success',
                          message:
                              'You have successfully reset your password.',
                          buttonText: 'Login',
                          onPressed: () {
                            controller.onLoginButtonTap();
                          },
                        );
                      },
                    );
                  }

                  // Utility.snackBar("Password Changed Successfully!", context);
                  // controller.verifyCode();
                },
              ),
              /*ElevatedButton(
                onPressed: controller.createPassword,
                child: Text('Create Password'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
