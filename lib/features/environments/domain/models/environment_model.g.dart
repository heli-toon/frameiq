// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EnvironmentModelImpl _$$EnvironmentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EnvironmentModelImpl(
      id: json['id'] as String,
      sceneId: json['sceneId'] as String,
      title: json['title'] as String,
      imageAsset: json['imageAsset'] as String,
      posesCount: (json['posesCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$EnvironmentModelImplToJson(
        _$EnvironmentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sceneId': instance.sceneId,
      'title': instance.title,
      'imageAsset': instance.imageAsset,
      'posesCount': instance.posesCount,
    };
