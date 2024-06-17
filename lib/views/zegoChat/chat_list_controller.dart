import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medics/config/app_strings.dart';
import 'package:medics/controller/base_controller.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
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
    // await ZIMKit().connectUser(id: '56789', name: 'Priyanka Makwana').then((errorCode) {
    //   if (errorCode == 0) {
    //     /// 2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    //     /// when app's user is logged in or re-logged in
    //     /// We recommend calling this method as soon as the user logs in to your app.
    //     ZegoUIKitPrebuiltCallInvitationService().init(
    //       appID: AppStrings.appID /*input your AppID*/,
    //       appSign: AppStrings.appSign /*input your AppSign*/,
    //       userID: '56789',
    //       userName: 'Priyanka Makwana',
    //       plugins: [ZegoUIKitSignalingPlugin()],
    //     );
    //
    //   } else {
    //     Get.snackbar('Login Failed', 'errorCode: $errorCode');
    //   }
    // });
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
