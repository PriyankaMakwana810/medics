import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medics/config/app_assets.dart';
import 'package:medics/views/home/home_controller.dart';
import 'package:medics/views/home/tabs/dashboard_Tab.dart';
import 'package:medics/views/home/tabs/messages_tab.dart';
import 'package:medics/views/home/tabs/profile_tab.dart';
import 'package:medics/views/home/tabs/schedule_tab.dart';

import '../../styles/color_constants.dart';

class HomeView extends GetView<HomeController> {
  final List<Widget> _pages = [
    DashboardView(),
    MessagesView(),
    ScheduleView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (HomeController controller) {
          return Scaffold(
              backgroundColor: whiteColor,
              body: IndexedStack(
                children: [
                  _pages[controller.currentIndex],
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                // selectedItemColor: colorPrimary,
                // unselectedItemColor: colorGray,
                backgroundColor: whiteColor,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                currentIndex: controller.currentIndex,
                onTap: (index) {
                  controller.currentIndex = index;
                  controller.update();
                },
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(SVGAssets.home),
                    activeIcon: SvgPicture.asset(SVGAssets.home_selected),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(SVGAssets.messages),
                    activeIcon: SvgPicture.asset(SVGAssets.messages_selected),
                    label: 'Chat',
                  ),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(SVGAssets.schedule),
                      activeIcon: SvgPicture.asset(SVGAssets.schedule_selected),
                      label: 'Schedule'),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(SVGAssets.profile),
                    activeIcon: SvgPicture.asset(SVGAssets.profile_selected),
                    label: 'Profile',
                  ),
                ],
              ));
        });
  }
}
