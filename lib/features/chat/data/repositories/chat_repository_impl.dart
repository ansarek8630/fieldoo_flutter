import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_room.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl(this._remote);
  final ChatRemoteDataSource _remote;

  @override
  Future<List<ChatRoom>> getRooms() => _remote.fetchRooms();

  @override
  Stream<List<ChatMessage>> watchMessages(String roomId) => _remote.messagesStream(roomId);

  @override
  Future<void> sendMessage(String roomId, String text) => _remote.postMessage(roomId, text);
}
