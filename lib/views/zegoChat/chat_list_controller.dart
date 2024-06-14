import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medics/controller/base_controller.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../config/app_assets.dart';

class ChatListController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    // ZIMKit().connectUser(id: '91',name: 'Dr. Alysa Hana ',avatarUrl: AppAssets.drDiandra);
    // ZIMKit().connectUser(id: '3456789',name: 'Dr. Maria Elena',avatarUrl: AppAssets.drMaria);
    // ZIMKit().connectUser(id: '456789',name: 'Dr. Marcus Horizon',avatarUrl: AppAssets.drMarcus);
    // ZIMKit().connectUser(id: '92',name: 'Dr. Stefi Jessi',avatarUrl: AppAssets.drStefi);
    // ZIMKit().connectUser(id: '789',name: 'Dr. Gerty Cori',avatarUrl: AppAssets.drGerty);
    ZIMKit().connectUser(id: '56789',name: 'Priyanka Makwana',avatarUrl: AppAssets.profileImage);

  }
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
