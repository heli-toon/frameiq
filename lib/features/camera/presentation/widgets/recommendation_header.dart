import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frameiq/features/camera/application/camera_controller.dart';

class RecommendationHeader extends ConsumerWidget {
  const RecommendationHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In a real app, we would get these values from the selected overlay or settings
    final zoomLevel = ref.watch(zoomLevelProvider);
    // For now, we'll show static recommendations
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Distance icon and text
            const Icon(
              LucideIcons.mapPin,
              size: 16,
              color: Colors.white70,
            ),
            const SizedBox(width: 4),
            const Text(
              '1.5m',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          const SizedBox(width: 24),
          // Tilt icon and text
            const Icon(
              LucideIcons.minus,
              size: 16,
              color: Colors.white70,
            ),
            const SizedBox(width: 4),
            const Text(
              'Level',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          const SizedBox(width: 24),
          // Zoom icon and text
            const Icon(
              LucideIcons.search,
              size: 16,
              color: Colors.white70,
            ),
            const SizedBox(width: 4),
            Text(
              '${zoomLevel.toStringAsFixed(1)}x',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }
}