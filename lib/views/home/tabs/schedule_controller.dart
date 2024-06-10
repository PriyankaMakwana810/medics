import 'package:get/get.dart';
import 'package:medics/controller/base_controller.dart';
import 'package:medics/models/schedule.dart';

class ScheduleController extends BaseController {
  var selectedTabIndex = 0.obs;
  var schedules = <Schedule>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSchedules();
  }

  void fetchSchedules() {
    // Dummy data for schedules
    schedules.value = [
      Schedule(
        name: 'Dr. Marcus Horizon',
        designation: 'Cardiologist',
        image: 'assets/images/dr_marcus.png',
        date: '26/06/2022',
        time: '10:30 AM',
        status: 'Confirmed',
      ),
      Schedule(
        name: 'Dr. Alysa Hana',
        designation: 'Psychiatrist',
        image: 'assets/images/dr_diandra.png',
        date: '28/06/2022',
        time: '2:00 PM',
        status: 'Completed',
      ),
      Schedule(
        name: 'Dr. Stefi Jessi',
        designation: 'Orthopedist',
        image: 'assets/images/dr_stefi.png',
        date: '29/06/2022',
        time: '1:00 PM',
        status: 'Canceled',
      ),
    ];
  }

  List<Schedule> getUpcomingSchedules() {
    return schedules.where((s) => s.status == 'Confirmed').toList();
  }

  List<Schedule> getCompletedSchedules() {
    return schedules.where((s) => s.status == 'Completed').toList();
  }

  List<Schedule> getCanceledSchedules() {
    return schedules.where((s) => s.status == 'Canceled').toList();
  }

  List<Schedule> get filteredSchedules {
    switch (selectedTabIndex.value) {
      case 1:
        return schedules.where((s) => s.status == 'Completed').toList();
      case 2:
        return schedules.where((s) => s.status == 'Canceled').toList();
      case 0:
      default:
        return schedules.where((s) => s.status == 'Confirmed').toList();
    }
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
