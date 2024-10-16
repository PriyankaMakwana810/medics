import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting
import 'package:medics/controller/base_controller.dart';
import 'package:medics/models/medicine.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../../config/app_preferences.dart';
import '../../database/database_helper.dart';
import '../../models/article.dart';
import '../../models/doctor.dart';
import '../../routes/app_pages.dart';

class HomeController extends BaseController {
  AppPreferences appPreferences = AppPreferences();

  var doctors = <Doctor>[].obs;
  var articles = <Article>[].obs;
  var medicines = <Medicine>[].obs;
  var currentIndex = 0;
  var isAboutTextExpanded = false.obs;

  var selectedDoctors = <int>[].obs;
  var groupMembers = <String>[].obs;
  var selectedDoctorIndex = (-1).obs;
  var selectedDoctorForRemoval = (-1).obs;
  var groupMembersInfo = <ZIMGroupMemberInfo>[].obs;


  bool isDoctorSelectedForAddGroup(int index) {
    return selectedDoctorIndex.value == index;
  }
  void toggleDoctorSelectionForAddGroup(int index) {
    if (selectedDoctorIndex.value == index) {
      selectedDoctorIndex.value = -1;
      groupMembers.clear(); // Deselect
    } else {
      selectedDoctorIndex.value = index;
      groupMembers.assignAll([doctors[index].userId]); // Select
    }
    update(); // Notify GetX to update the UI
  }
  bool isDoctorSelectedForRemoval(int index) {
    return selectedDoctorForRemoval.value == index;
  }
  bool isDoctorSelected(int index) {
    return selectedDoctors.contains(index);
  }
  void toggleDoctorSelectionForRemoval(int index) {
    if (selectedDoctorForRemoval.value == index) {
      selectedDoctorForRemoval.value = -1;
    } else {
      selectedDoctorForRemoval.value = index;
    }
    update(); // Notify GetX to update the UI
  }
  List<String> getSelectedGroupMembers() {
    if (selectedDoctorForRemoval.value != -1) {
      return [groupMembersInfo[selectedDoctorForRemoval.value].userID];
    }
    return [];
  }
  void toggleDoctorSelection(int index) {
    if (selectedDoctors.contains(index)) {
      selectedDoctors.remove(index);
      groupMembers.remove(doctors[index].userId); // Select
      // Deselect
    } else {
      selectedDoctors.add(index);
      groupMembers.add(doctors[index].userId); // Select
    }
    update(); // Notify GetX to update the UI
  }

  void setGroupMembers(List<ZIMGroupMemberInfo> members) {
    groupMembersInfo.assignAll(members);
  }

  List<Doctor> getSelectedDoctors() {
    return selectedDoctors.map((index) => doctors[index]).toList();
  }

  void onSignUpButtonTap() async {
    // await appPreferences.setOnboardDetails(true);
    Get.toNamed(Routes.sign_up);
  }

  var popularArticles =
      ['Covid-19', 'Diet', 'Fitness', 'Health', 'Doctors', 'Cancer'].obs;
  var dates = <Map<String, String>>[].obs; // Update this line

  List<int> disabledTimes = [1, 4, 6];
  var times = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '07:00 PM',
    '08:00 PM',
  ].obs;

  var selectedDateIndex = 2.obs;
  var selectedTimeIndex = 3.obs;
  var reasonOfVisit = 'Chest Pain'.obs;
  var selectedDrChat = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDoctorData();
    loadArticleData();
    generateCurrentWeekDates();
  }

  void generateCurrentWeekDates() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    dates.clear(); // Clear previous dates
    for (int i = 0; i < 7; i++) {
      final date = startOfWeek.add(Duration(days: i));
      dates.add({
        'day': DateFormat('EEE').format(date),
        'date': DateFormat('dd').format(date),
      });
    }
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
    List<Article> jsonArticles = data.map((e) => Article.fromJson(e)).toList();

    // Load saved articles from database
    List<Article> savedArticles = await DatabaseHelper.getSavedArticles();
    Map<int, Article> savedArticlesMap = {
      for (var article in savedArticles) article.id: article
    };

    articles.value = jsonArticles.map((article) {
      if (savedArticlesMap.containsKey(article.id)) {
        article.isSaved = savedArticlesMap[article.id]!.isSaved;
      }
      return article;
    }).toList();
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
    if (category == 'Ambulance') {
      Get.toNamed(Routes.map_ambulance);
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

  void onArticleTap(Article article, bool isSaved) {
    saveArticle(article, isSaved);
    loadArticleData();
    print('Article tapped: ${article.title}');
  }

  void selectDate(int index) {
    selectedDateIndex.value = index;
  }

  void selectTime(int index) {
    selectedTimeIndex.value = index;
  }

  void selectDoctorForChat(int index) {
    selectedDrChat.value = index;
  }

  void onLogoutTap() {
    appPreferences.setLogin(false);
    Get.offAllNamed(Routes.intro);
  }

  Doctor getDoctorData(String docName) {
    return doctors.firstWhere((m) => m.name == docName);
  }

  void toggleAboutText() {
    // Add this method
    isAboutTextExpanded.value = !isAboutTextExpanded.value;
  }

  Future<int> saveArticle(Article article, bool isSaved) async {
    article.isSaved = isSaved;
    print(' $isSaved');
    return await DatabaseHelper().saveArticle(article);
  }
}
