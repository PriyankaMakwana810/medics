import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medics/controller/base_controller.dart';

import '../../routes/app_pages.dart';

class SignUpController extends BaseController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var isAgreed = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user = Rxn<User>();

  @override
  void onInit() {
    user.bindStream(_auth.authStateChanges());
    super.onInit();
  }


  void setEmail(String value) {
    email.value = value;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }


  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Email';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void onLoginButtonTap() async {
    // await appPreferences.setOnboardDetails(true);

    Get.offNamed(Routes.login);
  }
  // Register with Email and Password
  Future<bool> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Account created successfully");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("weak-password",'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('email-already-in-use','The account already exists for that email.');
      }
      return false;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    }
  }

  void toggleAgreement(bool? value) {
    isAgreed.value = value ?? false;
    // update();
  }

  void signUp() {
    if (validateName(name.value) == null &&
        validateEmail(email.value) == null &&
        validatePassword(password.value) == null &&
        isAgreed.value) {
      // Perform sign-up logic here
      Get.snackbar('Success', 'You have signed up successfully');
    } else {
      Get.snackbar('Error', 'Please fill in all fields correctly');
    }
  }

/*  void showSuccessDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Registration Successful'),
        content: const Text('You have successfully registered.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }*/

  void onSignUpButtonTap() async {
    // await appPreferences.setOnboardDetails(true);
    Get.toNamed(Routes.sign_up);
  }

  void onGoogleLoginTap() async {
    // await appPreferences.setOnboardDetails(true);
    Get.toNamed(Routes.login);
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
