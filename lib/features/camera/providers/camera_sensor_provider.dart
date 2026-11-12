import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
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
  double _filteredY = 9.81;
  double _filteredZ = 0.0;
  double _currentTurns = 0.0;

  CameraSensorNotifier({Stream<AccelerometerEvent>? eventStream})
      : super(const CameraSensorState()) {
    _init(eventStream);
  }

  void _init(Stream<AccelerometerEvent>? eventStream) {
    final stream = eventStream ?? accelerometerEventStream();
    _sub = stream.listen((event) {
      processSensorEvent(event.x, event.y, event.z);
    });
  }

  /// Processes accelerometer coordinates and updates the state.
  ///
  /// Coordinate system (standard mobile device sensors_plus):
  /// - When held upright in portrait facing user:
  ///   Gravity pulls down (-Y in world). Accelerometer measures reaction force upward (+Y).
  ///   Therefore: X ≈ 0, Y ≈ +9.81 m/s², Z ≈ 0.
  ///   atan2(X, Y) yields 0.0°.
  ///
  /// - When rotated 90° CCW to Landscape Left (camera/top to the left):
  ///   Reaction force is along +X.
  ///   Therefore: X ≈ +9.81, Y ≈ 0.
  ///   atan2(X, Y) yields +90.0°.
  ///   UI controls rotate +0.25 turns (+90° CW) relative to the screen to remain right-side up.
  ///
  /// - When rotated 90° CW to Landscape Right (camera/top to the right):
  ///   Reaction force is along -X.
  ///   Therefore: X ≈ -9.81, Y ≈ 0.
  ///   atan2(X, Y) yields -90.0°.
  ///   UI controls rotate -0.25 turns (-90° CCW) relative to the screen to remain right-side up.
  ///
  /// - When held upside down in portrait:
  ///   X ≈ 0, Y ≈ -9.81.
  ///   atan2(X, Y) yields ±180.0°.
  ///   UI controls rotate 0.5 turns (180°) relative to the screen.
  @visibleForTesting
  void processSensorEvent(double x, double y, double z) {
    // Exponential moving average filter to eliminate sensor jitter
    _filteredX = _filteredX * 0.72 + x * 0.28;
    _filteredY = _filteredY * 0.72 + y * 0.28;
    _filteredZ = _filteredZ * 0.72 + z * 0.28;

    final double inPlaneMagnitude =
        sqrt(_filteredX * _filteredX + _filteredY * _filteredY);
    final bool isUpright = inPlaneMagnitude > 2.0;

    // In-plane gravity angle in degrees (-180° to +180°)
    // Upright portrait holds y = +9.81, so atan2(x, y) yields 0.0°
    final double rawAngle = atan2(_filteredX, _filteredY) * (180.0 / pi);

    // Orientation state machine with 20° hysteresis buffer (only update if upright)
    if (isUpright) {
      if (_currentTurns == 0.0) {
        // Currently in Portrait Upright (0°)
        if (rawAngle > 55 && rawAngle < 125) {
          _currentTurns = 0.25; // Landscape Left: rotate UI +90° CW
        } else if (rawAngle < -55 && rawAngle > -125) {
          _currentTurns = -0.25; // Landscape Right: rotate UI -90° CCW
        } else if (rawAngle.abs() >= 140) {
          _currentTurns = 0.5; // Upside down
        }
      } else if (_currentTurns == 0.25) {
        // Currently in Landscape Left (+90°)
        if (rawAngle > -35 && rawAngle < 35) {
          _currentTurns = 0.0; // Back to Portrait Upright
        } else if (rawAngle < -55 && rawAngle > -125) {
          _currentTurns = -0.25; // Switch to Landscape Right
        } else if (rawAngle.abs() >= 140) {
          _currentTurns = 0.5; // Switch to Upside down
        }
      } else if (_currentTurns == -0.25) {
        // Currently in Landscape Right (-90°)
        if (rawAngle > -35 && rawAngle < 35) {
          _currentTurns = 0.0; // Back to Portrait Upright
        } else if (rawAngle > 55 && rawAngle < 125) {
          _currentTurns = 0.25; // Switch to Landscape Left
        } else if (rawAngle.abs() >= 140) {
          _currentTurns = 0.5; // Switch to Upside down
        }
      } else {
        // Currently in Upside down (0.5)
        if (rawAngle > -35 && rawAngle < 35) {
          _currentTurns = 0.0; // Back to Portrait Upright
        } else if (rawAngle > 55 && rawAngle < 125) {
          _currentTurns = 0.25; // Switch to Landscape Left
        } else if (rawAngle < -55 && rawAngle > -125) {
          _currentTurns = -0.25; // Switch to Landscape Right
        }
      }
    }

    // Roll deviation relative to the nearest shooting orientation cardinal (0°, 90°, -90°, 180°)
    final double nearestCardinal = (rawAngle / 90.0).round() * 90.0;
    final double rollError = rawAngle - nearestCardinal;

    // Pitch angle forward/backward relative to vertical
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
