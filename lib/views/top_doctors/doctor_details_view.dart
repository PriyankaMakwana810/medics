import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/config/app_dimention.dart';
import 'package:medics/views/home/home_controller.dart';
import 'package:readmore/readmore.dart';

import '../../../styles/color_constants.dart';
import '../../../styles/text_style.dart';
import '../../config/app_strings.dart';
import '../../custom_widgets/button.dart';
import '../../models/doctor.dart';
import '../../routes/app_pages.dart';
import 'doctor_widgets.dart';

class DoctorDetailView extends StatelessWidget {
  const DoctorDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Doctor doctor = Get.arguments as Doctor;
    final HomeController controller = Get.find();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          "Doctor Detail",
          style: AppTextStyles.appBarStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options tap
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDoctorListCard(
                doctor,
                onTap: () {},
              ),
              const SizedBox(height: 30),
              const Text('About', style: AppTextStyles.mediumTextStyle),
              const SizedBox(height: 10),
              const ReadMoreText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                trimMode: TrimMode.Line,
                trimLines: 3,
                colorClickableText: colorPrimary,
                trimCollapsedText: 'Read more',
                trimExpandedText: 'Read less',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              _buildDateSelector(),
              const SizedBox(height: 20),
              const Divider(color: colorSecondary),
              const SizedBox(height: 20),
              _buildTimeSelector(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.chat_doctor, arguments: doctor);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: colorSecondary,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colorSecondary, width: 1)),
                child: const Icon(
                  Icons.message,
                  color: colorPrimary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomFilledButton(
                label: AppStrings.book_appointment,
                onPressed: () {
                  if (controller.selectedDateIndex.value == 0) {
                    Get.snackbar(
                      'Error',
                      'Please select a date.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  if (controller.selectedTimeIndex.value == 0) {
                    Get.snackbar(
                      'Error',
                      'Please select a time.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  controller.selectedDoctor.value = doctor;
                  Get.toNamed(Routes.appointmentDetail);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    final HomeController controller = Get.find();
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(controller.dates.length, (index) {
          final date = controller.dates[index];
          return GestureDetector(
            onTap: () => controller.selectDate(index),
            child: Container(
              decoration: BoxDecoration(
                color: controller.selectedDateIndex.value == index
                    ? colorPrimary
                    : whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: colorSecondary),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  Text(
                    date['day']!,
                    style: TextStyle(
                      fontSize: Dimensions.fontSizeSmall,
                      fontWeight: FontWeight.normal,
                      color: controller.selectedDateIndex.value == index
                          ? whiteColor
                          : textColor,
                    ),
                  ),
                  Text(
                    date['date']!,
                    style: TextStyle(
                      fontSize: Dimensions.fontSize18,
                      fontWeight: FontWeight.bold,
                      color: controller.selectedDateIndex.value == index
                          ? whiteColor
                          : textColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }

  Widget _buildTimeSelector() {
    final HomeController controller = Get.find();
    return Obx(() {
      return Wrap(
        spacing: 14.0, // Adjust spacing between items
        runSpacing: 14.0, // Adjust spacing between rows
        children: List.generate(controller.times.length, (index) {
          final time = controller.times[index];
          final bool isDisabled = controller.disabledTimes.contains(index);
          return GestureDetector(
            onTap: isDisabled ? null : () => controller.selectTime(index),
            child: Container(
              decoration: BoxDecoration(
                color: controller.selectedTimeIndex.value == index
                    ? colorPrimary
                    : whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isDisabled ? borderColor : chipBorder,
                ),
              ),
              // margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                time,
                style: TextStyle(
                  color: isDisabled
                      ? borderColor
                      : controller.selectedTimeIndex.value == index
                          ? whiteColor
                          : textColor,
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
