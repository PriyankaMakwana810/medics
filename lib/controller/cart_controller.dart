import 'package:get/get.dart';
import 'package:medics/controller/base_controller.dart';
import 'package:medics/models/medicine.dart';
import '../../database/database_helper.dart';

class CartController extends BaseController {
  var medicines = <Medicine>[].obs;
  RxDouble totalSum = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    List<Medicine>? medicineList = await DatabaseHelper.getCartValues();
    double sum = 0.0;
    for (var medicine in medicineList) {
      sum += double.parse(medicine.price) * medicine.items;
    }
    totalSum.value = sum;
    medicines.assignAll(medicineList);
  }

  Future<bool> deleteItemFromCart(Medicine medicine) async {
    int result = await DatabaseHelper().deleteFromCart(medicine.id);
    if (result > 0) {
      medicines.remove(medicine);
      totalSum.value -= double.parse(medicine.price) * medicine.items;
      return true;
    }
    return false;
  }

}
