import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/views/reset_password/reset_password_controller.dart';

import '../../config/app_dimention.dart';
import '../../config/app_strings.dart';
import '../../custom_widgets/button.dart';
import '../../styles/color_constants.dart';
import '../../styles/text_style.dart';

class VerificationCodeView extends StatelessWidget {
  final ResetPasswordController controller = Get.put(ResetPasswordController());
  final String userData = Get.arguments as String;

  VerificationCodeView({super.key});

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
              const Text("Enter Verification Code?",
                  style: AppTextStyles.heading1),
              const SizedBox(height: 12.0),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Enter code that we have sent to your number',
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeLarge,
                            color: textColorDisable,
                            fontWeight: FontWeight.normal)),
                    TextSpan(
                      text: ' $userData',
                      style: const TextStyle(
                          fontSize: Dimensions.fontSizeLarge,
                          color: textColor,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 65,
                    child: Obx(() => TextField(
                          controller: TextEditingController(
                              text: controller.code[index].value),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          cursorColor: colorPrimary,
                          style: AppTextStyles.heading1,
                          decoration: InputDecoration(
                            counterText: '',
                            fillColor: textfieldBackground,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: textfieldBackground, width: 2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: colorPrimary, width: 2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onChanged: (value) {
                            controller.setCode(index, value);
                            if (value.isNotEmpty && index < 3) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                        )),
                  );
                }),
              ),
              const SizedBox(height: 24),
              CustomFilledButton(
                label: AppStrings.verify,
                onPressed: () {
                  controller.verifyCode();
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: controller.resendCode,
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "Didn't receive the code? ",
                              style: TextStyle(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: textColorDisable,
                                  fontWeight: FontWeight.normal)),
                          TextSpan(
                            text: 'Resend',
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeDefault,
                                color: colorPrimary,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
