import 'package:flutter/material.dart';

class AppColors {
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color border;
  final Color borderHover;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color accent;
  final Color accentLight;

  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.border,
    required this.borderHover,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.accent,
    required this.accentLight,
  });

  static const dark = AppColors(
    background: Color(0xFF0D1117),
    surface: Color(0xFF161B22),
    surfaceVariant: Color(0xFF21262D),
    border: Color(0xFF30363D),
    borderHover: Color(0xFF484F58),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFC9D1D9),
    textMuted: Color(0xFF8B949E),
    accent: Color(0xFF58A6FF),
    accentLight: Color(0xFF79C0FF),
  );

  static const light = AppColors(
    background: Color(0xFFF6F8FA),
    surface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFFF3F4F6),
    border: Color(0xFFD0D7DE),
    borderHover: Color(0xFF8C959F),
    textPrimary: Color(0xFF1F2328),
    textSecondary: Color(0xFF424A53),
    textMuted: Color(0xFF656D76),
    accent: Color(0xFF0969DA),
    accentLight: Color(0xFF54AEFF),
  );
}

class AppTheme extends InheritedWidget {
  final AppColors colors;
  final bool isDark;

  const AppTheme({
    super.key,
    required this.colors,
    required this.isDark,
    required super.child,
  });

  static AppTheme of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(result != null, 'No AppTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) {
    return colors != oldWidget.colors || isDark != oldWidget.isDark;
  }

  static ThemeData buildThemeData(bool isDark) {
    final colors = isDark ? AppColors.dark : AppColors.light;
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: colors.accent,
        onPrimary: Colors.white,
        secondary: colors.accentLight,
        onSecondary: Colors.white,
        error: const Color(0xFFF78166),
        onError: Colors.white,
        surface: colors.surface,
        onSurface: colors.textPrimary,
      ),
      fontFamily: 'Segoe UI',
      useMaterial3: true,
    );
  }
}

