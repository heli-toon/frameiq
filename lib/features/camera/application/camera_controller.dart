import 'package:camera/camera.dart' as camera;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'camera_controller.g.dart';

@riverpod
class CameraControllerNotifier extends _$CameraControllerNotifier {
  @override
  FutureOr<camera.CameraController?> build() async {
    final cameras = await camera.availableCameras();
    if (cameras.isEmpty) return null;

    final controller = camera.CameraController(
      cameras.first,
      camera.ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: camera.ImageFormatGroup.jpeg,
    );

    await controller.initialize();
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  }

  Future<camera.XFile?> capturePhoto() async {
    final controller = state.value;
    if (controller == null || !controller.value.isInitialized) return null;
    return await controller.takePicture();
  }

  Future<void> toggleFlash() async {
    final controller = state.value;
    if (controller == null) return;
    final currentMode = controller.value.flashMode;
    final nextMode = currentMode == camera.FlashMode.off ? camera.FlashMode.torch : camera.FlashMode.off;
    await controller.setFlashMode(nextMode);
    ref.notifyListeners();
  }

  Future<void> setZoom(double value) async {
    final controller = state.value;
    if (controller == null) return;
    await controller.setZoomLevel(value);
    ref.read(zoomLevelProvider.notifier).setZoom(value);
  }

  /// Pauses the camera preview and turns off torch to conserve battery.
  Future<void> pauseCamera() async {
    final controller = state.value;
    if (controller == null || !controller.value.isInitialized) return;
    try {
      if (controller.value.flashMode == camera.FlashMode.torch) {
        await controller.setFlashMode(camera.FlashMode.off);
      }
      if (!controller.value.isPreviewPaused) {
        await controller.pausePreview();
      }
    } catch (_) {
      // Graceful fallback on devices/platforms where pausePreview is unsupported
    }
  }

  /// Resumes the camera preview when waking from battery-saving mode.
  Future<void> resumeCamera() async {
    final controller = state.value;
    if (controller == null || !controller.value.isInitialized) return;
    try {
      if (controller.value.isPreviewPaused) {
        await controller.resumePreview();
      }
    } catch (_) {
      // Graceful fallback
    }
  }
}

@riverpod
class OverlaySettings extends _$OverlaySettings {
  @override
  double build() => 0.5; // Default Opacity

  void setOpacity(double val) => state = val;
}

@riverpod
class ZoomLevel extends _$ZoomLevel {
  @override
  double build() => 1.0; // Default zoom level

  void setZoom(double val) => state = val;
}

enum GridType { none, ruleOfThirds, goldenRatio }

@riverpod
class GridSettings extends _$GridSettings {
  @override
  GridType build() => GridType.ruleOfThirds;

  void setGridType(GridType type) => state = type;
  void toggleGrid() {
    if (state == GridType.none) {
      state = GridType.ruleOfThirds;
    } else if (state == GridType.ruleOfThirds) {
      state = GridType.goldenRatio;
    } else {
      state = GridType.none;
    }
  }
}