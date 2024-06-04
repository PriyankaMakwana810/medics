import 'package:get/get.dart';

class ToggleController extends GetxController {
  bool initialPosition = true;

  void toggle() {
    initialPosition = !initialPosition;
    update();
  }
}
