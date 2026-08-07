import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frameiq/features/scenes/domain/models/scene_model.dart';
import 'package:frameiq/features/environments/domain/models/environment_model.dart';
import 'package:frameiq/features/poses/domain/models/pose_model.dart';
import 'package:frameiq/shared/data/mock_data.dart';

final selectedSceneProvider = StateProvider<SceneModel?>((ref) {
  return MockData.scenes.first;
});

final selectedEnvironmentProvider = StateProvider<EnvironmentModel?>((ref) {
  return MockData.environments.first;
});

final selectedPoseProvider = StateProvider<PoseModel?>((ref) {
  return MockData.poses.first;
});
