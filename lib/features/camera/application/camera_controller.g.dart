// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cameraControllerNotifierHash() =>
    r'b72ff9f23e479b40ce3918d854b182529aa5ef09';

/// See also [CameraControllerNotifier].
@ProviderFor(CameraControllerNotifier)
final cameraControllerNotifierProvider = AutoDisposeAsyncNotifierProvider<
    CameraControllerNotifier, camera.CameraController?>.internal(
  CameraControllerNotifier.new,
  name: r'cameraControllerNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cameraControllerNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CameraControllerNotifier
    = AutoDisposeAsyncNotifier<camera.CameraController?>;
String _$overlaySettingsHash() => r'9d7dcb35bf71ecba0a857b27fcf795b1edd19422';

/// See also [OverlaySettings].
@ProviderFor(OverlaySettings)
final overlaySettingsProvider =
    AutoDisposeNotifierProvider<OverlaySettings, double>.internal(
  OverlaySettings.new,
  name: r'overlaySettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$overlaySettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OverlaySettings = AutoDisposeNotifier<double>;
String _$zoomLevelHash() => r'04c90ed03b34393651b2456f5b44f98c7b32a102';

/// See also [ZoomLevel].
@ProviderFor(ZoomLevel)
final zoomLevelProvider =
    AutoDisposeNotifierProvider<ZoomLevel, double>.internal(
  ZoomLevel.new,
  name: r'zoomLevelProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$zoomLevelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ZoomLevel = AutoDisposeNotifier<double>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
