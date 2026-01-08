import 'package:flutter/material.dart';
import '../theme/theme.dart';

class HeaderWidget extends StatelessWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;

  const HeaderWidget({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colors = theme.colors;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF58A6FF), Color(0xFFBC8CFF)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.confirmation_number_outlined,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '刮刮樂策略分析',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '視覺化熱區分析工具',
                style: TextStyle(
                  fontSize: 13,
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
        ),
        _buildThemeToggle(colors),
      ],
    );
  }

  Widget _buildThemeToggle(AppColors colors) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onThemeToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.border),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: animation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              key: ValueKey(isDark),
              color: colors.textSecondary,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

