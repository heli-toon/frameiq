import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:frameiq/core/widgets/glass_surface.dart';
import 'package:frameiq/features/camera/application/camera_controller.dart';
import 'package:frameiq/features/camera/providers/camera_sensor_provider.dart';
import 'package:frameiq/features/camera/presentation/widgets/camera_controls.dart';
import 'package:frameiq/features/camera/presentation/widgets/composition_overlay.dart';
import 'package:frameiq/features/camera/presentation/widgets/grid_overlay.dart';
import 'package:frameiq/features/camera/presentation/widgets/level_indicator.dart';
import 'package:frameiq/features/camera/presentation/widgets/recommendation_header.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen>
    with WidgetsBindingObserver {
  Timer? _inactivityTimer;
  bool _isPowerSaving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Keep the screen awake during active camera shooting
    _enableWakelock();
    _startInactivityTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _inactivityTimer?.cancel();
    // Release the wakelock when exiting the camera screen
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      _enterPowerSaving();
    } else if (state == AppLifecycleState.resumed && !_isPowerSaving) {
      ref.read(cameraControllerNotifierProvider.notifier).resumeCamera();
    }
  }

  void _enableWakelock() async {
    try {
      await WakelockPlus.enable();
    } catch (_) {
      // Graceful fallback on unsupported platforms
    }
  }

  void _disableWakelock() async {
    try {
      await WakelockPlus.disable();
    } catch (_) {
      // Graceful fallback
    }
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    // After 90 seconds of inactivity, enter battery-saving mode
    _inactivityTimer = Timer(const Duration(seconds: 90), () {
      if (mounted && !_isPowerSaving) {
        _enterPowerSaving();
      }
    });
  }

  void _resetInactivityTimer() {
    if (_isPowerSaving) {
      _wakeFromPowerSaving();
      return;
    }
    _startInactivityTimer();
  }

  void _enterPowerSaving() {
    if (!mounted) return;
    setState(() {
      _isPowerSaving = true;
    });
    _inactivityTimer?.cancel();

    // 1. Allow the OS screen timeout to sleep the display when unattended
    _disableWakelock();

    // 2. Actually pause the camera hardware and stop the preview stream
    ref.read(cameraControllerNotifierProvider.notifier).pauseCamera();
  }

  void _wakeFromPowerSaving() {
    if (!mounted) return;
    setState(() {
      _isPowerSaving = false;
    });

    // 1. Re-enable wakelock for active shooting
    _enableWakelock();

    // 2. Resume camera hardware and preview stream
    ref.read(cameraControllerNotifierProvider.notifier).resumeCamera();

    // 3. Restart inactivity timer
    _startInactivityTimer();
  }

  @override
  Widget build(BuildContext context) {
    final cameraAsync = ref.watch(cameraControllerNotifierProvider);
    final sensor = ref.watch(cameraSensorProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) => _resetInactivityTimer(),
        child: cameraAsync.when(
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
                // 1. Live Camera Preview (Only mounted and rendering when camera is active)
                if (!_isPowerSaving)
                  Center(
                    child: CameraPreview(controller),
                  )
                else
                  // Pure OLED solid black surface (0 power draw, hardware preview feed is stopped)
                  const ColoredBox(color: Colors.black),

                // 2. Viewfinder Overlays & Controls (Only active when camera is awake)
                if (!_isPowerSaving) ...[
                  // Rule of Thirds / Golden Ratio Grid Overlay
                  const GridOverlay(),

                  // Composition Reference Overlay (The Coach)
                  const CompositionOverlay(),

                  // Real-time Leveling Guide
                  const Center(child: LevelIndicator()),

                  // UI Controls Layer (Floating Glass Controls)
                  CameraControls(
                    onCapture: () async {
                      _resetInactivityTimer();
                      final navigator = GoRouter.of(context);
                      final xFile = await ref
                          .read(cameraControllerNotifierProvider.notifier)
                          .capturePhoto();
                      if (xFile != null) {
                        navigator.push('/review', extra: xFile.path);
                      }
                    },
                    onFlashToggle: () {
                      _resetInactivityTimer();
                      ref
                          .read(cameraControllerNotifierProvider.notifier)
                          .toggleFlash();
                    },
                    onZoomChanged: (value) {
                      _resetInactivityTimer();
                      ref
                          .read(cameraControllerNotifierProvider.notifier)
                          .setZoom(value);
                    },
                  ),

                  // Top Status Bar (Glass Back button + Recommendation Header)
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
                          child: AnimatedRotation(
                            turns: sensor.orientationTurns,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                            child: const Icon(
                              LucideIcons.arrow_left,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const RecommendationHeader(),
                        const SizedBox(width: 38), // Visual balance
                      ],
                    ),
                  ),
                ],

                // 3. Battery-saving Inactivity Sleep Layer
                if (_isPowerSaving)
                  GestureDetector(
                    onTap: _wakeFromPowerSaving,
                    behavior: HitTestBehavior.opaque,
                    child: ColoredBox(
                      color: Colors.black, // Pure solid black for OLED power savings
                      child: Center(
                        child: GlassSurface.pill(
                          blurSigma: 16,
                          surfaceColor: Colors.black.withValues(alpha: 0.70),
                          borderColor: Colors.white.withValues(alpha: 0.20),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                LucideIcons.moon,
                                color: Color(0xFFFBBF24),
                                size: 30,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Camera Paused to Save Battery',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Tap anywhere to resume',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
      ),
    );
  }
}
