import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/theme.dart';

class StepSelector extends StatelessWidget {
  final SimulationStep? selectedStep;
  final ValueChanged<SimulationStep> onStepSelected;
  final bool compact;

  const StepSelector({
    super.key,
    required this.selectedStep,
    required this.onStepSelected,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: compact ? 8 : 12,
      runSpacing: compact ? 8 : 12,
      alignment: WrapAlignment.center,
      children: StepInfo.all.map((info) {
        final isSelected = selectedStep == info.step;
        return _StepButton(
          info: info,
          isSelected: isSelected,
          compact: compact,
          onTap: () => onStepSelected(info.step),
        );
      }).toList(),
    );
  }
}

class _StepButton extends StatelessWidget {
  final StepInfo info;
  final bool isSelected;
  final bool compact;
  final VoidCallback onTap;

  const _StepButton({
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
            horizontal: compact ? 14 : 20,
            vertical: compact ? 10 : 14,
          ),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    colors: [Color(0xFFBC8CFF), Color(0xFF58A6FF)],
                  )
                : null,
            color: isSelected ? null : colors.surfaceVariant,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? Colors.transparent : colors.border,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                info.label,
                style: TextStyle(
                  fontSize: compact ? 14 : 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : colors.textSecondary,
                ),
              ),
              if (!compact) ...[
                const SizedBox(height: 2),
                Text(
                  info.description,
                  style: TextStyle(
                    fontSize: 10,
                    color: isSelected
                        ? Colors.white.withOpacity(0.8)
                        : colors.textMuted,
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

