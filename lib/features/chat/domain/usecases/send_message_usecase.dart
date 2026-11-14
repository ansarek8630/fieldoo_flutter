import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  const SendMessageUseCase(this._repo);
  final ChatRepository _repo;

  /// Blank messages are ignored.
  Future<void> call(String roomId, String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    await _repo.sendMessage(roomId, trimmed);
  }
}
