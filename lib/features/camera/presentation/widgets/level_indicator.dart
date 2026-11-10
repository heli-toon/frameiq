import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frameiq/features/camera/providers/camera_sensor_provider.dart';

class LevelIndicator extends ConsumerWidget {
  const LevelIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensor = ref.watch(cameraSensorProvider);

    if (!sensor.isUpright) {
      // When phone is placed flat on a surface, no horizon line to level
      return const SizedBox.shrink();
    }

    const levelColor = Color(0xFF10B981); // Emerald-500
    final normalColor = Colors.white.withValues(alpha: 0.50);

    final isLevel = sensor.isLevel;
    final rollDelta = sensor.rollDegrees;

    return IgnorePointer(
      child: Center(
        child: SizedBox(
          width: 160,
          height: 160,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Minimalist center reticle dot
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: isLevel ? 7 : 5,
                height: isLevel ? 7 : 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isLevel ? levelColor : normalColor,
                ),
              ),

              // Rotating Horizon Bar counter-rotates with phone tilt to stay parallel with the earth horizon
              AnimatedRotation(
                turns: -rollDelta / 360.0,
                duration: const Duration(milliseconds: 70),
                curve: Curves.linear,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left wing
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: isLevel ? 54 : 48,
                      height: isLevel ? 2.2 : 1.5,
                      decoration: BoxDecoration(
                        color: isLevel ? levelColor : normalColor,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                    const SizedBox(width: 44),
                    // Right wing
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: isLevel ? 54 : 48,
                      height: isLevel ? 2.2 : 1.5,
                      decoration: BoxDecoration(
                        color: isLevel ? levelColor : normalColor,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ],
                ),
              ),

              // Live degree deviation badge (visible when slightly off-level)
              if (!isLevel && rollDelta.abs() >= 1.2 && rollDelta.abs() < 15.0)
                Positioned(
                  bottom: 50,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${rollDelta.abs().toStringAsFixed(1)}°',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
