import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../styles/color_constants.dart';
import '../home_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      backgroundColor: colorPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              _buildUserInfo(context),
              _buildMenuList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal, Colors.tealAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/profile_picture.jpg'),
          ),
          SizedBox(height: 10),
          Text(
            "Priyanka Makwana",
            // controller.userName.value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Heart rate', '215bpm'),
              _buildStatItem('Calories', '756cal'),
              _buildStatItem('Weight', '103lbs'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          // Add any additional user information here
        ],
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildMenuItem(Icons.favorite, 'My Saved', () {}),
          _buildMenuItem(Icons.calendar_today, 'Appointment', () {}),
          _buildMenuItem(Icons.payment, 'Payment Method', () {}),
          _buildMenuItem(Icons.help, 'FAQs', () {}),
          _buildMenuItem(Icons.logout, 'Logout', () {}),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(label),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
      onTap: onTap,
    );
  }
}
