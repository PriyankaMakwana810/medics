import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/config/app_assets.dart';
import 'package:medics/styles/color_constants.dart';
import 'package:medics/utils/utility.dart';
import 'package:medics/views/login/login_controller.dart';

import '../../config/app_dimention.dart';
import '../../config/app_strings.dart';
import '../../custom_widgets/button.dart';
import '../../custom_widgets/custom_dialogs.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../styles/text_style.dart';

class LoginView extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (LoginController controller) {
      return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Text(
            "Login",
            style: AppTextStyles.appBarStyle,
          ),
          centerTitle: true,
          backgroundColor: whiteColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 80.0, left: 20, right: 20, bottom: 20),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: TextEditingController(),
                      hintText: 'Enter Your Email',
                      icon: SVGAssets.v_ic_email,
                      keyboardType: TextInputType.emailAddress,
                      validator: controller.validateEmail,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      controller: TextEditingController(),
                      hintText: 'Enter Your Password',
                      icon: SVGAssets.v_ic_password,
                      isPassword: true,
                      validator: controller.validatePassword,
                    ),
                    const SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Handle forgot password
                          controller.onForgotPasswordTap();
                        },
                        child: const Text("Forgot Password?",
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeLarge,
                                color: colorPrimary,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    CustomFilledButton(
                      label: AppStrings.login,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle login
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessDialog(
                                title: 'Yeay! Welcome Back',
                                message:
                                    'Once again you login successfully\n into medidoc app',
                                buttonText: 'Go to Home',
                                onPressed: () {
                                  controller.onHomeClick();
                                },
                              );
                            },
                          );
                          // Utility.snackBar("Logged in Successfully!", context);
                        }
                      },
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            controller.onSignUpButtonTap();
                            // Get.toNamed(Routes.sign_up);
                            // Adjust according to your routes
                          },
                          child: const Text("Sign Up",
                              style: TextStyle(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: colorPrimary,
                                  fontWeight: FontWeight.normal)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text("OR", style: AppTextStyles.bodyText),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    CustomOutlinedIconButton(
                      label: "Sign in with Google",
                      icon: SVGAssets.v_ic_google,
                      onPressed: () {
                        Utility.snackBar("Signed in with Google", context);
                      },
                    ),
                    const SizedBox(height: 8.0),
                    CustomOutlinedIconButton(
                      label: "Sign in with Apple",
                      icon: SVGAssets.v_ic_apple,
                      onPressed: () {
                        Utility.snackBar("Signed in with Apple", context);
                        // Handle Google Sign In
                      },
                    ),
                    const SizedBox(height: 8.0),
                    CustomOutlinedIconButton(
                      label: "Sign in with Facebook",
                      icon: SVGAssets.v_ic_facebook,
                      onPressed: () {
                        Utility.snackBar("Signed in with Facebook", context);
                        // Handle Google Sign In
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
