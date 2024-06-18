import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medics/config/app_strings.dart';
import 'package:medics/routes/app_pages.dart';
import 'package:medics/views/splash/splash_binding.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../config/app_assets.dart';
import '../main.dart';
import '../styles/color_constants.dart';

class MyApp extends GetView {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final navigatorKey = GlobalKey<NavigatorState>();
    // ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: whiteColor));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      navigatorKey: navigatorKey,
      theme: ThemeData(
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: colorPrimary,
              onPrimary: colorOnPrimary,
              secondary: colorSecondary,
              onSecondary: textColor,
              error: Colors.red,
              onError: Colors.white,
              surface: whiteColor,
              onSurface: blackColor),
          primarySwatch: appColor,
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          primaryColor: colorPrimary,
          useMaterial3: true,
          hoverColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
              surfaceTintColor: whiteColor, backgroundColor: whiteColor),
          actionIconTheme: ActionIconThemeData(
            backButtonIconBuilder: (context) =>
                SvgPicture.asset(SVGAssets.back_icon),
          )),
      themeMode: ThemeMode.light,
      initialBinding: SplashBinding(),
      initialRoute: Routes.splash,
      getPages: AppPages.routes,
    );
  }
}
