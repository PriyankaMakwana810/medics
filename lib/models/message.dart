class Message {
  final String doctorName;
  final String doctorImage;
  final String lastMessage;
  final String time;
  final bool isGroup;
  final bool isRead;

  Message({
    required this.doctorName,
    required this.doctorImage,
    required this.lastMessage,
    required this.time,
    required this.isGroup,
    required this.isRead,
  });
}
