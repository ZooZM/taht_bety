class ChatMessage {
  final String text;
  final bool isUser;
  final String? time;

  const ChatMessage({
    required this.text,
    required this.isUser,
    this.time,
  });
}
