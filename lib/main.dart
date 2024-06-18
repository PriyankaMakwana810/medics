import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medics/config/app_strings.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'app/app.dart';
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
    ),// your appSign
  );
  runApp(const MyApp());
  NotificationManager().init();
}


