import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/models/medicine.dart';
import 'package:medics/views/home/home_controller.dart';

import '../../../styles/color_constants.dart';
import '../../../styles/text_style.dart';
import '../../config/app_assets.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../routes/app_pages.dart';
import '../home/home_widgets.dart';

class PharmacyView extends StatelessWidget {
  PharmacyView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    controller.loadPharmacyData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          "Pharmacy",
          style: AppTextStyles.appBarStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Get.toNamed(Routes.my_cart);
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
                hintText: 'Search drugs, category...',
                assetName: SVGAssets.search_icon,
                enabled: true,
              ),
              const SizedBox(height: 20.0),
              buildBannerAd('Order quickly with Prescription',
                  'Upload Prescription', AppAssets.adMedicineImage),
              const SizedBox(height: 20.0),
              buildSectionHeader('Popular Product', onTap: () {}),
              const SizedBox(height: 10.0),
              Obx(() {
                if (controller.medicines.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  height: 180.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.medicines.length,
                    itemBuilder: (context, index) {
                      final medicine = controller.medicines[index];
                      return _buildPopularProductCard(
                        medicine,
                        onTap: () {
                          Get.toNamed(Routes.drug_detail, arguments: medicine);
                        },
                      );
                    },
                  ),
                );
              }),
              const SizedBox(height: 20.0),
              buildSectionHeader('Product On Sale', onTap: () {}),
              const SizedBox(height: 10.0),
              Obx(() {
                if (controller.articles.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  height: 180.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.medicines.length,
                    itemBuilder: (context, index) {
                      final medicine = controller.medicines[index];
                      return _buildProductOnSaleCard(
                        medicine,
                        onTap: () {
                          Get.toNamed(Routes.drug_detail, arguments: medicine);
                        },
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularProductCard(Medicine medicine,
      {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          width: 130,
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
                child: Image.asset(medicine.image,
                    width: 70, height: 70, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(medicine.name,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Text(medicine.quantity,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: colorGray)),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('\$${medicine.price}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const Spacer(),
                        const Icon(
                          Icons.add_box,
                          color: colorPrimary,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductOnSaleCard(Medicine medicine,
      {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          width: 130,
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
                child: Image.asset(medicine.image,
                    width: 70, height: 70, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(medicine.name,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Text(medicine.quantity,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: colorGray)),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('\$${medicine.discountedPrice}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text('\$${medicine.price}',
                              style: const TextStyle(
                                  color: colorGray,
                                  fontSize: 8,
                                  decoration: TextDecoration.lineThrough)),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.add_box,
                          color: colorPrimary,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
