import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/error_view.dart';
import '../providers/chat_providers.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class ChatRoomPage extends ConsumerWidget {
  const ChatRoomPage({super.key, required this.roomId});
  final String roomId;

  Future<void> _send(BuildContext context, WidgetRef ref, String text) async {
    try {
      await ref.read(sendMessageUseCaseProvider).call(roomId, text);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(context.l10n!.messageSendFailed)));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final room = ref.watch(chatRoomProvider(roomId)).valueOrNull;
    final messages = ref.watch(chatMessagesProvider(roomId));

    return Scaffold(
      appBar: AppBar(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(room?.title ?? '', style: const TextStyle(fontSize: 16)),
          if (room != null)
            Text(l!.membersCount(room.memberCount),
                style: const TextStyle(fontSize: 12, color: Colors.white70)),
        ]),
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) =>
                  ErrorView(onRetry: () => ref.invalidate(chatMessagesProvider(roomId))),
              data: (list) => list.isEmpty
                  ? Center(
                      child: Text(l!.noMessagesYet,
                          style: const TextStyle(color: AppColors.textSecondary)))
                  // reverse: true keeps the newest message pinned above the input.
                  : ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: list.length,
                      itemBuilder: (_, i) => MessageBubble(message: list[list.length - 1 - i]),
                    ),
            ),
          ),
          MessageInput(onSend: (text) => _send(context, ref, text)),
        ],
      ),
    );
  }
}
