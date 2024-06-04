import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/models/article.dart';
import 'package:medics/views/home/home_controller.dart';

import '../../../styles/color_constants.dart';
import '../../../styles/text_style.dart';
import '../../config/app_assets.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../home/home_widgets.dart';

class ArticleListView extends StatelessWidget {
  ArticleListView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          "Appointment",
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
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchTextField(
                onPressed: () {},
                controller: TextEditingController(),
                hintText: 'Search articles, news...',
                assetName: SVGAssets.search_icon,
                enabled: true,
              ),
              const SizedBox(height: 20.0),
              const Text('Popular Articles',
                  style: AppTextStyles.mediumTextStyle),
              const SizedBox(height: 10.0),
              Obx(
                () {
                  return SizedBox(
                    height: 40.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.popularArticles.length,
                      itemBuilder: (context, index) {
                        final articleTag = controller.popularArticles[index];
                        return _buildArticleTagView(
                          articleTag,
                          onTap: () {},
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              buildSectionHeader('Trending Articles', onTap: () {}),
              const SizedBox(height: 20.0),
              Obx(() {
                if (controller.articles.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container(
                  height: 250.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.articles.length,
                    itemBuilder: (context, index) {
                      final article = controller.articles[index];
                      return _buildTrendingArticleCard(
                        article,
                        onTap: () {},
                      );
                    },
                  ),
                );
              }),
              const SizedBox(height: 20.0),
              buildSectionHeader('Related Articles', onTap: () {}),
              const SizedBox(height: 20.0),
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
                        controller.onArticleTap(article.title);
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

  Widget _buildTrendingArticleCard(Article article,
      {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colorSecondary, width: 1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(article.imageUrl,
                    width: 130, height: 90, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, top: 1, bottom: 1),
                      decoration: BoxDecoration(
                          color: colorSecondary,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: colorSecondary, width: 1)),
                      child: Text(
                        article.tag,
                        style:
                            const TextStyle(color: colorPrimary, fontSize: 8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(article.title,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          article.time,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: colorGray),
                        ),
                        const Text(
                          " • ",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: colorGray),
                        ),
                        Text(
                          article.timeToRead,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: colorPrimary),
                        ),
                      ],
                    ),
                    // SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleTagView(String name, {VoidCallback? onTap}) {
    return InkWell(
      onTap: () => onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Center(
          child: Text(
            name,
            style: TextStyle(color: whiteColor),
          ),
        ),
      ),
    );
  }
}
