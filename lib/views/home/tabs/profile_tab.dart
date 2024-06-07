import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medics/config/app_assets.dart';
import 'package:medics/custom_widgets/custom_dialogs.dart';
import 'package:medics/styles/color_constants.dart';

import '../home_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF52D1C6), Color(0xFF30ADA2)]),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildHeader(context),
            // Spacer(),
            // _buildUserInfo(context),
            Expanded(child: _buildMenuList(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 30),
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(AppAssets.profileImage),
          ),
          const SizedBox(height: 10),
          const Text(
            "Priyanka Makwana",
            // controller.userName.value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildStatItem('Heart rate', '215bpm', SVGAssets.icon_heartbeat),
              Container(
                  height: 50, child: VerticalDivider(color: Colors.white)),
              _buildStatItem('Calories', '756cal', SVGAssets.icon_fire),
              Container(
                  height: 50, child: VerticalDivider(color: Colors.white)),
              _buildStatItem('Weight', '103lbs', SVGAssets.icon_barbell),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String iconPath) {
    return Column(
      children: [
        SvgPicture.asset(iconPath),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuList(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 10),
            _buildMenuItem(Icons.favorite, 'My Saved', () {}),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider()),
            // Divider(),
            _buildMenuItem(Icons.calendar_today, 'Appointment', () {}),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider()),
            _buildMenuItem(Icons.payment, 'Payment Method', () {}),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider()),
            _buildMenuItem(Icons.help, 'FAQs', () {}),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider()),
            _buildLogoutMenuItem(Icons.logout, 'Logout', () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LogoutDialog(onPressed: controller.onLogoutTap);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: CircleAvatar(
        radius: 26,
        backgroundColor: colorSecondary,
        child: Icon(
          icon,
          color: colorPrimary,
        ),
      ),
      title: Text(label,
          textAlign: TextAlign.start,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Color(0XFF555555),
        size: 24,
      ),
      onTap: onTap,
    );
  }

  Widget _buildLogoutMenuItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: CircleAvatar(
        radius: 26,
        backgroundColor: colorSecondary,
        child: Icon(
          icon,
          color: Colors.red,
        ),
      ),
      title: Text(label,
          textAlign: TextAlign.start,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.red)),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Color(0XFF555555),
        size: 24,
      ),
      onTap: onTap,
    );
  }
}
