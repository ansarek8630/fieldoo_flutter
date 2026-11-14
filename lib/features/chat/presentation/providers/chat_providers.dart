import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/chat_remote_data_source.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_room.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/get_chat_rooms_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/watch_messages_usecase.dart';

// DI graph: datasource -> repository -> usecases
final chatRemoteDataSourceProvider =
    Provider<ChatRemoteDataSource>((ref) => FakeChatRemoteDataSource());
final chatRepositoryProvider = Provider<ChatRepository>(
    (ref) => ChatRepositoryImpl(ref.watch(chatRemoteDataSourceProvider)));
final getChatRoomsUseCaseProvider = Provider<GetChatRoomsUseCase>(
    (ref) => GetChatRoomsUseCase(ref.watch(chatRepositoryProvider)));
final watchMessagesUseCaseProvider = Provider<WatchMessagesUseCase>(
    (ref) => WatchMessagesUseCase(ref.watch(chatRepositoryProvider)));
final sendMessageUseCaseProvider = Provider<SendMessageUseCase>(
    (ref) => SendMessageUseCase(ref.watch(chatRepositoryProvider)));

final chatRoomsProvider = FutureProvider.autoDispose<List<ChatRoom>>(
    (ref) => ref.watch(getChatRoomsUseCaseProvider).call());

/// One room, resolved from the rooms list (null if it does not exist).
final chatRoomProvider = FutureProvider.autoDispose.family<ChatRoom?, String>((ref, id) async {
  final rooms = await ref.watch(chatRoomsProvider.future);
  for (final r in rooms) {
    if (r.id == id) return r;
  }
  return null;
});

/// Live messages of a room, oldest first.
final chatMessagesProvider = StreamProvider.autoDispose.family<List<ChatMessage>, String>(
    (ref, roomId) => ref.watch(watchMessagesUseCaseProvider).call(roomId));
