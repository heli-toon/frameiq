import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frameiq/features/camera/data/overlay_mock_data.dart';
import 'package:frameiq/features/camera/domain/models/overlay_model.dart';

// Provider for the list of available overlays
final overlaysProvider = Provider<List<OverlayModel>>((ref) {
  return mockOverlays;
});

// Provider for the currently selected overlay
final selectedOverlayProvider = StateProvider<OverlayModel?>((ref) {
  // Default to the first overlay if available
  final overlays = ref.watch(overlaysProvider);
  return overlays.isNotEmpty ? overlays[0] : null;
});