import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medics/config/app_assets.dart';
import 'package:medics/views/home/home_controller.dart';

import '../../../styles/color_constants.dart';
import '../../../styles/text_style.dart';
import '../../config/app_dimention.dart';
import '../../custom_widgets/custom_dialogs.dart';
import 'doctor_widgets.dart';

class AppointmentDetailView extends StatelessWidget {
  const AppointmentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final doctor = controller.selectedDoctor.value;
    final selectedDateIndex = controller.selectedDateIndex.value;
    final selectedTimeIndex = controller.selectedTimeIndex.value;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          "Appointment",
          style: AppTextStyles.appBarStyle,
        ),
        centerTitle: true,
        /*actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options tap
            },
          ),*/
        // ],
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDoctorListCard(
                doctor!,
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _buildSectionHeader('Date'),
              Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: colorSecondary,
                    child: SvgPicture.asset(SVGAssets.schedule_selected),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${controller.dates[selectedDateIndex]['day']}, Jun ${controller.dates[selectedDateIndex]['date']}, 2024 | ${controller.times[selectedTimeIndex]} ',
                    style: const TextStyle(
                        color: Color(0xFF555555),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(color: colorSecondary),
              _buildSectionHeader('Reason'),
              const Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: colorSecondary,
                    child: Icon(
                      Icons.edit_calendar,
                      color: colorPrimary,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Chest Pain',
                    style: TextStyle(
                        color: Color(0xFF555555),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(color: colorSecondary),
              const SizedBox(height: 10),
              const Text(
                'Payment Detail',
                style: TextStyle(
                    fontSize: Dimensions.fontSize18,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Consultation', style: AppTextStyles.tableRow1),
                  Text('\$60.00'),
                ],
              ),
              const SizedBox(height: 5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Admin Fee', style: AppTextStyles.tableRow1),
                  Text('\$1.00'),
                ],
              ),
              const SizedBox(height: 5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Additional Discount', style: AppTextStyles.tableRow1),
                  Text('-'),
                ],
              ),
              const SizedBox(height: 5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: textColor,
                          fontWeight: FontWeight.w600)),
                  Text(
                    '\$61.00',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: colorPrimary,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const Divider(color: colorSecondary),
              const SizedBox(height: 10),
              const Text('Payment Method',
                  style: AppTextStyles.mediumTextStyle),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: colorSecondary, width: 1),
                ),
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'VISA',
                      style: TextStyle(
                          color: const Color(0xFF1A1F71),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(5.0, 4.0),
                            ),
                          ],
                          fontStyle: FontStyle.italic),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Change',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total', style: AppTextStyles.tableRow1),
                        Text(
                          '\$61.00',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: textColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SuccessDialog(
                            title: 'Payment Success',
                            message:
                                'Your payment has been successful, you can have a consultation session with your trusted doctor',
                            buttonText: 'Chat Doctor',
                            onPressed: () {
                              // controller.onHomeClick();
                            },
                          );
                        },
                      );
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
                          'Booking',
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: Dimensions.fontSize18,
              fontWeight: FontWeight.w600,
              color: textColor),
        ),
        TextButton(
          onPressed: onTap,
          child: const Text(
            'Change',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
