import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/extensions/context_x.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/open_match.dart';
import 'skill_level_x.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({super.key, required this.match, required this.isJoining, required this.onJoin});
  final OpenMatch match;
  final bool isJoining;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final text = Theme.of(context).textTheme;
    final when = '${DateFormat.MMMEd(locale).format(match.dateTime)} · '
        '${DateFormat.j(locale).format(match.dateTime)}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              _Tag(match.format, filled: true),
              const SizedBox(width: AppSpacing.sm),
              _Tag(match.skill.label(context)),
              const Spacer(),
              Text(l!.hostedBy(match.hostName),
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ]),
            const SizedBox(height: AppSpacing.md),
            Text(match.turfName,
                style: text.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: AppSpacing.xs),
            _InfoRow(Icons.location_on_outlined, match.area),
            const SizedBox(height: AppSpacing.xs),
            _InfoRow(Icons.schedule, when),
            const SizedBox(height: AppSpacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: match.playersJoined / match.maxPlayers,
                minHeight: 8,
                backgroundColor: AppColors.outline,
                color: match.isFull ? AppColors.booked : AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(children: [
              Text(l.playersCount(match.playersJoined, match.maxPlayers),
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const Spacer(),
              if (!match.isFull)
                Text(l.spotsLeft(match.spotsLeft),
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ]),
            const SizedBox(height: AppSpacing.md),
            Row(children: [
              Text(l.perPlayer(match.pricePerPlayer),
                  style: text.titleSmall
                      ?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w800)),
              const Spacer(),
              _JoinButton(match: match, isJoining: isJoining, onJoin: onJoin),
            ]),
          ],
        ),
      ),
    );
  }
}

class _JoinButton extends StatelessWidget {
  const _JoinButton({required this.match, required this.isJoining, required this.onJoin});
  final OpenMatch match;
  final bool isJoining;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    // The global theme uses an infinite-width minimum; override it inside a Row.
    final style = FilledButton.styleFrom(minimumSize: const Size(110, 44));
    if (match.hasJoined) {
      return FilledButton.icon(
          style: style, onPressed: null, icon: const Icon(Icons.check), label: Text(l!.joined));
    }
    if (match.isFull) {
      return FilledButton(style: style, onPressed: null, child: Text(l!.matchFull));
    }
    return FilledButton(
      style: style,
      onPressed: isJoining ? null : onJoin,
      child: isJoining
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
          : Text(l!.join),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label, {this.filled = false});
  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : Colors.transparent,
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: filled ? AppColors.white : AppColors.primary)),
      );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.icon, this.text);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 6),
        Expanded(child: Text(text, style: const TextStyle(color: AppColors.textSecondary))),
      ]);
}
