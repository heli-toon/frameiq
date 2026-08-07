import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:frameiq/main.dart';

void main() {
  testWidgets('FrameIQApp builds successfully', (WidgetTester tester) async {
    // Initialize Hive for test environment
    Hive.init('./test_hive');

    await tester.pumpWidget(const ProviderScope(child: FrameIQApp()));
    expect(find.byType(FrameIQApp), findsOneWidget);

    // Pump past the 3 second splash timer
    await tester.pumpAndSettle(const Duration(seconds: 4));
  });
}

