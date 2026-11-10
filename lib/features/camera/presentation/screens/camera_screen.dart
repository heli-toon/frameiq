import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:frameiq/core/widgets/glass_surface.dart';
import 'package:frameiq/features/camera/application/camera_controller.dart';
import 'package:frameiq/features/camera/presentation/widgets/camera_controls.dart';
import 'package:frameiq/features/camera/presentation/widgets/composition_overlay.dart';
import 'package:frameiq/features/camera/presentation/widgets/grid_overlay.dart';
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
              if (controller == null) {
                return const Center(
                  child: Text(
                    "No Camera Found",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                );
              }

              return Stack(
                fit: StackFit.expand,
                children: [
                  // 1. Camera Preview
                  Center(
                    child: CameraPreview(controller),
                  ),

                  // 2. Rule of Thirds / Golden Ratio Grid Overlay
                  const GridOverlay(),

                  // 3. Composition Reference Overlay (The Coach)
                  const CompositionOverlay(),

                  // 4. Real-time Leveling Guide
                  const Center(child: LevelIndicator()),

                  // 5. UI Controls Layer (Floating Glass Controls)
                  CameraControls(
                    onCapture: () async {
                      final navigator = GoRouter.of(context);
                      final xFile = await ref
                          .read(cameraControllerNotifierProvider.notifier)
                          .capturePhoto();
                      if (xFile != null) {
                        navigator.push('/review', extra: xFile.path);
                      }
                    },
                    onFlashToggle: () {
                      ref
                          .read(cameraControllerNotifierProvider.notifier)
                          .toggleFlash();
                    },
                    onZoomChanged: (value) {
                      ref
                          .read(cameraControllerNotifierProvider.notifier)
                          .setZoom(value);
                    },
                  ),

                  // 6. Top Status Bar (Glass Back button + Recommendation Header)
                  Positioned(
                    top: 50,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlassSurface.circle(
                          blurSigma: 14,
                          surfaceColor: Colors.black.withValues(alpha: 0.45),
                          borderColor: Colors.white.withValues(alpha: 0.16),
                          padding: const EdgeInsets.all(10),
                          onTap: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go('/home');
                            }
                          },
                          child: const Icon(
                            LucideIcons.arrow_left,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const RecommendationHeader(),
                        const SizedBox(width: 38), // Visual balance
                      ],
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.0,
              ),
            ),
            error: (err, stack) => Center(
              child: Text(
                "Error: $err",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
