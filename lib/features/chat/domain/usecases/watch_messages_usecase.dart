import '../entities/chat_message.dart';
import '../repositories/chat_repository.dart';

class WatchMessagesUseCase {
  const WatchMessagesUseCase(this._repo);
  final ChatRepository _repo;
  Stream<List<ChatMessage>> call(String roomId) => _repo.watchMessages(roomId);
}
