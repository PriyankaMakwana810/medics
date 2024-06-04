import 'package:flutter/material.dart';

import '../../../styles/color_constants.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Text('Schedules'),
      ),
    );
  }
}
