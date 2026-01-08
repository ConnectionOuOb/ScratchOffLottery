enum GridSize { small, medium, large }

class GridSizeInfo {
  final GridSize size;
  final String label;
  final int width;
  final int height;

  const GridSizeInfo({
    required this.size,
    required this.label,
    required this.width,
    required this.height,
  });

  String get assetKey => '${width}x$height';

  static const List<GridSizeInfo> all = [
    GridSizeInfo(size: GridSize.small, label: '8 × 5', width: 8, height: 5),
    GridSizeInfo(size: GridSize.medium, label: '10 × 12', width: 10, height: 12),
    GridSizeInfo(size: GridSize.large, label: '16 × 10', width: 16, height: 10),
  ];
}

