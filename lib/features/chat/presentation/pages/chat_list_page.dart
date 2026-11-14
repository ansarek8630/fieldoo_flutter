import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/language_toggle.dart';
import '../providers/chat_providers.dart';
import '../widgets/chat_room_tile.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final rooms = ref.watch(chatRoomsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l!.chatsTitle),
        actions: const [LanguageToggle(color: AppColors.white)],
      ),
      body: rooms.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => ErrorView(onRetry: () => ref.invalidate(chatRoomsProvider)),
        data: (list) => list.isEmpty
            ? Center(child: Text(l.noChats))
            : RefreshIndicator(
                onRefresh: () async => ref.invalidate(chatRoomsProvider),
                child: ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const Divider(height: 1, indent: 80),
                  itemBuilder: (_, i) => ChatRoomTile(
                    room: list[i],
                    onTap: () async {
                      await context.push('/chats/${list[i].id}');
                      // Refresh last message / unread badge after leaving the room.
                      ref.invalidate(chatRoomsProvider);
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
