import 'dart:async';
import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:frameiq/features/camera/providers/camera_sensor_provider.dart';

void main() {
  group('CameraSensorNotifier Orientation and Leveling Tests', () {
    late StreamController<AccelerometerEvent> streamController;
    late CameraSensorNotifier notifier;

    setUp(() {
      streamController = StreamController<AccelerometerEvent>();
      notifier = CameraSensorNotifier(eventStream: streamController.stream);
    });

    tearDown(() {
      notifier.dispose();
      streamController.close();
    });

    void emitMultiple(double x, double y, double z, {int count = 10}) {
      // Due to the 0.72 / 0.28 moving average filter, 10 events stabilize to >98% of target value
      for (int i = 0; i < count; i++) {
        notifier.processSensorEvent(x, y, z);
      }
    }

    test('Initial default state is upright portrait with zero turns', () {
      expect(notifier.state.orientationTurns, 0.0);
      expect(notifier.state.isUpright, true);
    });

    test('Upright portrait (X=0, Y=9.81) maintains 0.0 turns and is level', () {
      emitMultiple(0.0, 9.81, 0.0);

      expect(notifier.state.orientationTurns, 0.0);
      expect(notifier.state.isUpright, true);
      expect(notifier.state.rollDegrees.abs(), lessThan(1.0));
      expect(notifier.state.isLevel, true);
    });

    test('Portrait tilted 5° clockwise has negative roll and is not level', () {
      // Clockwise tilt -> gravity pulls toward -X -> reaction force is toward -X
      final x = -9.81 * sin(5.0 * pi / 180.0);
      final y = 9.81 * cos(5.0 * pi / 180.0);
      emitMultiple(x, y, 0.0, count: 15);

      expect(notifier.state.orientationTurns, 0.0);
      expect(notifier.state.rollDegrees, closeTo(-5.0, 0.3));
      expect(notifier.state.isLevel, false);
    });

    test('Portrait tilted 5° counter-clockwise has positive roll and is not level', () {
      final x = 9.81 * sin(5.0 * pi / 180.0);
      final y = 9.81 * cos(5.0 * pi / 180.0);
      emitMultiple(x, y, 0.0, count: 15);

      expect(notifier.state.orientationTurns, 0.0);
      expect(notifier.state.rollDegrees, closeTo(5.0, 0.3));
      expect(notifier.state.isLevel, false);
    });

    test('Landscape Left (top pointing left, X=+9.81, Y=0) rotates UI +0.25 turns (90° CW)', () {
      emitMultiple(9.81, 0.0, 0.0, count: 15);

      // When phone rotates 90° CCW, UI rotates +0.25 (+90° CW) to remain right-side up
      expect(notifier.state.orientationTurns, 0.25);
      expect(notifier.state.isUpright, true);
      expect(notifier.state.rollDegrees.abs(), lessThan(1.0));
      expect(notifier.state.isLevel, true);
    });

    test('Landscape Right (top pointing right, X=-9.81, Y=0) rotates UI -0.25 turns (-90° CCW)', () {
      emitMultiple(-9.81, 0.0, 0.0, count: 15);

      // When phone rotates 90° CW, UI rotates -0.25 (-90° CCW) to remain right-side up
      expect(notifier.state.orientationTurns, -0.25);
      expect(notifier.state.isUpright, true);
      expect(notifier.state.rollDegrees.abs(), lessThan(1.0));
      expect(notifier.state.isLevel, true);
    });

    test('Upside down portrait (X=0, Y=-9.81) sets orientationTurns to 0.5', () {
      emitMultiple(0.0, -9.81, 0.0, count: 15);

      expect(notifier.state.orientationTurns, 0.5);
      expect(notifier.state.isUpright, true);
      expect(notifier.state.rollDegrees.abs(), lessThan(1.0));
      expect(notifier.state.isLevel, true);
    });

    test('Hysteresis: does not flip to landscape until crossing 55° threshold', () {
      // 45° tilt in portrait
      final x = 9.81 * sin(45.0 * pi / 180.0);
      final y = 9.81 * cos(45.0 * pi / 180.0);
      emitMultiple(x, y, 0.0, count: 15);

      // 45° is below the 55° threshold, so orientation stays portrait (0.0)
      expect(notifier.state.orientationTurns, 0.0);

      // Tilt past 60°
      final x60 = 9.81 * sin(60.0 * pi / 180.0);
      final y60 = 9.81 * cos(60.0 * pi / 180.0);
      emitMultiple(x60, y60, 0.0, count: 15);

      // Now it crosses 55° and transitions to Landscape Left (0.25)
      expect(notifier.state.orientationTurns, 0.25);

      // Returning back towards portrait to 45° (hysteresis keeps it in landscape until <35°)
      emitMultiple(x, y, 0.0, count: 15);
      expect(notifier.state.orientationTurns, 0.25);

      // Returning to 25° (crosses <35° threshold)
      final x25 = 9.81 * sin(25.0 * pi / 180.0);
      final y25 = 9.81 * cos(25.0 * pi / 180.0);
      emitMultiple(x25, y25, 0.0, count: 15);
      expect(notifier.state.orientationTurns, 0.0);
    });

    test('Flat on surface (X=0, Y=0, Z=9.81) sets isUpright to false and freezes orientation', () {
      // First establish portrait
      emitMultiple(0.0, 9.81, 0.0, count: 10);
      expect(notifier.state.isUpright, true);
      expect(notifier.state.orientationTurns, 0.0);

      // Lay flat on table
      emitMultiple(0.0, 0.0, 9.81, count: 15);
      expect(notifier.state.isUpright, false);
      expect(notifier.state.isLevel, false);
      // Retains last orientation without jitter
      expect(notifier.state.orientationTurns, 0.0);
    });
  });
}
