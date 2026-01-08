import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ImageViewer extends StatefulWidget {
  final String imagePath;
  final String title;
  final Color accentColor;

  const ImageViewer({
    super.key,
    required this.imagePath,
    required this.title,
    required this.accentColor,
  });

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer>
    with SingleTickerProviderStateMixin {
  final TransformationController _transformController =
      TransformationController();
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;

  double _currentScale = 1.0;
  static const double _minScale = 0.5;
  static const double _maxScale = 4.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _transformController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onScaleChanged() {
    final scale = _transformController.value.getMaxScaleOnAxis();
    if (scale != _currentScale) {
      setState(() {
        _currentScale = scale;
      });
    }
  }

  void _zoomIn() {
    final newScale = (_currentScale * 1.5).clamp(_minScale, _maxScale);
    _animateToScale(newScale);
  }

  void _zoomOut() {
    final newScale = (_currentScale / 1.5).clamp(_minScale, _maxScale);
    _animateToScale(newScale);
  }

  void _resetZoom() {
    _animateToScale(1.0);
  }

  void _animateToScale(double targetScale) {
    final currentMatrix = _transformController.value;
    final targetMatrix = Matrix4.identity()..scale(targetScale);

    _animation = Matrix4Tween(
      begin: currentMatrix,
      end: targetMatrix,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animation!.addListener(() {
      _transformController.value = _animation!.value;
    });

    _animationController.forward(from: 0);
    setState(() {
      _currentScale = targetScale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colors = theme.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildToolbar(colors),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.border),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: InteractiveViewer(
                transformationController: _transformController,
                onInteractionEnd: (_) => _onScaleChanged(),
                minScale: _minScale,
                maxScale: _maxScale,
                child: Center(
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildErrorWidget(colors);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToolbar(AppColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colors.border),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.image_outlined, color: widget.accentColor, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _buildZoomControls(colors),
        ],
      ),
    );
  }

  Widget _buildZoomControls(AppColors colors) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ToolButton(
          icon: Icons.remove,
          tooltip: '縮小',
          onTap: _currentScale > _minScale ? _zoomOut : null,
          colors: colors,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '${(_currentScale * 100).round()}%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colors.textMuted,
            ),
          ),
        ),
        _ToolButton(
          icon: Icons.add,
          tooltip: '放大',
          onTap: _currentScale < _maxScale ? _zoomIn : null,
          colors: colors,
        ),
        const SizedBox(width: 8),
        _ToolButton(
          icon: Icons.refresh,
          tooltip: '重置',
          onTap: _resetZoom,
          colors: colors,
        ),
      ],
    );
  }

  Widget _buildErrorWidget(AppColors colors) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          color: Color(0xFFF78166),
          size: 48,
        ),
        const SizedBox(height: 16),
        Text(
          '無法載入圖片',
          style: TextStyle(color: colors.textMuted),
        ),
      ],
    );
  }
}

class _ToolButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;
  final AppColors colors;

  const _ToolButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor:
            isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              size: 18,
              color: isEnabled ? colors.textSecondary : colors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}
