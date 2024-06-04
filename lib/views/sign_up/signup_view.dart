import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/views/sign_up/signup_controller.dart';

import '../../config/app_dimention.dart';
import '../../config/app_strings.dart';
import '../../custom_widgets/button.dart';
import '../../custom_widgets/custom_dialogs.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../styles/color_constants.dart';
import '../../styles/text_style.dart';

class SignUpView extends GetView<SignUpController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SignUpController(),
        builder: (SignUpController controller) {
          return Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              backgroundColor: whiteColor,
              title: const Text(
                "Sign Up",
                style: AppTextStyles.appBarStyle,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20.0),
                      CustomTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter Your Name',
                        icon: Icons.person,
                        keyboardType: TextInputType.text,
                        validator: controller.validateName,
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter Your Email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: controller.validateEmail,
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextField(
                        controller: TextEditingController(),
                        hintText: 'Enter Your Password',
                        icon: Icons.lock,
                        isPassword: true,
                        validator: controller.validatePassword,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Checkbox(
                              checkColor: whiteColor,
                              activeColor: colorPrimary,
                              value: controller.isAgreed.value,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                  side: BorderSide(
                                      color: Color(0xFFD3D6DA), width: 1.5)),
                              onChanged: controller.toggleAgreement),
                          Expanded(
                            child: GestureDetector(
                              child: Text.rich(TextSpan(children: [
                                TextSpan(text: 'I agree to the medidoc'),
                                TextSpan(
                                  text: ' Terms of Service',
                                  style: TextStyle(color: colorPrimary),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.snackbar('Terms of Service',
                                          'You tapped on Terms of Service');
                                    },
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(color: colorPrimary),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.snackbar('Privacy Policy',
                                          'You tapped on Privacy Policy');
                                    },
                                ),
                              ])),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      CustomFilledButton(
                        label: AppStrings.signUp,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SuccessDialog(
                                  title: 'Success',
                                  message:
                                      'Your account has been successfully registered',
                                  buttonText: 'Login',
                                  onPressed: () {
                                    controller.onLoginButtonTap();
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 14.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              controller.onLoginButtonTap();
                              // Get.toNamed(Routes.sign_up);
                              // Adjust according to your routes
                            },
                            child: const Text("Login",
                                style: TextStyle(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
