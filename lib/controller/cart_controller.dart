import 'package:get/get.dart';
import 'package:medics/controller/base_controller.dart';
import 'package:medics/models/medicine.dart';

import '../../database/database_helper.dart';

class CartController extends BaseController {
  var quantity = 1.obs;
  var medicines = <Medicine>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    List<Medicine>? medicineList = await DatabaseHelper.getCartValues();
    medicines.assignAll(medicineList);
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
