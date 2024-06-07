import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/custom_widgets/button.dart';
import 'package:medics/styles/color_constants.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  const SuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) => Container(
        height: 400,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  color: headerBackground, shape: BoxShape.circle),
              child: const Icon(
                Icons.check,
                color: colorPrimary,
                size: 50,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: textColorDisable),
            ),
            const SizedBox(height: 24),
            CustomButton(label: buttonText, onPressed: onPressed),
          ],
        ),
      );
}

class LogoutDialog extends StatelessWidget {
  final VoidCallback onPressed;

  const LogoutDialog({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) => Container(
        height: 400,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  color: headerBackground, shape: BoxShape.circle),
              child: const Icon(
                Icons.logout_outlined,
                color: colorPrimary,
                size: 50,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Are you sure to log out of your Account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(label: 'Log Out', onPressed: onPressed),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                Get.back(closeOverlays: true);
              },
              child: const Text(
                'Cancle',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: colorPrimary,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      );
}
