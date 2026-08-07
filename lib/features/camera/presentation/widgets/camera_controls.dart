import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:camera/camera.dart' as camera;
import 'package:frameiq/features/camera/application/camera_controller.dart';

class CameraControls extends ConsumerWidget {
  final VoidCallback onCapture;
  final VoidCallback onFlashToggle;
  final ValueChanged<double> onZoomChanged;

  const CameraControls({
    super.key,
    required this.onCapture,
    required this.onFlashToggle,
    required this.onZoomChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overlayOpacity = ref.watch(overlaySettingsProvider);
    final zoomLevel = ref.watch(zoomLevelProvider);
    final cameraAsync = ref.watch(cameraControllerNotifierProvider);

    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main controls row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Flash button
                IconButton(
                  icon: Icon(
                    cameraAsync.when(
                      data: (controller) => controller?.value.flashMode == camera.FlashMode.torch,
                      loading: () => false,
                      error: (_, __) => false,
                    ) ||
                        cameraAsync.maybeWhen(
                          orElse: () => false,
                        )
                        ? LucideIcons.zap
                        : LucideIcons.zap_off,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: onFlashToggle,
                ),
              const SizedBox(width: 24),

              // Capture button
              GestureDetector(
                onTap: onCapture,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),

              // Gallery shortcut
                IconButton(
                  icon: const Icon(
                    LucideIcons.image,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    // TODO: Open gallery
                  },
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Zoom slider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                const Icon(
                  LucideIcons.zoom_in,
                  color: Colors.white54,
                  size: 20,
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white24,
                      thumbColor: Colors.white,
                      overlayColor: Colors.white12,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                    ),
                    child: Slider(
                      min: 1.0,
                      max: 5.0,
                      divisions: 4,
                      label: '${zoomLevel}x',
                      value: zoomLevel,
                      onChanged: (value) {
                        onZoomChanged(value);
                        ref.read(cameraControllerNotifierProvider.notifier).setZoom(value);
                        ref.read(zoomLevelProvider.notifier).state = value;
                      },
                    ),
                  ),
                ),
                const Icon(
                  LucideIcons.zoom_out,
                  color: Colors.white54,
                  size: 20,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Overlay opacity slider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                const Icon(
                  LucideIcons.circle_dashed, // Using circle-dashed as opacity equivalent
                  color: Colors.white54,
                  size: 20,
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white24,
                      thumbColor: Colors.white,
                      overlayColor: Colors.white12,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                    ),
                    child: Slider(
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                      label: '${(overlayOpacity * 100).toStringAsFixed(0)}%',
                      value: overlayOpacity,
                      onChanged: (value) {
                        ref.read(overlaySettingsProvider.notifier).setOpacity(value);
                      },
                    ),
                  ),
                ),
                const Icon(
                  LucideIcons.circle, // Using circle as off/on equivalent
                  color: Colors.white54,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}