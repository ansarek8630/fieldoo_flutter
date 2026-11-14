import '../entities/chat_room.dart';
import '../repositories/chat_repository.dart';

class GetChatRoomsUseCase {
  const GetChatRoomsUseCase(this._repo);
  final ChatRepository _repo;

  /// Most recently active first.
  Future<List<ChatRoom>> call() async {
    final rooms = await _repo.getRooms();
    final epoch = DateTime.fromMillisecondsSinceEpoch(0);
    return [...rooms]..sort((a, b) =>
        (b.lastMessageAt ?? epoch).compareTo(a.lastMessageAt ?? epoch));
  }
}
