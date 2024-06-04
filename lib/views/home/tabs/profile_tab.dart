import 'package:flutter/material.dart';

import '../../../styles/color_constants.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
