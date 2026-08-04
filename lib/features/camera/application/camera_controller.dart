import 'package:camera/camera.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'camera_controller.g.dart';

@riverpod
class CameraController extends _$CameraController {
  CameraController? _controller;

  @override
  FutureOr<CameraController?> build() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return null;

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.pro,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await _controller!.initialize();
    return _controller;
  }

  Future<XFile?> capturePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) return null;
    return await _controller!.takePicture();
  }

  Future<void> toggleFlash() async {
    if (_controller == null) return;
    final currentMode = _controller!.value.flashMode;
    final nextMode = currentMode == FlashMode.off ? FlashMode.torch : FlashMode.off;
    await _controller!.setFlashMode(nextMode);
    ref.notifyListeners();
  }

  Future<void> setZoom(double value) async {
    await _controller?.setZoomLevel(value);
    // Notify the zoom level provider to update
    ref.read(zoomLevelProvider.notifier).state = value;
  }

  Future<void> dispose() async {
    await _controller?.dispose();
    super.dispose();
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