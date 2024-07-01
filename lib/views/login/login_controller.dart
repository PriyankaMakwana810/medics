import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medics/controller/base_controller.dart';

import '../../config/app_preferences.dart';
import '../../routes/app_pages.dart';

class LoginController extends BaseController {
  AppPreferences appPreferences = AppPreferences();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user = Rxn<User>();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

// Sign in with Email and Password
  Future<bool> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user.value = userCredential.user;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('user-not-found', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
            'user-not-found', 'Wrong password provided for that user.');
      }
      return false;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
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

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  void onSignUpButtonTap() async {
    Get.toNamed(Routes.sign_up);
  }

  void onForgotPasswordTap() async {
    Get.toNamed(Routes.forgot_password);
  }

  void onGoogleLoginTap() async {
    // await appPreferences.setOnboardDetails(true);
    // var googleUser = signInWithGoogle();
    signInWithGoogle().then(
      (value) {
        user.value = value.user;
        // Get.toNamed(Routes.home);
        onHomeClick();
      },
    );
    // Get.toNamed(Routes.login);
  }

  void onHomeClick() async {
    appPreferences.setLogin(true);
    Get.offAllNamed(Routes.home);
  }

  void onFacebookLoginTap() async {
    // await appPreferences.setOnboardDetails(true);
    signInWithFacebook().then(
          (value) {
        user.value = value.user;
        onHomeClick();
        // Get.toNamed(Routes.home);
      },
    );
    // Get.toNamed(Routes.sign_up);
  }

  void onAppleLoginTap() async {
    // await appPreferences.setOnboardDetails(true);
    Get.toNamed(Routes.sign_up);
  }
}
