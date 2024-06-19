import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medics/config/app_strings.dart';
import 'package:medics/styles/color_constants.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'app/app.dart';
import 'config/app_assets.dart';
import 'config/notification.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.white,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  // ZIMKit().connectUser(id: '56789', name: 'Priyanka Makwana', avatarUrl: AppAssets.profileImage);
  ZIMKit().init(
    appID: AppStrings.appID, // your appid
    appSign: AppStrings.appSign,
    notificationConfig: ZegoZIMKitNotificationConfig(
      resourceID: AppStrings.resourceId,
      androidNotificationConfig: ZegoZIMKitAndroidNotificationConfig(
        channelID: 'ZIM Message',
        channelName: 'Message',
        sound: 'message',
        icon: 'message',
      ),
    ), // your appSign
  );
  ZegoUIKit().initLog().then((value) {
    /// style of offline call
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
    runApp(const MyApp());

    // runApp(const ZIMKitDemo());
  });
  NotificationManager().init();
}

void onUserLogin(String id, String name) {
  final sendCallingInvitationButton = StreamBuilder(
    stream: ZegoUIKit().getUserListStream(),
    builder: (context, snapshot) {
      return ValueListenableBuilder(
          valueListenable:
              /// '#' is removed when send call invitation
              ZIMKit().queryGroupMemberList('#${ZegoUIKit().getRoom().id}'),
          builder: (context, List<ZIMGroupMemberInfo> members, _) {
            final memberIDsInCall =
                ZegoUIKit().getRemoteUsers().map((user) => user.id).toList();
            final membersNotInCall = members.where((member) {
              if (member.userID == ZIMKit().currentUser()!.baseInfo.userID) {
                return false;
              }

              return !memberIDsInCall.contains(member.userID);
            }).toList();
            return ZegoSendCallingInvitationButton(
              avatarBuilder: (context, size, user, extraInfo) {
                return CircleAvatar(
                    radius: 25,
                    backgroundColor: colorPrimary,
                    child: Text(
                      user!.name.isNotEmpty ? user.name[0] : user.id[0],
                      style: TextStyle(color: colorSecondary, fontSize: 20),
                    ));
              },
              selectedUsers: ZegoUIKit()
                  .getRemoteUsers()
                  .map((e) => ZegoCallUser(
                        e.id,
                        e.name,
                      ))
                  .toList(),
              waitingSelectUsers: membersNotInCall
                  .map((member) => ZegoCallUser(
                        member.userID,
                        member.userName,
                      ))
                  .toList(),
            );
          });
    },
  );

  /// initialized ZegoUIKitPrebuiltCallInvitationService
  /// when app's user is logged in or re-logged in
  /// We recommend calling this method as soon as the user logs in to your app.
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: AppStrings.appID /*input your AppID*/,
    appSign: AppStrings.appSign /*input your AppSign*/,
    userID: id,
    userName: name,
    plugins: [ZegoUIKitSignalingPlugin()],
    config: ZegoCallInvitationConfig(
      canInvitingInCalling: true,
    ),
    notificationConfig: ZegoCallInvitationNotificationConfig(
      androidNotificationConfig: ZegoCallAndroidNotificationConfig(
        /// call notification
        channelID: 'ZegoUIKit',
        channelName: 'Call Notifications',
        sound: 'call',
        icon: 'call',
        /// message notification
        messageChannelID: 'ZIM Message',
        messageChannelName: 'Message',
        messageSound: 'message',
        messageIcon: 'message',
      ),
    ),
    requireConfig: (ZegoCallInvitationData data) {
      final config = ZegoCallInvitationType.videoCall == data.type
          ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
          : ZegoUIKitPrebuiltCallConfig.groupVoiceCall();

      config.audioVideoView.useVideoViewAspectFill = true;
      config.topMenuBar.extendButtons = [
        sendCallingInvitationButton,
      ];
      return config;
    },
  );
}

void onUserLogout() {
  /// de-initialization ZegoUIKitPrebuiltCallInvitationService
  /// when app's user is logged out
  ZegoUIKitPrebuiltCallInvitationService().uninit();
}
