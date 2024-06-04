import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/styles/color_constants.dart';
import 'package:medics/utils/utility.dart';
import 'package:medics/views/reset_password/reset_password_controller.dart';

import '../../config/app_strings.dart';
import '../../custom_widgets/button.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../custom_widgets/custom_toggle.dart';
import '../../styles/text_style.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ResetPasswordController(),
        builder: (ResetPasswordController controller) {
          return Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              backgroundColor: whiteColor,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, left: 20, right: 20, bottom: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Forgot Your Password?",
                          style: AppTextStyles.heading1),
                      const SizedBox(height: 12.0),
                      const Wrap(children: [
                        Text(
                            'Enter your email or your phone number, we will send you confirmation code',
                            style: AppTextStyles.heading2),
                      ]),
                      const SizedBox(height: 12.0),
                      AnimatedToggle(
                        values: ['Email', 'Phone'],
                        onToggleCallback: (value) {
                          // FocusManager.instance.primaryFocus?.unfocus();
                          controller.getHint(value);
                        },
                        buttonColor: whiteColor,
                        textColor: colorPrimary,
                        backgroundColor: textFieldFilled,
                      ),
                      const SizedBox(height: 12.0),
                      CustomTextField(
                        controller: TextEditingController(),
                        hintText: controller.hint.value,
                        icon: controller.icon.value,
                        keyboardType: controller.keyboardType.value,
                        // validator: controller.validateEmail,
                      ),
                      const SizedBox(height: 30.0),
                      CustomFilledButton(
                        label: AppStrings.reset_password,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.onSendCodeTap();
                            // Handle login
                            Utility.snackBar(
                                "Code has been sent Successfully!", context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
