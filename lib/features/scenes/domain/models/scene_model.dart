import 'package:freezed_annotation/freezed_annotation.dart';

part 'scene_model.freezed.dart';
part 'scene_model.g.dart';

@freezed
class SceneModel with _$SceneModel {
  const factory SceneModel({
    required String id,
    required String title,
    required String description,
    required String imageAsset,
    @Default(0) int environmentsCount,
  }) = _SceneModel;

  factory SceneModel.fromJson(Map<String, dynamic> json) =>
      _$SceneModelFromJson(json);
}
