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
