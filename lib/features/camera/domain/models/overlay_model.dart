import 'package:freezed_annotation/freezed_annotation.dart';

part 'overlay_model.freezed.dart';
part 'overlay_model.g.dart';

@freezed
class OverlayModel with _$OverlayModel {
  const factory OverlayModel({
    required String id,
    required String title,
    required String overlayAsset, // Transparent PNG/SVG of the pose/guide
    @Default(1.0) double recommendedZoom,
    @Default(0.0) double recommendedTilt, // In degrees
    @Default('1.5m') String recommendedDistance,
    @Default('Eye Level') String recommendedHeight,
    @Default('Center') String lightingDirection,
    @Default('Beginner') String difficulty,
    String? tips,
  }) = _OverlayModel;

  factory OverlayModel.fromJson(Map<String, dynamic> json) =>
      _$OverlayModelFromJson(json);
}