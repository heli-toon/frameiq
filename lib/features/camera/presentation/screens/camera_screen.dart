import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frameiq/features/camera/application/camera_controller.dart';
import 'package:frameiq/features/camera/presentation/widgets/camera_controls.dart';
import 'package:frameiq/features/camera/presentation/widgets/composition_overlay.dart';
import 'package:frameiq/features/camera/presentation/widgets/level_indicator.dart';
import 'package:frameiq/features/camera/presentation/widgets/recommendation_header.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final cameraAsync = ref.watch(cameraControllerNotifierProvider);

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
                  CompositionOverlay(),

                  // 3. Real-time Leveling Guide
                  const Center(child: LevelIndicator()),

                  // 4. UI Controls Layer
                  CameraControls(
                    onCapture: () async {
                      final xFile = await ref.read(cameraControllerNotifierProvider.notifier).capturePhoto();
                      if (xFile != null && mounted) {
                        // TODO: Navigate to capture review screen
                      }
                    },
                    onFlashToggle: () {
                      ref.read(cameraControllerNotifierProvider.notifier).toggleFlash();
                    },
                    onZoomChanged: (value) {
                      ref.read(cameraControllerNotifierProvider.notifier).setZoom(value);
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
      },
    );
  }
}