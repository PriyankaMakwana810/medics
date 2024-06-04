import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medics/controller/base_controller.dart';
import 'package:medics/models/medicine.dart';

import '../../models/article.dart';
import '../../models/doctor.dart';
import '../../routes/app_pages.dart';

class HomeController extends BaseController {
  var doctors = <Doctor>[].obs;
  var articles = <Article>[].obs;
  var medicines = <Medicine>[].obs;
  var currentIndex = 0;
  var isAboutTextExpanded = false.obs;

  void onSignUpButtonTap() async {
    // await appPreferences.setOnboardDetails(true);
    Get.toNamed(Routes.sign_up);
  }

  var popularArticles =
      ['Covid-19', 'Diet', 'Fitness', 'Health', 'Doctors', 'Cancer'].obs;

  var dates = [
    {'day': 'Mon', 'date': '21'},
    {'day': 'Tue', 'date': '22'},
    {'day': 'Wed', 'date': '23'},
    {'day': 'Thu', 'date': '24'},
    {'day': 'Fri', 'date': '25'},
    {'day': 'Sat', 'date': '26'},
  ].obs;
  List<int> disabledTimes = [1, 4, 6];
  var times = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '07:00 PM',
    '08:00 PM',
  ].obs;

  var selectedDateIndex = 2.obs;
  var selectedTimeIndex = 3.obs;

  @override
  void onInit() {
    super.onInit();
    loadDoctorData();
    loadArticleData();
  }

  Future<void> loadDoctorData() async {
    final String response =
        await rootBundle.loadString('assets/data/doctor_data.json');
    final data = await json.decode(response) as List;
    doctors.value = data.map((e) => Doctor.fromJson(e)).toList();
  }

  Future<void> loadArticleData() async {
    final String response =
        await rootBundle.loadString('assets/data/article_data.json');
    final data = await json.decode(response) as List;
    articles.value = data.map((e) => Article.fromJson(e)).toList();
  }

  Future<void> loadPharmacyData() async {
    final String response =
        await rootBundle.loadString('assets/data/medicine_data.json');
    final data = await json.decode(response) as List;
    medicines.value = data.map((e) => Medicine.fromJson(e)).toList();
  }

  var selectedDoctor = Rxn<Doctor>();

  var searchText = ''.obs;

  // Add more variables and methods as needed
  void onSearchChanged(String value) {
    searchText.value = value;
  }

  // Example methods for handling button presses, etc.
  void onCategoryTap(String category) {
    if (category == 'Doctor') {
      Get.toNamed(Routes.top_doctor);
    }
    print('Category tapped: $category');
  }

  void selectDoctor(Doctor doctor) {
    Get.toNamed(Routes.doctor_detail, arguments: doctor);
    selectedDoctor.value = doctor;
  }

  void onDoctorCardTap(String doctorName) {
    print('Doctor card tapped: $doctorName');
  }

  void onArticleTap(String articleTitle) {
    print('Article tapped: $articleTitle');
  }

  void selectDate(int index) {
    selectedDateIndex.value = index;
  }

  void selectTime(int index) {
    selectedTimeIndex.value = index;
  }

  void toggleAboutText() {
    // Add this method
    isAboutTextExpanded.value = !isAboutTextExpanded.value;
  }
}
