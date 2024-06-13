part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const splash = '/';
  static const onboarding = '/onboard';
  static const intro = '/intro';
  static const login = '/login';
  static const sign_up = '/signUp';
  static const forgot_password = '/forgot_password';
  static const verification_code = '/verification_code';
  static const change_password = '/change_password';
  static const home = '/home';
  static const top_doctor = '/top_doctor';

  static const find_doctors = '/find_doctors';

  static const doctor_detail = '/doctor_detail';
  static const appointmentDetail = '/appointmentDetail';

  static const articlesList = '/article_list';

  static const pharmacy = '/pharmacy';
  static const chat_doctor = '/chat';
  static const drug_detail = '/drug_detail';

  static const map_ambulance = '/map_ambulance';
  static const my_cart = '/my_cart';
  static const dashboard = '/dashboard';
  static const messages = '/messages';
  static const schedule = '/schedule';
  static const profile = '/profile';

  static const saved = '/saved';
  static const chat_list = '/chat_list';
  static const chat_screen_view = '/chat_screen';

}
