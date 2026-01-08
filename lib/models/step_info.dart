enum SimulationStep { step100, step10000, step1000000 }

class StepInfo {
  final SimulationStep step;
  final String label;
  final int value;
  final String description;

  const StepInfo({
    required this.step,
    required this.label,
    required this.value,
    required this.description,
  });

  String get assetKey => value.toString();

  static const List<StepInfo> all = [
    StepInfo(
      step: SimulationStep.step100,
      label: '100',
      value: 100,
      description: '快速預覽',
    ),
    StepInfo(
      step: SimulationStep.step10000,
      label: '10K',
      value: 10000,
      description: '中等精度',
    ),
    StepInfo(
      step: SimulationStep.step1000000,
      label: '1M',
      value: 1000000,
      description: '高精度',
    ),
  ];
}

