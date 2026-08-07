import 'package:freezed_annotation/freezed_annotation.dart';

part 'pose_model.freezed.dart';
part 'pose_model.g.dart';

@freezed
class PoseModel with _$PoseModel {
  const factory PoseModel({
    required String id,
    required String environmentId,
    required String title,
    required String category, // Portrait, Couple, Solo, Sunset, Architectural
    required String previewImage,
    required String overlayAsset,
    @Default('Beginner') String difficulty,
    @Default('') String instructions,
    @Default(1.0) double recommendedZoom,
    @Default(0.0) double recommendedTilt,
    @Default('1.5m') String recommendedDistance,
    @Default('Eye Level') String recommendedHeight,
    @Default('Front') String lightingDirection,
    String? tips,
    @Default(false) bool isFavorite,
  }) = _PoseModel;

  factory PoseModel.fromJson(Map<String, dynamic> json) =>
      _$PoseModelFromJson(json);
}
