// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overlay_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OverlayModelImpl _$$OverlayModelImplFromJson(Map<String, dynamic> json) =>
    _$OverlayModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      overlayAsset: json['overlayAsset'] as String,
      recommendedZoom: (json['recommendedZoom'] as num?)?.toDouble() ?? 1.0,
      recommendedTilt: (json['recommendedTilt'] as num?)?.toDouble() ?? 0.0,
      recommendedDistance: json['recommendedDistance'] as String? ?? '1.5m',
      recommendedHeight: json['recommendedHeight'] as String? ?? 'Eye Level',
      lightingDirection: json['lightingDirection'] as String? ?? 'Center',
      difficulty: json['difficulty'] as String? ?? 'Beginner',
      tips: json['tips'] as String?,
    );

Map<String, dynamic> _$$OverlayModelImplToJson(_$OverlayModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overlayAsset': instance.overlayAsset,
      'recommendedZoom': instance.recommendedZoom,
      'recommendedTilt': instance.recommendedTilt,
      'recommendedDistance': instance.recommendedDistance,
      'recommendedHeight': instance.recommendedHeight,
      'lightingDirection': instance.lightingDirection,
      'difficulty': instance.difficulty,
      'tips': instance.tips,
    };
