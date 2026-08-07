// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'environment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EnvironmentModel _$EnvironmentModelFromJson(Map<String, dynamic> json) {
  return _EnvironmentModel.fromJson(json);
}

/// @nodoc
mixin _$EnvironmentModel {
  String get id => throw _privateConstructorUsedError;
  String get sceneId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageAsset => throw _privateConstructorUsedError;
  int get posesCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EnvironmentModelCopyWith<EnvironmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnvironmentModelCopyWith<$Res> {
  factory $EnvironmentModelCopyWith(
          EnvironmentModel value, $Res Function(EnvironmentModel) then) =
      _$EnvironmentModelCopyWithImpl<$Res, EnvironmentModel>;
  @useResult
  $Res call(
      {String id,
      String sceneId,
      String title,
      String imageAsset,
      int posesCount});
}

/// @nodoc
class _$EnvironmentModelCopyWithImpl<$Res, $Val extends EnvironmentModel>
    implements $EnvironmentModelCopyWith<$Res> {
  _$EnvironmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sceneId = null,
    Object? title = null,
    Object? imageAsset = null,
    Object? posesCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sceneId: null == sceneId
          ? _value.sceneId
          : sceneId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageAsset: null == imageAsset
          ? _value.imageAsset
          : imageAsset // ignore: cast_nullable_to_non_nullable
              as String,
      posesCount: null == posesCount
          ? _value.posesCount
          : posesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EnvironmentModelImplCopyWith<$Res>
    implements $EnvironmentModelCopyWith<$Res> {
  factory _$$EnvironmentModelImplCopyWith(_$EnvironmentModelImpl value,
          $Res Function(_$EnvironmentModelImpl) then) =
      __$$EnvironmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sceneId,
      String title,
      String imageAsset,
      int posesCount});
}

/// @nodoc
class __$$EnvironmentModelImplCopyWithImpl<$Res>
    extends _$EnvironmentModelCopyWithImpl<$Res, _$EnvironmentModelImpl>
    implements _$$EnvironmentModelImplCopyWith<$Res> {
  __$$EnvironmentModelImplCopyWithImpl(_$EnvironmentModelImpl _value,
      $Res Function(_$EnvironmentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sceneId = null,
    Object? title = null,
    Object? imageAsset = null,
    Object? posesCount = null,
  }) {
    return _then(_$EnvironmentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sceneId: null == sceneId
          ? _value.sceneId
          : sceneId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageAsset: null == imageAsset
          ? _value.imageAsset
          : imageAsset // ignore: cast_nullable_to_non_nullable
              as String,
      posesCount: null == posesCount
          ? _value.posesCount
          : posesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EnvironmentModelImpl implements _EnvironmentModel {
  const _$EnvironmentModelImpl(
      {required this.id,
      required this.sceneId,
      required this.title,
      required this.imageAsset,
      this.posesCount = 0});

  factory _$EnvironmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnvironmentModelImplFromJson(json);

  @override
  final String id;
  @override
  final String sceneId;
  @override
  final String title;
  @override
  final String imageAsset;
  @override
  @JsonKey()
  final int posesCount;

  @override
  String toString() {
    return 'EnvironmentModel(id: $id, sceneId: $sceneId, title: $title, imageAsset: $imageAsset, posesCount: $posesCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnvironmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sceneId, sceneId) || other.sceneId == sceneId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageAsset, imageAsset) ||
                other.imageAsset == imageAsset) &&
            (identical(other.posesCount, posesCount) ||
                other.posesCount == posesCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, sceneId, title, imageAsset, posesCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EnvironmentModelImplCopyWith<_$EnvironmentModelImpl> get copyWith =>
      __$$EnvironmentModelImplCopyWithImpl<_$EnvironmentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EnvironmentModelImplToJson(
      this,
    );
  }
}

abstract class _EnvironmentModel implements EnvironmentModel {
  const factory _EnvironmentModel(
      {required final String id,
      required final String sceneId,
      required final String title,
      required final String imageAsset,
      final int posesCount}) = _$EnvironmentModelImpl;

  factory _EnvironmentModel.fromJson(Map<String, dynamic> json) =
      _$EnvironmentModelImpl.fromJson;

  @override
  String get id;
  @override
  String get sceneId;
  @override
  String get title;
  @override
  String get imageAsset;
  @override
  int get posesCount;
  @override
  @JsonKey(ignore: true)
  _$$EnvironmentModelImplCopyWith<_$EnvironmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
