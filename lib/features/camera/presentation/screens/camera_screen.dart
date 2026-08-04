import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frameiq/features/camera/application/camera_controller.dart';
import 'package:frameiq/features/camera/presentation/widgets/camera_controls.dart';
import 'package:frameiq/features/camera/presentation/widgets/composition_overlay.dart';
import 'package:frameiq/features/camera/presentation/widgets/level_indicator.dart';
import 'package:frameiq/features/camera/presentation/widgets/recommendation_header.dart';

class CameraScreen extends ConsumerWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraAsync = ref.watch(cameraControllerProvider);
    final zoomLevel = ref.watch(zoomLevelProvider);
    final overlayOpacity = ref.watch(overlaySettingsProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: cameraAsync.when(
        data: (controller) {
          if (controller == null) return const Center(child: Text("No Camera Found"));

          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Camera Preview
              Center(
                child: CameraPreview(controller),
              ),

              // 2. Composition Reference Overlay (The Coach)
              CompositionOverlay(opacity: overlayOpacity),

              // 3. Real-time Leveling Guide
              const Center(child: LevelIndicator()),

              // 4. UI Controls Layer
              CameraControls(
                onCapture: () async {
                  final xFile = await ref.read(cameraControllerProvider.notifier).capturePhoto();
                  if (xFile != null && mounted) {
                    // TODO: Navigate to capture review screen
                  }
                },
                onFlashToggle: () {
                  ref.read(cameraControllerProvider.notifier).toggleFlash();
                },
                onZoomChanged: (value) {
                  ref.read(cameraControllerProvider.notifier).setZoom(value);
                },
              ),

              // 5. Top Status Bar (Zoom/Tilt Recommendation)
              const RecommendationHeader(),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}