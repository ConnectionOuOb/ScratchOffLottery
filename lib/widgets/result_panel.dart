import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/theme.dart';
import 'image_viewer.dart';

class ResultPanel extends StatelessWidget {
  final Strategy? selectedStrategy;
  final GridSize? selectedSize;
  final bool compact;

  const ResultPanel({
    super.key,
    required this.selectedStrategy,
    required this.selectedSize,
    this.compact = false,
  });

  String? get _imagePath {
    if (selectedStrategy == null || selectedSize == null) return null;
    final strategyInfo =
        StrategyInfo.all.firstWhere((s) => s.strategy == selectedStrategy);
    final sizeInfo =
        GridSizeInfo.all.firstWhere((s) => s.size == selectedSize);
    return 'assets/${strategyInfo.assetKey}_${sizeInfo.assetKey}_heatmap.png';
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colors = theme.colors;

    return Container(
      constraints: BoxConstraints(minHeight: compact ? 300 : 400),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: _imagePath != null ? _buildImageViewer() : _buildPlaceholder(colors),
    );
  }

  Widget _buildImageViewer() {
    final strategyInfo =
        StrategyInfo.all.firstWhere((s) => s.strategy == selectedStrategy);
    final sizeInfo =
        GridSizeInfo.all.firstWhere((s) => s.size == selectedSize);

    return ImageViewer(
      key: ValueKey(_imagePath),
      imagePath: _imagePath!,
      title: '${strategyInfo.label} · ${sizeInfo.label} 熱區圖',
      accentColor: strategyInfo.color,
    );
  }

  Widget _buildPlaceholder(AppColors colors) {
    return Container(
      padding: EdgeInsets.all(compact ? 32 : 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(compact ? 16 : 24),
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.touch_app_outlined,
              size: compact ? 36 : 48,
              color: colors.textMuted,
            ),
          ),
          SizedBox(height: compact ? 16 : 24),
          Text(
            '選擇策略與格數',
            style: TextStyle(
              fontSize: compact ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '完成選擇後將顯示對應的熱區分析圖',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: compact ? 12 : 14,
              color: colors.textMuted.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

