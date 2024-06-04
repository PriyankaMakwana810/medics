
import 'package:get/get.dart';
import 'package:medics/views/login/login_controller.dart';
import 'package:medics/views/sign_up/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
    );
  }
}