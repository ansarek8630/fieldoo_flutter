class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.roomId,
    required this.senderName,
    required this.text,
    required this.sentAt,
    required this.isMine,
  });
  final String id;
  final String roomId;
  final String senderName;
  final String text;
  final DateTime sentAt;
  final bool isMine;
}
