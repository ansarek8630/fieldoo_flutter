import 'dart:async';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_room.dart';

abstract interface class ChatRemoteDataSource {
  Future<List<ChatRoom>> fetchRooms();
  Stream<List<ChatMessage>> messagesStream(String roomId);
  Future<void> postMessage(String roomId, String text);
}

/// In-memory fake with a live stream and a simulated teammate reply.
class FakeChatRemoteDataSource implements ChatRemoteDataSource {
  FakeChatRemoteDataSource() {
    final n = DateTime.now();
    _messages['c1'] = [
      ChatMessage(id: 'a1', roomId: 'c1', senderName: 'Ahmed', text: 'Who is bringing the bibs?', sentAt: n.subtract(const Duration(minutes: 42)), isMine: false),
      ChatMessage(id: 'a2', roomId: 'c1', senderName: 'Sara', text: 'I have them 👍', sentAt: n.subtract(const Duration(minutes: 40)), isMine: false),
      ChatMessage(id: 'a3', roomId: 'c1', senderName: 'You', text: 'Great, see you at 9!', sentAt: n.subtract(const Duration(minutes: 35)), isMine: true),
    ];
    _messages['c2'] = [
      ChatMessage(id: 'b1', roomId: 'c2', senderName: 'Omar', text: 'Parking is free after 8pm.', sentAt: n.subtract(const Duration(days: 1)), isMine: false),
    ];
    _unread['c1'] = 2;
    _unread['c2'] = 1;
  }

  final _rooms = const [
    ChatRoom(id: 'c1', title: 'Al Barsha Arena · 5v5', memberCount: 10),
    ChatRoom(id: 'c2', title: 'Marina Kickoff · 5v5', memberCount: 8),
    ChatRoom(id: 'c3', title: 'Green Park Turf · 7v7', memberCount: 14),
  ];
  final Map<String, List<ChatMessage>> _messages = {};
  final Map<String, int> _unread = {};
  final Map<String, StreamController<List<ChatMessage>>> _controllers = {};
  static const _replies = ['Sounds good!', 'On my way 🚗', 'Count me in ⚽', 'See you there'];
  var _counter = 0;

  StreamController<List<ChatMessage>> _controller(String id) =>
      _controllers.putIfAbsent(id, () => StreamController.broadcast());

  @override
  Future<List<ChatRoom>> fetchRooms() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return [
      for (final r in _rooms)
        ChatRoom(
          id: r.id,
          title: r.title,
          memberCount: r.memberCount,
          lastMessage: (_messages[r.id]?.isNotEmpty ?? false) ? _messages[r.id]!.last.text : '',
          lastMessageAt: (_messages[r.id]?.isNotEmpty ?? false) ? _messages[r.id]!.last.sentAt : null,
          unreadCount: _unread[r.id] ?? 0,
        ),
    ];
  }

  @override
  Stream<List<ChatMessage>> messagesStream(String roomId) async* {
    _unread[roomId] = 0; // opening the room marks it as read
    yield List.unmodifiable(_messages[roomId] ?? const []);
    yield* _controller(roomId).stream;
  }

  void _emit(String roomId) =>
      _controller(roomId).add(List.unmodifiable(_messages[roomId] ?? const []));

  @override
  Future<void> postMessage(String roomId, String text) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    (_messages[roomId] ??= []).add(ChatMessage(
        id: 'm${_counter++}', roomId: roomId, senderName: 'You', text: text, sentAt: DateTime.now(), isMine: true));
    _emit(roomId);

    // Simulated teammate reply so the demo feels alive.
    Future<void>.delayed(const Duration(milliseconds: 1500), () {
      _messages[roomId]!.add(ChatMessage(
          id: 'm${_counter++}', roomId: roomId, senderName: 'Ahmed',
          text: _replies[_counter % _replies.length], sentAt: DateTime.now(), isMine: false));
      _emit(roomId);
    });
  }
}
