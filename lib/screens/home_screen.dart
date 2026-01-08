import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

enum LayoutMode { mobile, tablet, desktop }

class HomeScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;

  const HomeScreen({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Strategy? _selectedStrategy;
  GridSize? _selectedSize;
  SimulationStep? _selectedStep;

  LayoutMode _getLayoutMode(double width) {
    if (width >= 1100) return LayoutMode.desktop;
    if (width >= 700) return LayoutMode.tablet;
    return LayoutMode.mobile;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final screenWidth = MediaQuery.of(context).size.width;
    final layoutMode = _getLayoutMode(screenWidth);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors.background,
              colors.surface,
              colors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: _buildLayout(layoutMode),
        ),
      ),
    );
  }

  Widget _buildLayout(LayoutMode mode) {
    switch (mode) {
      case LayoutMode.desktop:
        return _buildDesktopLayout();
      case LayoutMode.tablet:
        return _buildTabletLayout();
      case LayoutMode.mobile:
        return _buildMobileLayout();
    }
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          HeaderWidget(
            isDark: widget.isDark,
            onThemeToggle: widget.onThemeToggle,
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: _buildControlPanel(compact: false),
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 2,
                  child: ResultPanel(
                    selectedStrategy: _selectedStrategy,
                    selectedSize: _selectedSize,
                    selectedStep: _selectedStep,
                    isDark: widget.isDark,
                    compact: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          HeaderWidget(
            isDark: widget.isDark,
            onThemeToggle: widget.onThemeToggle,
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: _buildControlPanel(compact: true),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ResultPanel(
                  selectedStrategy: _selectedStrategy,
                  selectedSize: _selectedSize,
                  selectedStep: _selectedStep,
                  isDark: widget.isDark,
                  compact: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeaderWidget(
            isDark: widget.isDark,
            onThemeToggle: widget.onThemeToggle,
          ),
          const SizedBox(height: 24),
          _buildControlPanel(compact: true),
          const SizedBox(height: 20),
          ResultPanel(
            selectedStrategy: _selectedStrategy,
            selectedSize: _selectedSize,
            selectedStep: _selectedStep,
            isDark: widget.isDark,
            compact: true,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildControlPanel({required bool compact}) {
    final colors = AppTheme.of(context).colors;

    return Container(
      padding: EdgeInsets.all(compact ? 16 : 24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SectionTitle(title: '選擇策略', icon: Icons.tune_outlined),
          SizedBox(height: compact ? 12 : 16),
          _buildStrategyGrid(compact),
          SizedBox(height: compact ? 20 : 28),
          const SectionTitle(title: '選擇格數', icon: Icons.grid_on_outlined),
          SizedBox(height: compact ? 12 : 16),
          SizeSelector(
            selectedSize: _selectedSize,
            onSizeSelected: (size) {
              setState(() {
                _selectedSize = size;
              });
            },
            compact: compact,
          ),
          SizedBox(height: compact ? 20 : 28),
          const SectionTitle(title: '模擬次數', icon: Icons.speed_outlined),
          SizedBox(height: compact ? 12 : 16),
          StepSelector(
            selectedStep: _selectedStep,
            onStepSelected: (step) {
              setState(() {
                _selectedStep = step;
              });
            },
            compact: compact,
          ),
        ],
      ),
    );
  }

  Widget _buildStrategyGrid(bool compact) {
    return Wrap(
      spacing: compact ? 8 : 12,
      runSpacing: compact ? 8 : 12,
      alignment: WrapAlignment.center,
      children: StrategyInfo.all.map((info) {
        final isSelected = _selectedStrategy == info.strategy;
        return StrategyCard(
          info: info,
          isSelected: isSelected,
          compact: compact,
          onTap: () {
            setState(() {
              _selectedStrategy = info.strategy;
            });
          },
        );
      }).toList(),
    );
  }
}
