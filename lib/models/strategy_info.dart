import 'package:flutter/material.dart';

enum Strategy { normal, newbie, veteran, mix }

class StrategyInfo {
  final Strategy strategy;
  final String label;
  final String description;
  final IconData icon;
  final Color color;

  const StrategyInfo({
    required this.strategy,
    required this.label,
    required this.description,
    required this.icon,
    required this.color,
  });

  String get assetKey {
    switch (strategy) {
      case Strategy.normal:
        return 'normal';
      case Strategy.newbie:
        return 'new';
      case Strategy.veteran:
        return 'old';
      case Strategy.mix:
        return 'mix';
    }
  }

  static const List<StrategyInfo> all = [
    StrategyInfo(
      strategy: Strategy.normal,
      label: '常態分佈',
      description: '標準的機率分佈模式',
      icon: Icons.analytics_outlined,
      color: Color(0xFF58A6FF),
    ),
    StrategyInfo(
      strategy: Strategy.newbie,
      label: '新手較多',
      description: '適合新玩家的熱區分析',
      icon: Icons.emoji_people_outlined,
      color: Color(0xFF3FB950),
    ),
    StrategyInfo(
      strategy: Strategy.veteran,
      label: '老手較多',
      description: '資深玩家偏好的區域',
      icon: Icons.psychology_outlined,
      color: Color(0xFFF78166),
    ),
    StrategyInfo(
      strategy: Strategy.mix,
      label: '混合模式',
      description: '新手與老手各半的綜合分析',
      icon: Icons.group_outlined,
      color: Color(0xFFBC8CFF),
    ),
  ];
}

