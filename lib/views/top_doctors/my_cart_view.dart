import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medics/controller/cart_controller.dart';
import 'package:medics/models/medicine.dart';
import 'package:medics/views/home/home_controller.dart';

import '../../../styles/color_constants.dart';
import '../../../styles/text_style.dart';
import '../../config/app_dimention.dart';
import '../../custom_widgets/custom_dialogs.dart';

class MyCartView extends StatelessWidget {
  MyCartView({super.key});

  // final Medicine medicine = Get.arguments as Medicine;
  final HomeController controller = Get.find();
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
        child: Column(
          children: [
            Obx(() {
              if (cartController.medicines.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: cartController.medicines.length,
                  itemBuilder: (context, index) {
                    final medicine = cartController.medicines[index];
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: _buildCartView(medicine, onTap: () {
                        /*Get.toNamed(Routes.doctor_detail,
                            arguments: controller.doctors[index]);*/
                      }),
                    );
                  },
                ),
              );
            }),
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
                          buttonText: 'Back to Home',
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
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCartView(Medicine medicine, {required Function() onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
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
                    width: 100, height: 100, fit: BoxFit.cover),
              ),
              SizedBox(width: 16),
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
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete_outline,
                              color: colorGray,
                            ))
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              // controller.decrementQuantity();
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
                              // controller.incrementQuantity();
                            },
                            icon: Icon(Icons.add_box, color: colorPrimary),
                            iconSize: 24),
                        Spacer(),
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
      ),
    );
  }
}
