import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medics/controller/base_controller.dart';

import '../../../database/database_helper.dart';
import '../../../models/medicine.dart';

class PharmacyController extends BaseController {
  var medicines = <Medicine>[].obs;
  var quantity = 1.obs;

  @override
  void onInit() {
    loadPharmacyData();
    super.onInit();
  }

  Future<void> loadPharmacyData() async {
    final String response =
        await rootBundle.loadString('assets/data/medicine_data.json');
    final data = await json.decode(response) as List;
    medicines.value = data.map((e) => Medicine.fromJson(e)).toList();
  }
  void quanitiyUpdate(int value) {
    quantity.value = value;
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }


  Future<int> addItemToCart(Medicine medicine, int quantity) async {
    medicine.items = quantity;
    print(' $quantity');
    return await DatabaseHelper().saveToCart(medicine);
  }
}
