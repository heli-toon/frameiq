// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SceneModelImpl _$$SceneModelImplFromJson(Map<String, dynamic> json) =>
    _$SceneModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageAsset: json['imageAsset'] as String,
      environmentsCount: (json['environmentsCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SceneModelImplToJson(_$SceneModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageAsset': instance.imageAsset,
      'environmentsCount': instance.environmentsCount,
    };
