import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/chat_room.dart';

class ChatRoomTile extends StatelessWidget {
  const ChatRoomTile({super.key, required this.room, required this.onTap});
  final ChatRoom room;
  final VoidCallback onTap;

  String _time(BuildContext context, DateTime t) {
    final locale = Localizations.localeOf(context).toString();
    final n = DateTime.now();
    final today = t.year == n.year && t.month == n.month && t.day == n.day;
    return today ? DateFormat.jm(locale).format(t) : DateFormat.MMMd(locale).format(t);
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = room.unreadCount > 0;
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: const CircleAvatar(
        radius: 26,
        backgroundColor: AppColors.primary,
        child: Icon(Icons.groups, color: AppColors.white),
      ),
      title: Text(room.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(
        room.lastMessage.isEmpty ? context.l10n!.membersCount(room.memberCount) : room.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (room.lastMessageAt != null)
            Text(_time(context, room.lastMessageAt!),
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          if (hasUnread) ...[
            const SizedBox(height: 6),
            CircleAvatar(
              radius: 10,
              backgroundColor: AppColors.primary,
              child: Text('${room.unreadCount}',
                  style: const TextStyle(fontSize: 11, color: AppColors.white)),
            ),
          ],
        ],
      ),
    );
  }
}
