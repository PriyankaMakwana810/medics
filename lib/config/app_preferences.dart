import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();

  factory AppPreferences() => _instance;

  AppPreferences._internal();

  /*-----------------Preference constant----------------*/
  static const ISLOGIN = 'isLogin';
  static const UID = 'uID';
  static const String keyOnboardDetails = "keyOnboardDetails";

  // Method to set Onboard details
  Future<bool> setOnboardDetails(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(keyOnboardDetails, value);
  }

  //Method to get onboard details
  Future<bool?> getOnboardDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyOnboardDetails);
  }

  Future<bool?> getLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(ISLOGIN) ?? false;
  }

  Future<bool> setLogin(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(ISLOGIN, value);
  }

  Future<int?> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(UID);
  }

  Future<bool> setId(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(UID, value);
  }
}
