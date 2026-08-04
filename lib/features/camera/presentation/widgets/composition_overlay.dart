import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frameiq/features/camera/application/camera_controller.dart';

class CompositionOverlay extends ConsumerWidget {
  const CompositionOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double opacity = ref.watch(overlaySettingsProvider);
    // In a real app, we would load the overlay image based on the selected overlay
    // For now, we use a placeholder
    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/overlays/sample_overlay.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}