import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/styles/color_constants.dart';

import '../../routes/app_pages.dart';
import '../../styles/text_style.dart';
import '../home/home_controller.dart';
import 'doctor_widgets.dart';

class TopDoctorsView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          "Top Doctor",
          style: AppTextStyles.appBarStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options tap
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.doctors.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: controller.doctors.length,
            itemBuilder: (context, index) {
              final doctor = controller.doctors[index];
              return Padding(
                padding: EdgeInsets.all(8),
                child: buildDoctorListCard(doctor, onTap: () {
                  Get.toNamed(Routes.doctor_detail,
                      arguments: controller.doctors[index]);
                }),
              );
            },
          ),
        );
      }),
    );
  }
}
