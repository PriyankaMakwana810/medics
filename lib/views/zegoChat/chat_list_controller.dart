import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medics/controller/base_controller.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatListController extends BaseController {
  void openChat(BuildContext context, ZIMKitConversation conversation) {
    Get.to(() => ZIMKitMessageListPage(
          conversationID: conversation.id,
          conversationType: conversation.type,
        ));
  }

  void showNewChatDialog(BuildContext context) {
    ZIMKit().showDefaultNewPeerChatDialog(context);
  }

}
