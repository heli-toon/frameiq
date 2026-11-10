import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class CameraSensorState {
  /// Horizon roll error in degrees (-45° to +45° relative to current shooting orientation).
  final double rollDegrees;

  /// Pitch inclination angle in degrees (forward/backward tilt relative to vertical).
  final double pitchDegrees;

  /// Whether the horizon is within ±1.2° level tolerance.
  final bool isLevel;

  /// Rotation turns for UI controls to match device orientation (0.0, 0.25, -0.25, 0.5).
  final double orientationTurns;

  /// Whether the phone is held upright for shooting (not lying flat on a table).
  final bool isUpright;

  const CameraSensorState({
    this.rollDegrees = 0.0,
    this.pitchDegrees = 0.0,
    this.isLevel = false,
    this.orientationTurns = 0.0,
    this.isUpright = true,
  });
}

class CameraSensorNotifier extends StateNotifier<CameraSensorState> {
  StreamSubscription<AccelerometerEvent>? _sub;
  double _filteredX = 0.0;
  double _filteredY = -9.81;
  double _filteredZ = 0.0;
  double _currentTurns = 0.0;

  CameraSensorNotifier() : super(const CameraSensorState()) {
    _init();
  }

  void _init() {
    _sub = accelerometerEventStream().listen((event) {
      // Exponential moving average filter to eliminate sensor jitter
      _filteredX = _filteredX * 0.72 + event.x * 0.28;
      _filteredY = _filteredY * 0.72 + event.y * 0.28;
      _filteredZ = _filteredZ * 0.72 + event.z * 0.28;

      final double inPlaneMagnitude = sqrt(_filteredX * _filteredX + _filteredY * _filteredY);
      final bool isUpright = inPlaneMagnitude > 2.0;

      // In-plane gravity angle in degrees (-180° to +180°)
      // Upright portrait holds y = -9.81, so atan2(x, -y) yields 0.0°
      final double rawAngle = atan2(_filteredX, -_filteredY) * (180.0 / pi);

      // Orientation detection with 15° hysteresis zone
      if (_currentTurns == 0.0) {
        if (rawAngle > 55 && rawAngle < 125) {
          _currentTurns = -0.25; // Landscape Left: rotate UI -90° (counter-clockwise)
        } else if (rawAngle < -55 && rawAngle > -125) {
          _currentTurns = 0.25; // Landscape Right: rotate UI +90° (clockwise)
        } else if (rawAngle.abs() >= 140) {
          _currentTurns = 0.5;
        }
      } else if (_currentTurns == -0.25) {
        // In Landscape Left
        if (rawAngle < 35 && rawAngle > -35) {
          _currentTurns = 0.0;
        } else if (rawAngle < -55) {
          _currentTurns = 0.25;
        } else if (rawAngle >= 140) {
          _currentTurns = 0.5;
        }
      } else if (_currentTurns == 0.25) {
        // In Landscape Right
        if (rawAngle < 35 && rawAngle > -35) {
          _currentTurns = 0.0;
        } else if (rawAngle > 55) {
          _currentTurns = -0.25;
        } else if (rawAngle <= -140) {
          _currentTurns = 0.5;
        }
      } else {
        // In upside down
        if (rawAngle.abs() < 120) {
          _currentTurns = 0.0;
        }
      }

      // Roll deviation relative to the nearest shooting orientation cardinal (0°, 90°, -90°, 180°)
      final double nearestCardinal = (rawAngle / 90.0).round() * 90.0;
      final double rollError = rawAngle - nearestCardinal;

      // Pitch angle forward/backward
      final double pitch = atan2(_filteredZ, inPlaneMagnitude) * (180.0 / pi);

      // Camera is level when held upright and horizon error is within ±1.2°
      final bool isLevel = isUpright && (rollError.abs() < 1.2);

      state = CameraSensorState(
        rollDegrees: rollError,
        pitchDegrees: pitch,
        isLevel: isLevel,
        orientationTurns: _currentTurns,
        isUpright: isUpright,
      );
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

final cameraSensorProvider =
    StateNotifierProvider.autoDispose<CameraSensorNotifier, CameraSensorState>((ref) {
  return CameraSensorNotifier();
});
