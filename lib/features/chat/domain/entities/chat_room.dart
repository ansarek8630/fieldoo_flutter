class ChatRoom {
  const ChatRoom({
    required this.id,
    required this.title,
    required this.memberCount,
    this.lastMessage = '',
    this.lastMessageAt,
    this.unreadCount = 0,
  });
  final String id;
  final String title;
  final int memberCount;
  final String lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;
}
