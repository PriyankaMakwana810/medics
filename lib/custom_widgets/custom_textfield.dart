import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medics/styles/color_constants.dart';

import '../config/app_assets.dart';
import '../config/app_dimention.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData icon;

  CustomTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: colorPrimary,
      style: TextStyle(
          fontSize: Dimensions.fontSizeDefault,
          color: textColor,
          fontWeight: FontWeight.normal),
      obscureText: isPassword,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: textFieldFilled,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(icon),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
            fontSize: Dimensions.fontSizeDefault, color: textColorDisable),
        contentPadding: const EdgeInsets.symmetric(
            vertical: Dimensions.kPaddingSizeDefault,
            horizontal: Dimensions.kPaddingSizeLarge),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: textColorDisable),
        ),
        // focusColor: colorOnPrimary,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: textColorDisable),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: textColorDisable),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}

class CustomSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String assetName;
  final bool enabled;
  final Function() onPressed;

  const CustomSearchTextField({super.key,
    required this.controller,
    required this.hintText,
    required this.assetName,
    required this.enabled,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(!enabled){
          onPressed();
        }
      },
      child: TextFormField(
        controller: controller,
        cursorColor: colorPrimary,
        enabled: enabled,
        style: const TextStyle(
            fontSize: Dimensions.fontSizeDefault,
            color: textColor,
            fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          filled: true,
          fillColor: textFieldFilled,
          prefixIcon: Container(
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: SvgPicture.asset(assetName),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: Dimensions.fontSizeDefault, color: textColorDisable),
          contentPadding: const EdgeInsets.symmetric(
              vertical: Dimensions.kPaddingSizeDefault,
              horizontal: Dimensions.kPaddingSizeLarge),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: textColorDisable),
          ),
          // focusColor: colorOnPrimary,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: textColorDisable),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: textColorDisable),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
