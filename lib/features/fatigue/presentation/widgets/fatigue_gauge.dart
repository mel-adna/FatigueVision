import 'package:fatigue_vision/features/fatigue/presentation/fatigue_controller.dart';
import 'package:flutter/material.dart';

class FatigueGauge extends StatelessWidget {
  const FatigueGauge({
    required this.earValue,
    required this.level,
    super.key,
  });

  final double earValue;
  final FatigueLevel level;

  @override
  Widget build(BuildContext context) {
    // Determine color based on level
    final color = level == FatigueLevel.drowsy
        ? Colors.redAccent
        : Colors.greenAccent;

    // Normalize EAR for display (Typical range 0.15 - 0.35)
    // 0.22 is threshold.
    // 0.15 -> 0% (Closed)
    // 0.35 -> 100% (Open)
    var progress = (earValue - 0.15) / (0.35 - 0.15);
    progress = progress.clamp(0.0, 1.0);

    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 12,
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeCap: StrokeCap.round,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'EAR',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: Colors.white70),
                ),
                Text(
                  earValue.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
