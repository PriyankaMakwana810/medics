import 'package:get/get.dart';
import 'package:medics/models/doctor.dart';

import '../../../models/message.dart';

class MessageController extends GetxController {
  var messages = <Message>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }

  void fetchMessages() {
    // Dummy data for messages
    messages.value = [
      Message(
        doctorName: 'Dr. Marcus Horiz',
        doctorImage: 'assets/images/dr_marcus.png',
        lastMessage: 'I don\'t have any fever, but headache...',
        time: '10:24',
        isGroup: false,
        isRead: false,
      ),
      Message(
        doctorName: 'Dr. Stefi Jessi',
        doctorImage: 'assets/images/dr_stefi.png',
        lastMessage: 'Hello, How can I help you?',
        time: '09:04',
        isGroup: false,
        isRead: true,
      ),
      Message(
        doctorName: 'Dr. Maria Elena',
        doctorImage: 'assets/images/dr_maria.png',
        lastMessage: 'Do you have fever?',
        time: '08:57',
        isGroup: true,
        isRead: true,
      ),
    ];
  }

  List<Message> getAllMessages() {
    return messages;
  }

  List<Message> getGroupMessages() {
    return messages.where((m) => m.isGroup).toList();
  }

  List<Message> getPrivateMessages() {
    return messages.where((m) => !m.isGroup).toList();
  }
  /*Doctor getDoctorData(String docName){
    return messages.firstWhere((m) => m.doctorName == docName);
  }*/
}
