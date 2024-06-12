import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medics/styles/color_constants.dart';

class CustomFilledButton extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final double width;
  final double radius;
  final bool isLoading;

  const CustomFilledButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width = double.infinity,
    this.radius = 30,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
          color: colorPrimary,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    color: whiteColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final double width;
  final double radius;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width = double.infinity,
    this.radius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: colorPrimary, width: 1)),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: colorPrimary,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const CustomButton({super.key, 
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: isPrimary ? whiteColor : colorPrimary,
        backgroundColor: isPrimary ? colorPrimary : whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        side: isPrimary ? null : const BorderSide(color: colorPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class CustomOutlinedIconButton extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final String icon;
  final double width;
  final double radius;

  const CustomOutlinedIconButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    this.width = double.infinity,
    this.radius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: textColorDisable, width: 1)),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SvgPicture.asset(icon),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
