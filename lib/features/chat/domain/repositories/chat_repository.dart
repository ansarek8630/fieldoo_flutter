import '../entities/chat_message.dart';
import '../entities/chat_room.dart';

abstract interface class ChatRepository {
  Future<List<ChatRoom>> getRooms();
  Stream<List<ChatMessage>> watchMessages(String roomId);
  Future<void> sendMessage(String roomId, String text);
}
