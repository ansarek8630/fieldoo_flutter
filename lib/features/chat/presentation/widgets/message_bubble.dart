import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/chat_message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final mine = message.isMine;
    final locale = Localizations.localeOf(context).toString();
    const r = Radius.circular(16);
    const tail = Radius.circular(4);

    return Align(
      alignment: mine ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: mine ? AppColors.primary : AppColors.white,
          border: mine ? null : Border.all(color: AppColors.outline),
          borderRadius: BorderRadiusDirectional.only(
            topStart: r,
            topEnd: r,
            bottomStart: mine ? r : tail,
            bottomEnd: mine ? tail : r,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!mine)
              Text(message.senderName,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
            Text(message.text,
                style: TextStyle(color: mine ? AppColors.white : AppColors.textPrimary)),
            const SizedBox(height: 2),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(DateFormat.jm(locale).format(message.sentAt),
                  style: TextStyle(
                      fontSize: 10, color: mine ? Colors.white70 : AppColors.textSecondary)),
            ),
          ],
        ),
      ),
    );
  }
}
