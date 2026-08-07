import 'package:freezed_annotation/freezed_annotation.dart';

part 'environment_model.freezed.dart';
part 'environment_model.g.dart';

@freezed
class EnvironmentModel with _$EnvironmentModel {
  const factory EnvironmentModel({
    required String id,
    required String sceneId,
    required String title,
    required String imageAsset,
    @Default(0) int posesCount,
  }) = _EnvironmentModel;

  factory EnvironmentModel.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentModelFromJson(json);
}
