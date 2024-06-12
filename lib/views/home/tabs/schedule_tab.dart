import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medics/styles/color_constants.dart';
import 'package:medics/styles/text_style.dart';
import 'package:medics/views/home/tabs/schedule_controller.dart';

import '../../../config/app_assets.dart';
import '../../../models/schedule.dart';

class ScheduleView extends StatelessWidget {
  final ScheduleController _scheduleController = Get.put(ScheduleController());

  ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Schedule', style: AppTextStyles.heading1),
                SvgPicture.asset(SVGAssets.notification_icon),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              // padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: colorSecondary),
              child: const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                indicatorColor: Colors.transparent,
                unselectedLabelColor: color5555,
                labelColor: whiteColor,
                indicator: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                tabs: [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Canceled'),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: TabBarView(children: [
            _buildScheduleList(_scheduleController.getUpcomingSchedules()),
            _buildScheduleList(_scheduleController.getCompletedSchedules()),
            _buildScheduleList(_scheduleController.getCanceledSchedules()),
          ]),
        ),
      ),
    );
  }

  Widget _buildScheduleList(List<Schedule> schedules) {
    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        return _buildScheduleCard(schedule);
      },
    );
  }

  Widget _buildScheduleCard(Schedule schedule) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorSecondary, width: 1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      schedule.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      schedule.designation,
                      style: const TextStyle(
                        fontSize: 14,
                        color: colorGray,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(schedule.image),
                  radius: 25,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14, color: color5555),
                    const SizedBox(width: 5),
                    Text(
                      schedule.date,
                      style: const TextStyle(fontSize: 14, color: color5555),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: color5555),
                    const SizedBox(width: 5),
                    Text(
                      schedule.time,
                      style: const TextStyle(fontSize: 14, color: color5555),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.circle,
                        size: 10,
                        color: schedule.status == 'Confirmed'
                            ? Colors.green
                            : color5555),
                    const SizedBox(width: 5),
                    Text(
                      schedule.status == 'Completed'
                          ? 'Completed'
                          : 'Confirmed',
                      style: TextStyle(
                          fontSize: 14,
                          color: schedule.status == 'Confirmed'
                              ? Colors.green
                              : color5555),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      foregroundColor: color5555,
                      backgroundColor: colorSecondary,
                      elevation: 0,
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      foregroundColor: Colors.white,
                      backgroundColor: colorPrimary,
                      elevation: 0,
                    ),
                    child: const Text('Reschedule'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
