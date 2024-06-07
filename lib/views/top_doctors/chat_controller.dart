import 'package:get/get.dart';

class ChatController extends GetxController {
  var messages = <ChatMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    messages.addAll([
      ChatMessage(
        sender: "Dr. Marcus Horizon",
        message: "Hello, How can I help you?",
        isSentByMe: false,
        timestamp: "10 min ago",
      ),
      ChatMessage(
        sender: "Me",
        message:
            "I have been suffering from headache and cold for 3 days. I took 2 tablets of dolo, but still in pain.",
        isSentByMe: true,
        timestamp: "9 min ago",
      ),
      ChatMessage(
        sender: "Dr. Marcus Horizon",
        message: "Ok, Do you have fever? Is the headache severe?",
        isSentByMe: false,
        timestamp: "5 min ago",
      ),
      ChatMessage(
        sender: "Me",
        message: "I don't have any fever, but the headache is painful.",
        isSentByMe: true,
        timestamp: "4 min ago",
      ),
    ]);
  }

  void sendMessage(String message) {
    messages.add(ChatMessage(
      sender: "Me",
      message: message,
      isSentByMe: true,
      timestamp: "Just now",
    ));
    addReply();
  }
  void addReply(){
    messages.add(ChatMessage(
      sender: "Me",
      message: 'This is static respose after adding message.',
      isSentByMe: false,
      timestamp: "Just now",
    ));
  }
}


class ChatMessage {
  final String sender;
  final String message;
  final bool isSentByMe;
  final String timestamp;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.isSentByMe,
    required this.timestamp,
  });
}
