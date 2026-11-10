import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/core/widgets/glass_surface.dart';
import 'package:frameiq/features/camera/application/camera_controller.dart';
import 'package:frameiq/features/camera/providers/camera_sensor_provider.dart';

class RecommendationHeader extends ConsumerWidget {
  const RecommendationHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zoomLevel = ref.watch(zoomLevelProvider);
    final sensor = ref.watch(cameraSensorProvider);

    return AnimatedRotation(
      turns: sensor.orientationTurns,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      child: GlassSurface.pill(
        blurSigma: 16,
        surfaceColor: Colors.black.withValues(alpha: 0.55),
        borderColor: Colors.white.withValues(alpha: 0.16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Distance
            const Icon(
              LucideIcons.map_pin,
              size: 14,
              color: Colors.white70,
            ),
            const SizedBox(width: 5),
            const Text(
              '1.5m',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),

            // Hairline separator
            Container(
              height: 12,
              width: 0.8,
              color: Colors.white24,
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),

            // Live Tilt / Level state
            Icon(
              LucideIcons.compass,
              size: 14,
              color: sensor.isLevel ? const Color(0xFF10B981) : Colors.white70,
            ),
            const SizedBox(width: 5),
            Text(
              sensor.isLevel
                  ? 'Level'
                  : '${sensor.rollDegrees.abs().toStringAsFixed(1)}°',
              style: TextStyle(
                color: sensor.isLevel ? const Color(0xFF10B981) : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),

            // Hairline separator
            Container(
              height: 12,
              width: 0.8,
              color: Colors.white24,
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),

            // Zoom
            const Icon(
              LucideIcons.search,
              size: 14,
              color: Colors.white70,
            ),
            const SizedBox(width: 5),
            Text(
              '${zoomLevel.toStringAsFixed(1)}x',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
