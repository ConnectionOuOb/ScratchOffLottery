import 'package:flutter/material.dart';
import '../theme/theme.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;

    return Row(
      children: [
        Icon(icon, color: colors.accent, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}

