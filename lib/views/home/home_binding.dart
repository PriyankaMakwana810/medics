
import 'package:get/get.dart';
import 'package:medics/views/home/home_controller.dart';
import 'package:medics/views/login/login_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
  }
}