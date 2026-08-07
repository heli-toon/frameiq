import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frameiq/features/camera/application/camera_controller.dart';
import 'package:frameiq/features/camera/providers/overlay_providers.dart';

class CompositionOverlay extends ConsumerWidget {
  const CompositionOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOverlay = ref.watch(selectedOverlayProvider);
    final overlayOpacity = ref.watch(overlaySettingsProvider);

    // If no overlay is selected, return an empty container
    if (selectedOverlay == null) {
      return const SizedBox.shrink();
    }

    return IgnorePointer(
      child: Opacity(
        opacity: overlayOpacity,
        child: Container(
          decoration: BoxDecoration(
            image: selectedOverlay.overlayAsset.startsWith('assets/')
                ? DecorationImage(
                    image: AssetImage(selectedOverlay.overlayAsset),
                    fit: BoxFit.contain,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}