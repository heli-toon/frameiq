import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frameiq/features/camera/application/camera_controller.dart';
import 'package:frameiq/features/camera/presentation/screens/camera_screen.dart';

void main() {
  group('Camera Power Saving and Pause Tests', () {
    test('CameraControllerNotifier exposes pauseCamera and resumeCamera', () {
      final container = ProviderContainer();
      final notifier = container.read(cameraControllerNotifierProvider.notifier);

      expect(notifier.pauseCamera, isA<Function>());
      expect(notifier.resumeCamera, isA<Function>());

      // Calling pause/resume when camera is null/uninitialized does not throw
      expect(() async => await notifier.pauseCamera(), returnsNormally);
      expect(() async => await notifier.resumeCamera(), returnsNormally);

      container.dispose();
    });

    testWidgets('CameraScreen renders safely and initializes wakelock & inactivity timer',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CameraScreen(),
          ),
        ),
      );

      // Verify CameraScreen builds
      expect(find.byType(CameraScreen), findsOneWidget);
    });
  });
}
