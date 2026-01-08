import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'screens/screens.dart';

void main() {
  runApp(const LotteryApp());
}

class LotteryApp extends StatefulWidget {
  const LotteryApp({super.key});

  @override
  State<LotteryApp> createState() => _LotteryAppState();
}

class _LotteryAppState extends State<LotteryApp> {
  bool _isDark = true;

  void _toggleTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = _isDark ? AppColors.dark : AppColors.light;

    return AppTheme(
      colors: colors,
      isDark: _isDark,
      child: MaterialApp(
        title: '刮刮樂策略分析',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.buildThemeData(_isDark),
        home: HomeScreen(
          isDark: _isDark,
          onThemeToggle: _toggleTheme,
        ),
      ),
    );
  }
}
