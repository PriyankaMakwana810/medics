import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/custom_widgets/button.dart';
import 'package:medics/styles/color_constants.dart';

import '../config/app_dimention.dart';
import '../views/home/home_controller.dart';
import '../views/top_doctors/doctor_details_view.dart';

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
                fontSize: 20,
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

class DateTimeSelectionDialog extends StatelessWidget {
  const DateTimeSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Date and Time',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            buildDateSelector(),
            // const DateSelector(),
            const SizedBox(height: 20),
            const Text('Time', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            buildTimeSelector(),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  label: 'Confirm',
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeReasonDialog extends StatelessWidget {
  const ChangeReasonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Provide a Valid Reason',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Reason', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: controller.reasonOfVisit.value,
              onChanged: (value) {
                controller.reasonOfVisit.value =
                    value; // Update the reason text as the user types
              },
              cursorColor: colorPrimary,

              style: const TextStyle(
                  fontSize: Dimensions.fontSizeDefault,
                  color: textColor,
                  fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                filled: true,
                fillColor: textFieldFilled,
                hintText: 'Enter reason',
                hintStyle: const TextStyle(
                    fontSize: Dimensions.fontSizeDefault,
                    color: textColorDisable),
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
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 16,
                          color: whiteColor,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
