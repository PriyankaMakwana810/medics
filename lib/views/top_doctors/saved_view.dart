import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/views/home/home_controller.dart';

import '../../../styles/color_constants.dart';
import '../../../styles/text_style.dart';
import '../../config/app_assets.dart';
import '../home/home_widgets.dart';

class SavedView extends StatelessWidget {
  SavedView({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          "Saved Articles",
          style: AppTextStyles.appBarStyle,
        ),
        centerTitle: true,
      ),
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          if (controller.articles.where((article) => article.isSaved).isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.emptyCart, width: 150, height: 150),
                  const SizedBox(height: 20),
                  const Text(
                    'No Articles are Saved.',
                    style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );

            // return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: controller.articles
                  .where((article) => article.isSaved)
                  .map((article) {
                return buildArticleCard(
                  article,
                  onTap: () {
                    print(article.time);
                    controller.onArticleTap(article, !article.isSaved);
                    // controller.onArticleTap(article.title);
                  },
                );
              }).toList(),
            ),
          );
        }),
      ),
    );
  }
}
