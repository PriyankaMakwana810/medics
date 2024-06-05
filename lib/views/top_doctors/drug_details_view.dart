import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:medics/models/medicine.dart';
import 'package:medics/views/home/home_controller.dart';
import 'package:readmore/readmore.dart';

import '../../../styles/color_constants.dart';
import '../../../styles/text_style.dart';
import '../../config/app_dimention.dart';
import '../../config/app_strings.dart';
import '../../custom_widgets/button.dart';
import '../../routes/app_pages.dart';

class DrugDetailsView extends StatelessWidget {
  DrugDetailsView({super.key});

  final Medicine medicine = Get.arguments as Medicine;
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          "Drugs Detail",
          style: AppTextStyles.appBarStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Get.toNamed(Routes.my_cart);
              // Handle more options tap
            },
          ),
        ],
      ),
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  Center(
                      child: Image.asset(medicine.image,
                          height: 180, width: 180, fit: BoxFit.cover)),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(medicine.name,
                              style: const TextStyle(
                                  fontSize: Dimensions.fontSize20,
                                  fontWeight: FontWeight.bold,
                                  color: textColor)),
                          Text(medicine.quantity,
                              style: const TextStyle(
                                  fontSize: Dimensions.fontSizeLarge,
                                  fontWeight: FontWeight.w600,
                                  color: colorGray)),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              RatingBar(
                                itemSize: 15.0,
                                initialRating: double.parse(medicine.rate),
                                ignoreGestures: true,
                                allowHalfRating: true,
                                ratingWidget: RatingWidget(
                                    full: const Icon(Icons.star_outlined,
                                        color: colorPrimary),
                                    half: const Icon(Icons.star_half_outlined,
                                        color: colorPrimary),
                                    empty: const Icon(
                                        Icons.star_border_outlined,
                                        color: colorPrimary)),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              const SizedBox(width: 2),
                              Text(
                                medicine.rate,
                                style: const TextStyle(
                                    color: colorPrimary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                      const Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.decrementQuantity();
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: colorGray,
                                ),
                                iconSize: 30),
                            const SizedBox(width: 6.0),
                            Text('${controller.quantity}',
                                style: AppTextStyles.mediumTextStyle),
                            const SizedBox(width: 6.0),
                            IconButton(
                                onPressed: () {
                                  controller.incrementQuantity();
                                },
                                icon: Icon(Icons.add_box, color: colorPrimary),
                                iconSize: 30),
                          ],
                        ),
                        Text('\$ ${medicine.price}',
                            style: AppTextStyles.mediumTextStyle),
                      ],
                    );
                  }),
                  const SizedBox(height: 30),
                  const Text('Description',
                      style: AppTextStyles.smallTextStyle),
                  const SizedBox(height: 10),
                  const ReadMoreText(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    trimMode: TrimMode.Line,
                    trimLines: 5,
                    colorClickableText: colorPrimary,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: 'Read less',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorSecondary,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: colorSecondary, width: 1)),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: colorPrimary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomFilledButton(
                    label: AppStrings.buy_now,
                    onPressed: () {
                      var id = controller.addItemToCart(
                          medicine, controller.quantity.value);
                      print('$id $medicine');
                      Get.toNamed(Routes.my_cart);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
