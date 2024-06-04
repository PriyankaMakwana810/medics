import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/views/home/home_controller.dart';

import '../../../config/app_assets.dart';
import '../../../custom_widgets/custom_textfield.dart';
import '../../../styles/color_constants.dart';
import '../../../styles/text_style.dart';
import '../../routes/app_pages.dart';
import '../home/home_widgets.dart';
import 'doctor_widgets.dart';

class FindDoctorsView extends StatelessWidget {
  FindDoctorsView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Text('Find Doctors', style: AppTextStyles.appBarStyle),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchTextField(
                    onPressed: () {},
                    controller: TextEditingController(),
                    hintText: 'Find a doctor',
                    assetName: SVGAssets.search_icon,
                    enabled: true,
                  ),
                  const SizedBox(height: 20.0),
                  const Text('Category', style: AppTextStyles.mediumTextStyle),
                  const SizedBox(height: 10.0),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 16,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    runSpacing: 20,
                    children: [
                      buildCategoryIcon(SVGAssets.icon_doctor, 'General',
                          onTap: () {}),
                      buildCategoryIcon(
                        SVGAssets.icon_lungs,
                        'Lungs Specialist',
                        onTap: () {},
                      ),
                      buildCategoryIcon(
                        SVGAssets.icon_dentist,
                        'Dentist',
                        onTap: () {},
                      ),
                      buildCategoryIcon(
                        SVGAssets.icon_psychiatrist,
                        'Psychiatrist',
                        onTap: () {},
                      ),
                      buildCategoryIcon(
                        SVGAssets.icon_covid,
                        'Covid-19',
                        onTap: () {},
                      ),
                      buildCategoryIcon(
                        SVGAssets.icon_surgeon,
                        'Surgeon',
                        onTap: () {},
                      ),
                      buildCategoryIcon(
                        SVGAssets.icon_cardiologist,
                        'Cardiologist',
                        onTap: () {},
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text('Recommended Doctors',
                      style: AppTextStyles.mediumTextStyle),
                  const SizedBox(height: 10.0),
                  Obx(() {
                    if (controller.doctors.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return buildDoctorListCard(controller.doctors.first,
                        onTap: () {
                          Get.toNamed(Routes.doctor_detail, arguments: controller.doctors.first);

                      // controller.selectDoctor(controller.doctors.first);
                    });
                  }),
                  const SizedBox(height: 20.0),
                  const Text('Your Recent Doctors',
                      style: AppTextStyles.mediumTextStyle),
                  const SizedBox(height: 10.0),
                  Obx(() {
                    if (controller.doctors.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SizedBox(
                      height: 150.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = controller.doctors[index];
                          return _buildRecentDoctorAvatar(
                              doctor.image, doctor.name, onTap: () => controller.selectDoctor(doctor),);
                        },
                      ),
                    );
                  }),
                ],
              )),
        ));
  }

  Widget _buildRecentDoctorAvatar(String imageUrl, String name,
      {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () => onTap,
        child: Column(
          children: [
            CircleAvatar(
                radius: 40, // Image radius
                backgroundImage: AssetImage(imageUrl)),
            const SizedBox(height: 5),
            Text(name.split(' ').sublist(0, 2).join(' '),
                style: AppTextStyles.subTitle),
          ],
        ),
      ),
    );
  }
}
