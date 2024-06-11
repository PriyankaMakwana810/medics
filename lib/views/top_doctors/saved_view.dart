import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/views/home/home_controller.dart';

import '../../../styles/color_constants.dart';
import '../../../styles/text_style.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // buildSectionHeader('Saved Articles', onTap: () {}),
              // const SizedBox(height: 20.0),
              Obx(() {
                if (controller.articles.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
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
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
