import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medics/views/splash/splash_controller.dart';

import '../../config/app_assets.dart';
import '../../config/app_dimention.dart';
import '../../styles/color_constants.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dimensions.screenWidth = MediaQuery.of(context).size.width;
    Dimensions.screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder(
      init: SplashController(),
      builder: (SplashController controller) {
        return Scaffold(
          body: Container(
            color: colorPrimary,
            height: Dimensions.screenHeight,
            width: Dimensions.screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(SVGAssets.splashAppLogo,height:Dimensions.screenHeight / 6)
              ],
            ),
          ),
        );
      },
    );
  }
}
