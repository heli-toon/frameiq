// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scene_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SceneModel _$SceneModelFromJson(Map<String, dynamic> json) {
  return _SceneModel.fromJson(json);
}

/// @nodoc
mixin _$SceneModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imageAsset => throw _privateConstructorUsedError;
  int get environmentsCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SceneModelCopyWith<SceneModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SceneModelCopyWith<$Res> {
  factory $SceneModelCopyWith(
          SceneModel value, $Res Function(SceneModel) then) =
      _$SceneModelCopyWithImpl<$Res, SceneModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String imageAsset,
      int environmentsCount});
}

/// @nodoc
class _$SceneModelCopyWithImpl<$Res, $Val extends SceneModel>
    implements $SceneModelCopyWith<$Res> {
  _$SceneModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imageAsset = null,
    Object? environmentsCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageAsset: null == imageAsset
          ? _value.imageAsset
          : imageAsset // ignore: cast_nullable_to_non_nullable
              as String,
      environmentsCount: null == environmentsCount
          ? _value.environmentsCount
          : environmentsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SceneModelImplCopyWith<$Res>
    implements $SceneModelCopyWith<$Res> {
  factory _$$SceneModelImplCopyWith(
          _$SceneModelImpl value, $Res Function(_$SceneModelImpl) then) =
      __$$SceneModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String imageAsset,
      int environmentsCount});
}

/// @nodoc
class __$$SceneModelImplCopyWithImpl<$Res>
    extends _$SceneModelCopyWithImpl<$Res, _$SceneModelImpl>
    implements _$$SceneModelImplCopyWith<$Res> {
  __$$SceneModelImplCopyWithImpl(
      _$SceneModelImpl _value, $Res Function(_$SceneModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imageAsset = null,
    Object? environmentsCount = null,
  }) {
    return _then(_$SceneModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageAsset: null == imageAsset
          ? _value.imageAsset
          : imageAsset // ignore: cast_nullable_to_non_nullable
              as String,
      environmentsCount: null == environmentsCount
          ? _value.environmentsCount
          : environmentsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SceneModelImpl implements _SceneModel {
  const _$SceneModelImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageAsset,
      this.environmentsCount = 0});

  factory _$SceneModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SceneModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String imageAsset;
  @override
  @JsonKey()
  final int environmentsCount;

  @override
  String toString() {
    return 'SceneModel(id: $id, title: $title, description: $description, imageAsset: $imageAsset, environmentsCount: $environmentsCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SceneModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageAsset, imageAsset) ||
                other.imageAsset == imageAsset) &&
            (identical(other.environmentsCount, environmentsCount) ||
                other.environmentsCount == environmentsCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, description, imageAsset, environmentsCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SceneModelImplCopyWith<_$SceneModelImpl> get copyWith =>
      __$$SceneModelImplCopyWithImpl<_$SceneModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SceneModelImplToJson(
      this,
    );
  }
}

abstract class _SceneModel implements SceneModel {
  const factory _SceneModel(
      {required final String id,
      required final String title,
      required final String description,
      required final String imageAsset,
      final int environmentsCount}) = _$SceneModelImpl;

  factory _SceneModel.fromJson(Map<String, dynamic> json) =
      _$SceneModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get imageAsset;
  @override
  int get environmentsCount;
  @override
  @JsonKey(ignore: true)
  _$$SceneModelImplCopyWith<_$SceneModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
