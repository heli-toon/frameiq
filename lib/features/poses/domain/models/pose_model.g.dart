// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pose_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PoseModelImpl _$$PoseModelImplFromJson(Map<String, dynamic> json) =>
    _$PoseModelImpl(
      id: json['id'] as String,
      environmentId: json['environmentId'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      previewImage: json['previewImage'] as String,
      overlayAsset: json['overlayAsset'] as String,
      difficulty: json['difficulty'] as String? ?? 'Beginner',
      instructions: json['instructions'] as String? ?? '',
      recommendedZoom: (json['recommendedZoom'] as num?)?.toDouble() ?? 1.0,
      recommendedTilt: (json['recommendedTilt'] as num?)?.toDouble() ?? 0.0,
      recommendedDistance: json['recommendedDistance'] as String? ?? '1.5m',
      recommendedHeight: json['recommendedHeight'] as String? ?? 'Eye Level',
      lightingDirection: json['lightingDirection'] as String? ?? 'Front',
      tips: json['tips'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$PoseModelImplToJson(_$PoseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'environmentId': instance.environmentId,
      'title': instance.title,
      'category': instance.category,
      'previewImage': instance.previewImage,
      'overlayAsset': instance.overlayAsset,
      'difficulty': instance.difficulty,
      'instructions': instance.instructions,
      'recommendedZoom': instance.recommendedZoom,
      'recommendedTilt': instance.recommendedTilt,
      'recommendedDistance': instance.recommendedDistance,
      'recommendedHeight': instance.recommendedHeight,
      'lightingDirection': instance.lightingDirection,
      'tips': instance.tips,
      'isFavorite': instance.isFavorite,
    };
