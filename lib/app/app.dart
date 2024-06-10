import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medics/config/app_strings.dart';
import 'package:medics/routes/app_pages.dart';
import 'package:medics/views/splash/splash_binding.dart';

import '../config/app_assets.dart';
import '../styles/color_constants.dart';

class MyApp extends GetView {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: whiteColor));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
          primarySwatch: appColor,
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          primaryColor: colorPrimary,
          useMaterial3: true,
          hoverColor: Colors.transparent,
          appBarTheme: const AppBarTheme(surfaceTintColor: whiteColor,backgroundColor: whiteColor),
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
