import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/core/widgets/glass_surface.dart';
import 'package:frameiq/features/camera/application/camera_controller.dart';

class RecommendationHeader extends ConsumerWidget {
  const RecommendationHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zoomLevel = ref.watch(zoomLevelProvider);

    return GlassSurface.pill(
      blurSigma: 16,
      surfaceColor: Colors.black.withValues(alpha: 0.55),
      borderColor: Colors.white.withValues(alpha: 0.16),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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
            margin: const EdgeInsets.symmetric(horizontal: 14),
          ),

          // Tilt
          const Icon(
            LucideIcons.compass,
            size: 14,
            color: Colors.white70,
          ),
          const SizedBox(width: 5),
          const Text(
            'Level',
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
            margin: const EdgeInsets.symmetric(horizontal: 14),
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
    );
  }
}
