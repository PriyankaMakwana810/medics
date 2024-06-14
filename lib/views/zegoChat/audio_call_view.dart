import 'package:flutter/material.dart';
import 'package:medics/config/app_strings.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
class AudioCallView extends StatelessWidget {
  const AudioCallView({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: AppStrings.appID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: AppStrings.appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: '56789',
      userName: 'Priyanka Makwana',
      // userID: '456789',
      // userName: 'Dr. Marcus Horizon',
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );

  }
}
