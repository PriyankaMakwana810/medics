import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medics/views/home/home_controller.dart';

import '../../../config/app_assets.dart';
import '../../../custom_widgets/custom_textfield.dart';
import '../../../routes/app_pages.dart';
import '../../../styles/color_constants.dart';
import '../../../styles/text_style.dart';
import '../home_widgets.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Wrap(children: [
                        Text('Find your desire \nhealth solution',
                            style: AppTextStyles.heading1),
                      ]),
                      SvgPicture.asset(SVGAssets.notification_icon),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  CustomSearchTextField(
                    controller: TextEditingController(),
                    hintText: 'Search doctor, drugs, articles...',
                    assetName: SVGAssets.search_icon,
                    enabled: false,
                    onPressed: () => Get.toNamed(Routes.find_doctors),
                    // validator: controller.validatePassword,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildCategoryIcon(
                        SVGAssets.icon_doctor,
                        'Doctor',
                        onTap: () {
                          Get.toNamed(Routes.top_doctor);
                        },
                      ),
                      buildCategoryIcon(
                        SVGAssets.icon_pharmacy,
                        'Pharmacy',
                        onTap: () => {Get.toNamed(Routes.pharmacy)},
                      ),
                      buildCategoryIcon(
                        SVGAssets.icon_hospital,
                        'Hospital',
                        onTap: () => controller.onCategoryTap('Hospital'),
                      ),
                      buildCategoryIcon(
                        SVGAssets.icon_ambulance,
                        'Ambulance',
                        onTap: () => controller.onCategoryTap('Ambulance'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  buildBannerAd('Early protection for your family health',
                      'Learn More', AppAssets.adDoctorImage),
                  const SizedBox(height: 10.0),
                  buildSectionHeader('Top Doctor', onTap: () {
                    Get.toNamed(Routes.top_doctor);
                    // Handle "See all" tap
                  }),
                  SizedBox(height: 8),
                  Obx(() {
                    if (controller.doctors.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Container(
                      height: 180.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = controller.doctors[index];
                          return buildDoctorCard(
                            doctor,
                            onTap: () {
                              controller.selectedDoctor.value = doctor;
                              Get.toNamed(Routes.doctor_detail,
                                  arguments: doctor);
                              // controller.selectDoctor(doctor);
                            },
                          );
                        },
                      ),
                    );
                  }),
                  SizedBox(height: 16),
                  buildSectionHeader('Health article', onTap: () {
                    Get.toNamed(Routes.articlesList);
                    // Handle "See all" tap
                  }),
                  SizedBox(height: 8),
                  // _buildArticleList(),
                  Obx(() {
                    if (controller.articles.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      children: controller.articles.map((article) {
                        return buildArticleCard(
                          article,
                          onTap: () {
                            print(article.time);
                            controller.onArticleTap(article, !article.isSaved);
                          },
                        );
                      }).toList(),
                    );
                  }),
                ],
              )),
        ));
  }
}
