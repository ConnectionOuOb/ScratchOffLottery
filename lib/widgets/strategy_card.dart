import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/theme.dart';

class StrategyCard extends StatelessWidget {
  final StrategyInfo info;
  final bool isSelected;
  final VoidCallback onTap;
  final bool compact;

  const StrategyCard({
    super.key,
    required this.info,
    required this.isSelected,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colors = theme.colors;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: compact ? 140 : 160,
          padding: EdgeInsets.all(compact ? 12 : 16),
          decoration: BoxDecoration(
            color: isSelected
                ? info.color.withOpacity(theme.isDark ? 0.15 : 0.1)
                : colors.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? info.color : colors.border,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: info.color.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                info.icon,
                color: isSelected ? info.color : colors.textMuted,
                size: compact ? 24 : 28,
              ),
              SizedBox(height: compact ? 8 : 12),
              Text(
                info.label,
                style: TextStyle(
                  fontSize: compact ? 14 : 15,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? info.color : colors.textSecondary,
                ),
              ),
              if (!compact) ...[
                const SizedBox(height: 4),
                Text(
                  info.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.textMuted,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

