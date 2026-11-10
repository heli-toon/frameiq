import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:camera/camera.dart' as camera;
import 'package:go_router/go_router.dart';
import 'package:frameiq/core/widgets/glass_surface.dart';
import 'package:frameiq/features/camera/application/camera_controller.dart';
import 'package:frameiq/features/camera/providers/camera_sensor_provider.dart';

class CameraControls extends ConsumerStatefulWidget {
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
  ConsumerState<CameraControls> createState() => _CameraControlsState();
}

class _CameraControlsState extends ConsumerState<CameraControls> {
  bool _showSlider = false; // Toggle between zoom & opacity slider
  bool _sliderIsOpacity = false;

  @override
  Widget build(BuildContext context) {
    final overlayOpacity = ref.watch(overlaySettingsProvider);
    final zoomLevel = ref.watch(zoomLevelProvider);
    final cameraAsync = ref.watch(cameraControllerNotifierProvider);
    final gridType = ref.watch(gridSettingsProvider);
    final sensor = ref.watch(cameraSensorProvider);

    final isTorchOn = cameraAsync.when(
      data: (controller) => controller?.value.flashMode == camera.FlashMode.torch,
      loading: () => false,
      error: (_, __) => false,
    );

    final turns = sensor.orientationTurns;

    return Positioned(
      bottom: 28,
      left: 16,
      right: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Quick adjustments glass capsule (Zoom / Opacity toggles & slider)
          GlassSurface.pill(
            blurSigma: 16,
            surfaceColor: Colors.black.withValues(alpha: 0.50),
            borderColor: Colors.white.withValues(alpha: 0.14),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Zoom selector pill
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_showSlider && !_sliderIsOpacity) {
                        _showSlider = false;
                      } else {
                        _showSlider = true;
                        _sliderIsOpacity = false;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (!_sliderIsOpacity && _showSlider)
                          ? Colors.white.withValues(alpha: 0.22)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: AnimatedRotation(
                      turns: turns,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.zoom_in, size: 14, color: Colors.white70),
                          const SizedBox(width: 4),
                          Text(
                            '${zoomLevel.toStringAsFixed(1)}x',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Vertical hairline divider
                Container(
                  height: 12,
                  width: 0.8,
                  color: Colors.white24,
                ),
                const SizedBox(width: 8),

                // Opacity selector pill
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_showSlider && _sliderIsOpacity) {
                        _showSlider = false;
                      } else {
                        _showSlider = true;
                        _sliderIsOpacity = true;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (_sliderIsOpacity && _showSlider)
                          ? Colors.white.withValues(alpha: 0.22)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: AnimatedRotation(
                      turns: turns,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.blend, size: 14, color: Colors.white70),
                          const SizedBox(width: 4),
                          Text(
                            '${(overlayOpacity * 100).toInt()}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Collapsible active slider
          if (_showSlider) ...[
            const SizedBox(height: 12),
            GlassSurface.pill(
              blurSigma: 16,
              surfaceColor: Colors.black.withValues(alpha: 0.60),
              borderColor: Colors.white.withValues(alpha: 0.16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: SizedBox(
                width: 260,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white24,
                    thumbColor: Colors.white,
                    overlayColor: Colors.white12,
                    trackHeight: 2.0,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                  ),
                  child: _sliderIsOpacity
                      ? Slider(
                          min: 0.0,
                          max: 1.0,
                          divisions: 10,
                          value: overlayOpacity,
                          onChanged: (value) {
                            ref.read(overlaySettingsProvider.notifier).setOpacity(value);
                          },
                        )
                      : Slider(
                          min: 1.0,
                          max: 5.0,
                          divisions: 4,
                          value: zoomLevel,
                          onChanged: (value) {
                            widget.onZoomChanged(value);
                            ref.read(cameraControllerNotifierProvider.notifier).setZoom(value);
                            ref.read(zoomLevelProvider.notifier).setZoom(value);
                          },
                        ),
                ),
              ),
            ),
          ],

          const SizedBox(height: 20),

          // Primary Controls Row (Flash, Grid, Shutter, Overlays, Gallery)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Flash Toggle Button
              GlassSurface.circle(
                blurSigma: 14,
                surfaceColor: Colors.black.withValues(alpha: 0.45),
                borderColor: Colors.white.withValues(alpha: 0.14),
                padding: const EdgeInsets.all(12),
                onTap: widget.onFlashToggle,
                child: AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  child: Icon(
                    isTorchOn ? LucideIcons.zap : LucideIcons.zap_off,
                    color: isTorchOn ? const Color(0xFFFBBF24) : Colors.white,
                    size: 20,
                  ),
                ),
              ),

              // Grid Toggle Button
              GlassSurface.circle(
                blurSigma: 14,
                surfaceColor: Colors.black.withValues(alpha: 0.45),
                borderColor: Colors.white.withValues(alpha: 0.14),
                padding: const EdgeInsets.all(12),
                onTap: () {
                  ref.read(gridSettingsProvider.notifier).toggleGrid();
                },
                child: AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  child: Icon(
                    gridType == GridType.none
                        ? LucideIcons.grid_2x2
                        : gridType == GridType.ruleOfThirds
                            ? LucideIcons.grid_3x3
                            : LucideIcons.frame,
                    color: gridType != GridType.none ? const Color(0xFF38BDF8) : Colors.white,
                    size: 20,
                  ),
                ),
              ),

              // Super-flat Shutter Button
              GestureDetector(
                onTap: widget.onCapture,
                child: Container(
                  width: 76,
                  height: 76,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.5,
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Overlays Picker Shortcut
              GlassSurface.circle(
                blurSigma: 14,
                surfaceColor: Colors.black.withValues(alpha: 0.45),
                borderColor: Colors.white.withValues(alpha: 0.14),
                padding: const EdgeInsets.all(12),
                onTap: () => context.push('/overlays'),
                child: AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  child: const Icon(
                    LucideIcons.sparkles,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),

              // Library / Gallery Shortcut
              GlassSurface.circle(
                blurSigma: 14,
                surfaceColor: Colors.black.withValues(alpha: 0.45),
                borderColor: Colors.white.withValues(alpha: 0.14),
                padding: const EdgeInsets.all(12),
                onTap: () => context.go('/library'),
                child: AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  child: const Icon(
                    LucideIcons.images,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
