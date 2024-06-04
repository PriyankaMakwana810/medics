import 'package:flutter/material.dart';
import 'package:medics/styles/color_constants.dart';

import '../config/app_dimention.dart';

class AppTextStyles {
  static const TextStyle heading1 =
      TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: textColor);

  static const TextStyle heading2 = TextStyle(
    fontSize: 16.0,
    color: textColorDisable,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16.0,
    color: Colors.grey,
  );

  static const TextStyle mediumTextStyle = TextStyle(
      fontSize: Dimensions.fontSize18,
      fontWeight: FontWeight.bold,
      color: textColor);

  static const TextStyle smallTextStyle = TextStyle(
      fontSize: Dimensions.fontSizeLarge,
      fontWeight: FontWeight.bold,
      color: textColor);

  static const TextStyle textButtonStyle = TextStyle(
      fontSize: Dimensions.fontSizeDefault,
      color: colorPrimary,
      fontWeight: FontWeight.normal);

  static const TextStyle appBarStyle =
      TextStyle(fontSize: 20.0, color: textColor, fontWeight: FontWeight.w600);

  static const TextStyle errorText = TextStyle(
    fontSize: 14.0,
    color: Colors.red,
  );

  static const TextStyle bodyHome = TextStyle(
    fontSize: 14.0,
    color: textColorDisable,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle subTitle = TextStyle(
    fontSize: 14.0,
    color: Color(0xFF3B4453),
    fontWeight: FontWeight.w500
  );

  static const TextStyle tableRow1 = TextStyle(
    fontSize: 14.0,
    color: textColorDisable,
  );
  static const TextStyle tableRow2 = TextStyle(
    fontSize: 14.0,
    color: Color(0xFF101623),
  );
}
