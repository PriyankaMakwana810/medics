import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:medics/map_views/map_ambulance_view.dart';
import 'package:medics/views/home/home_binding.dart';
import 'package:medics/views/home/home_view.dart';
import 'package:medics/views/home/tabs/dashboard_Tab.dart';
import 'package:medics/views/home/tabs/messages_tab.dart';
import 'package:medics/views/home/tabs/profile_tab.dart';
import 'package:medics/views/home/tabs/schedule_tab.dart';
import 'package:medics/views/login/login_binding.dart';
import 'package:medics/views/login/login_view.dart';
import 'package:medics/views/onboarding/intro_view.dart';
import 'package:medics/views/reset_password/code_verification_view.dart';
import 'package:medics/views/reset_password/reset_password_binding.dart';
import 'package:medics/views/reset_password/reset_password_view.dart';
import 'package:medics/views/sign_up/signup_binding.dart';
import 'package:medics/views/sign_up/signup_view.dart';
import 'package:medics/views/top_doctors/article_list_view.dart';
import 'package:medics/views/top_doctors/chat_view.dart';
import 'package:medics/views/top_doctors/drug_details_view.dart';
import 'package:medics/views/top_doctors/find_doctors_view.dart';
import 'package:medics/views/top_doctors/my_cart_view.dart';
import 'package:medics/views/top_doctors/pharmacy_view.dart';
import 'package:medics/views/top_doctors/top_doctors_view.dart';
import 'package:medics/views/zegoChat/chat_list.dart';
import 'package:medics/views/zegoChat/chat_list_binding.dart';
import 'package:medics/views/zegoChat/chat_screen_view.dart';

import '../views/onboarding/onboard_view.dart';
import '../views/onboarding/onboarding_binding.dart';
import '../views/reset_password/new_password_view.dart';
import '../views/splash/splash_binding.dart';
import '../views/splash/splash_view.dart';
import '../views/top_doctors/book_appointment_view.dart';
import '../views/top_doctors/doctor_details_view.dart';
import '../views/top_doctors/saved_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;
  static final routes = [
    GetPage(
        name: Routes.splash,
        page: () => const SplashView(),
        binding: SplashBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.onboarding,
        page: () => const OnBoardingView(),
        binding: OnboardingBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.intro,
        page: () => const IntroView(),
        binding: OnboardingBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.login,
        page: () => LoginView(),
        binding: LoginBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.sign_up,
        page: () => SignUpView(),
        binding: SignUpBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.forgot_password,
        page: () => ResetPasswordView(),
        binding: ResetPasswordBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.verification_code,
        page: () => VerificationCodeView(),
        binding: ResetPasswordBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.change_password,
        page: () => ChangePasswordView(),
        binding: ResetPasswordBinding(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.home,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: Transition.fadeIn),
    GetPage(
      name: Routes.top_doctor,
      page: () => TopDoctorsView(),
    ),
    GetPage(name: Routes.find_doctors, page: () => FindDoctorsView()),
    GetPage(name: Routes.articlesList, page: () => ArticleListView()),
    GetPage(
      name: Routes.doctor_detail,
      page: () => const DoctorDetailView(),
    ),
    GetPage(
      name: Routes.appointmentDetail,
      page: () => const AppointmentDetailView(),
    ),
    GetPage(
        name: Routes.dashboard,
        page: () => DashboardView(),
        binding: HomeBinding()),
    GetPage(name: Routes.pharmacy, page: () => PharmacyView()),
    GetPage(name: Routes.drug_detail, page: () => DrugDetailsView()),
    GetPage(name: Routes.my_cart, page: () => MyCartView()),
    GetPage(name: Routes.map_ambulance, page: () => MapAmbulanceView()),
    GetPage(name: Routes.messages, page: () => MessagesView()),
    GetPage(name: Routes.schedule, page: () => ScheduleView()),
    GetPage(name: Routes.profile, page: () => ProfileView()),
    GetPage(name: Routes.chat_doctor, page: () => ChatView()),
    GetPage(name: Routes.saved, page: () => SavedView()),
    GetPage(
        name: Routes.chat_list,
        page: () => ChatListView(),
        binding: ChatListBinding(),
        transition: Transition.fadeIn),
    // GetPage(
        // name: Routes.chat_screen_view,
        // page: () => ChatScreenView(),
        // binding: ChatListBinding(),
        // transition: Transition.fadeIn),
  ];
}
