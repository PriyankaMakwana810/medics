import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/config/app_assets.dart';
import 'package:medics/controller/cart_controller.dart';
import 'package:medics/models/medicine.dart';
import 'package:medics/utils/utility.dart';

import '../../../styles/color_constants.dart';
import '../../../styles/text_style.dart';
import '../../config/app_dimention.dart';
import '../../custom_widgets/custom_dialogs.dart';
import '../../routes/app_pages.dart';

class MyCartView extends StatelessWidget {
  MyCartView({super.key});

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          "My Cart",
          style: AppTextStyles.appBarStyle,
        ),
        centerTitle: true,
      ),
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          if (cartController.medicines.isEmpty) {
            // return const Center(child: CircularProgressIndicator());
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.emptyCart, width: 150, height: 150),
                  const SizedBox(height: 20),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cartController.medicines.length,
                  itemBuilder: (context, index) {
                    final medicine = cartController.medicines[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _buildCartView(
                        medicine,
                        onDeleteTap: () async {
                          bool success =
                              await cartController.deleteItemFromCart(medicine);
                          if (success) {
                            Utility.snackBar(
                                'Item deleted successfully', context);
                          } else {
                            Utility.snackBar('Failed to delete item', context);
                          }
                          // Handle delete
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment Detail',
                        style: TextStyle(
                            fontSize: Dimensions.fontSize18,
                            fontWeight: FontWeight.w600,
                            color: textColor),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal', style: AppTextStyles.tableRow1),
                          Text(
                              '\$${cartController.totalSum.value.toStringAsFixed(2)}'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Taxes', style: AppTextStyles.tableRow1),
                          Text('\$1.00'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: textColor,
                                  fontWeight: FontWeight.w600)),
                          Text(
                            '\$${(cartController.totalSum.value + 1.0).toStringAsFixed(2)}',
                            style: const TextStyle(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
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
                      const SizedBox(height: 80),
                      // Additional space to avoid overlap
                    ],
                  );
                }),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: Obx(() {
        if (cartController.medicines.isNotEmpty) {
          // return const Center(child: CircularProgressIndicator());
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total', style: AppTextStyles.tableRow1),
                      Obx(
                        () {
                          return Text(
                            '\$${(cartController.totalSum.value + 1.0).toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 18.0,
                                color: textColor,
                                fontWeight: FontWeight.w600),
                          );
                        },
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
                          buttonText: 'Back to Home',
                          onPressed: () {
                            Get.offAllNamed(Routes.home);
                            // Handle navigation back to home
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
                        'Checkout',
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
            ),
          );
        }
        return const Text('');
      }),
    );
  }

  Widget _buildCartView(Medicine medicine,
      {required VoidCallback onDeleteTap}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorSecondary, width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(medicine.image,
                  width: 75, height: 75, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(medicine.name,
                              style: const TextStyle(
                                  fontSize: Dimensions.fontSize18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor)),
                          Text(medicine.quantity,
                              style: const TextStyle(
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w600,
                                  color: colorGray)),
                        ],
                      ),
                      IconButton(
                          onPressed: () => onDeleteTap(),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: colorGray,
                          ))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            // Handle decrement
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: colorGray,
                          ),
                          iconSize: 24),
                      Text('${medicine.items}',
                          style: AppTextStyles.mediumTextStyle),
                      IconButton(
                          onPressed: () {
                            // Handle increment
                          },
                          icon: const Icon(Icons.add_box, color: colorPrimary),
                          iconSize: 24),
                      const Spacer(),
                      Text('\$ ${medicine.price}',
                          style: AppTextStyles.mediumTextStyle),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
