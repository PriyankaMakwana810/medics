import 'package:flutter/material.dart';
import 'package:medics/styles/color_constants.dart';

import '../config/app_dimention.dart';

class CommonTextButton extends StatelessWidget {
  final Function() onPressed;
  final String label;
  const CommonTextButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          color: textColorDisable,
          fontSize: Dimensions.fontSizeDefault,
        ),
      ),
    );
  }
}
