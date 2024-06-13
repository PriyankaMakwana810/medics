import 'package:get/get.dart';
import 'package:medics/views/zegoChat/chat_list_controller.dart';

class ChatListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatListController>(
      () => ChatListController(),
    );
  }
}
