
import 'package:get/get.dart';
import 'package:medics/views/login/login_controller.dart';
import 'package:medics/views/reset_password/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(
          () => ResetPasswordController(),
    );
  }
}