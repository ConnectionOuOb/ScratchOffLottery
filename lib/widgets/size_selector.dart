import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/theme.dart';

class SizeSelector extends StatelessWidget {
  final GridSize? selectedSize;
  final ValueChanged<GridSize> onSizeSelected;
  final bool compact;

  const SizeSelector({
    super.key,
    required this.selectedSize,
    required this.onSizeSelected,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: compact ? 8 : 12,
      runSpacing: compact ? 8 : 12,
      children: GridSizeInfo.all.map((info) {
        final isSelected = selectedSize == info.size;
        return _SizeButton(
          info: info,
          isSelected: isSelected,
          compact: compact,
          onTap: () => onSizeSelected(info.size),
        );
      }).toList(),
    );
  }
}

class _SizeButton extends StatelessWidget {
  final GridSizeInfo info;
  final bool isSelected;
  final bool compact;
  final VoidCallback onTap;

  const _SizeButton({
    required this.info,
    required this.isSelected,
    required this.compact,
    required this.onTap,
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
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 16 : 24,
            vertical: compact ? 10 : 14,
          ),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Color(0xFF58A6FF), Color(0xFF79C0FF)],
                  )
                : null,
            color: isSelected ? null : colors.surfaceVariant,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? Colors.transparent : colors.border,
            ),
          ),
          child: Text(
            info.label,
            style: TextStyle(
              fontSize: compact ? 13 : 15,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : colors.textSecondary,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}

