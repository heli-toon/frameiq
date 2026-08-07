// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pose_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PoseModel _$PoseModelFromJson(Map<String, dynamic> json) {
  return _PoseModel.fromJson(json);
}

/// @nodoc
mixin _$PoseModel {
  String get id => throw _privateConstructorUsedError;
  String get environmentId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get category =>
      throw _privateConstructorUsedError; // Portrait, Couple, Solo, Sunset, Architectural
  String get previewImage => throw _privateConstructorUsedError;
  String get overlayAsset => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  String get instructions => throw _privateConstructorUsedError;
  double get recommendedZoom => throw _privateConstructorUsedError;
  double get recommendedTilt => throw _privateConstructorUsedError;
  String get recommendedDistance => throw _privateConstructorUsedError;
  String get recommendedHeight => throw _privateConstructorUsedError;
  String get lightingDirection => throw _privateConstructorUsedError;
  String? get tips => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PoseModelCopyWith<PoseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoseModelCopyWith<$Res> {
  factory $PoseModelCopyWith(PoseModel value, $Res Function(PoseModel) then) =
      _$PoseModelCopyWithImpl<$Res, PoseModel>;
  @useResult
  $Res call(
      {String id,
      String environmentId,
      String title,
      String category,
      String previewImage,
      String overlayAsset,
      String difficulty,
      String instructions,
      double recommendedZoom,
      double recommendedTilt,
      String recommendedDistance,
      String recommendedHeight,
      String lightingDirection,
      String? tips,
      bool isFavorite});
}

/// @nodoc
class _$PoseModelCopyWithImpl<$Res, $Val extends PoseModel>
    implements $PoseModelCopyWith<$Res> {
  _$PoseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? environmentId = null,
    Object? title = null,
    Object? category = null,
    Object? previewImage = null,
    Object? overlayAsset = null,
    Object? difficulty = null,
    Object? instructions = null,
    Object? recommendedZoom = null,
    Object? recommendedTilt = null,
    Object? recommendedDistance = null,
    Object? recommendedHeight = null,
    Object? lightingDirection = null,
    Object? tips = freezed,
    Object? isFavorite = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      environmentId: null == environmentId
          ? _value.environmentId
          : environmentId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      previewImage: null == previewImage
          ? _value.previewImage
          : previewImage // ignore: cast_nullable_to_non_nullable
              as String,
      overlayAsset: null == overlayAsset
          ? _value.overlayAsset
          : overlayAsset // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedZoom: null == recommendedZoom
          ? _value.recommendedZoom
          : recommendedZoom // ignore: cast_nullable_to_non_nullable
              as double,
      recommendedTilt: null == recommendedTilt
          ? _value.recommendedTilt
          : recommendedTilt // ignore: cast_nullable_to_non_nullable
              as double,
      recommendedDistance: null == recommendedDistance
          ? _value.recommendedDistance
          : recommendedDistance // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedHeight: null == recommendedHeight
          ? _value.recommendedHeight
          : recommendedHeight // ignore: cast_nullable_to_non_nullable
              as String,
      lightingDirection: null == lightingDirection
          ? _value.lightingDirection
          : lightingDirection // ignore: cast_nullable_to_non_nullable
              as String,
      tips: freezed == tips
          ? _value.tips
          : tips // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PoseModelImplCopyWith<$Res>
    implements $PoseModelCopyWith<$Res> {
  factory _$$PoseModelImplCopyWith(
          _$PoseModelImpl value, $Res Function(_$PoseModelImpl) then) =
      __$$PoseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String environmentId,
      String title,
      String category,
      String previewImage,
      String overlayAsset,
      String difficulty,
      String instructions,
      double recommendedZoom,
      double recommendedTilt,
      String recommendedDistance,
      String recommendedHeight,
      String lightingDirection,
      String? tips,
      bool isFavorite});
}

/// @nodoc
class __$$PoseModelImplCopyWithImpl<$Res>
    extends _$PoseModelCopyWithImpl<$Res, _$PoseModelImpl>
    implements _$$PoseModelImplCopyWith<$Res> {
  __$$PoseModelImplCopyWithImpl(
      _$PoseModelImpl _value, $Res Function(_$PoseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? environmentId = null,
    Object? title = null,
    Object? category = null,
    Object? previewImage = null,
    Object? overlayAsset = null,
    Object? difficulty = null,
    Object? instructions = null,
    Object? recommendedZoom = null,
    Object? recommendedTilt = null,
    Object? recommendedDistance = null,
    Object? recommendedHeight = null,
    Object? lightingDirection = null,
    Object? tips = freezed,
    Object? isFavorite = null,
  }) {
    return _then(_$PoseModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      environmentId: null == environmentId
          ? _value.environmentId
          : environmentId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      previewImage: null == previewImage
          ? _value.previewImage
          : previewImage // ignore: cast_nullable_to_non_nullable
              as String,
      overlayAsset: null == overlayAsset
          ? _value.overlayAsset
          : overlayAsset // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedZoom: null == recommendedZoom
          ? _value.recommendedZoom
          : recommendedZoom // ignore: cast_nullable_to_non_nullable
              as double,
      recommendedTilt: null == recommendedTilt
          ? _value.recommendedTilt
          : recommendedTilt // ignore: cast_nullable_to_non_nullable
              as double,
      recommendedDistance: null == recommendedDistance
          ? _value.recommendedDistance
          : recommendedDistance // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedHeight: null == recommendedHeight
          ? _value.recommendedHeight
          : recommendedHeight // ignore: cast_nullable_to_non_nullable
              as String,
      lightingDirection: null == lightingDirection
          ? _value.lightingDirection
          : lightingDirection // ignore: cast_nullable_to_non_nullable
              as String,
      tips: freezed == tips
          ? _value.tips
          : tips // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PoseModelImpl implements _PoseModel {
  const _$PoseModelImpl(
      {required this.id,
      required this.environmentId,
      required this.title,
      required this.category,
      required this.previewImage,
      required this.overlayAsset,
      this.difficulty = 'Beginner',
      this.instructions = '',
      this.recommendedZoom = 1.0,
      this.recommendedTilt = 0.0,
      this.recommendedDistance = '1.5m',
      this.recommendedHeight = 'Eye Level',
      this.lightingDirection = 'Front',
      this.tips,
      this.isFavorite = false});

  factory _$PoseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PoseModelImplFromJson(json);

  @override
  final String id;
  @override
  final String environmentId;
  @override
  final String title;
  @override
  final String category;
// Portrait, Couple, Solo, Sunset, Architectural
  @override
  final String previewImage;
  @override
  final String overlayAsset;
  @override
  @JsonKey()
  final String difficulty;
  @override
  @JsonKey()
  final String instructions;
  @override
  @JsonKey()
  final double recommendedZoom;
  @override
  @JsonKey()
  final double recommendedTilt;
  @override
  @JsonKey()
  final String recommendedDistance;
  @override
  @JsonKey()
  final String recommendedHeight;
  @override
  @JsonKey()
  final String lightingDirection;
  @override
  final String? tips;
  @override
  @JsonKey()
  final bool isFavorite;

  @override
  String toString() {
    return 'PoseModel(id: $id, environmentId: $environmentId, title: $title, category: $category, previewImage: $previewImage, overlayAsset: $overlayAsset, difficulty: $difficulty, instructions: $instructions, recommendedZoom: $recommendedZoom, recommendedTilt: $recommendedTilt, recommendedDistance: $recommendedDistance, recommendedHeight: $recommendedHeight, lightingDirection: $lightingDirection, tips: $tips, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.environmentId, environmentId) ||
                other.environmentId == environmentId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.previewImage, previewImage) ||
                other.previewImage == previewImage) &&
            (identical(other.overlayAsset, overlayAsset) ||
                other.overlayAsset == overlayAsset) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            (identical(other.recommendedZoom, recommendedZoom) ||
                other.recommendedZoom == recommendedZoom) &&
            (identical(other.recommendedTilt, recommendedTilt) ||
                other.recommendedTilt == recommendedTilt) &&
            (identical(other.recommendedDistance, recommendedDistance) ||
                other.recommendedDistance == recommendedDistance) &&
            (identical(other.recommendedHeight, recommendedHeight) ||
                other.recommendedHeight == recommendedHeight) &&
            (identical(other.lightingDirection, lightingDirection) ||
                other.lightingDirection == lightingDirection) &&
            (identical(other.tips, tips) || other.tips == tips) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      environmentId,
      title,
      category,
      previewImage,
      overlayAsset,
      difficulty,
      instructions,
      recommendedZoom,
      recommendedTilt,
      recommendedDistance,
      recommendedHeight,
      lightingDirection,
      tips,
      isFavorite);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PoseModelImplCopyWith<_$PoseModelImpl> get copyWith =>
      __$$PoseModelImplCopyWithImpl<_$PoseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PoseModelImplToJson(
      this,
    );
  }
}

abstract class _PoseModel implements PoseModel {
  const factory _PoseModel(
      {required final String id,
      required final String environmentId,
      required final String title,
      required final String category,
      required final String previewImage,
      required final String overlayAsset,
      final String difficulty,
      final String instructions,
      final double recommendedZoom,
      final double recommendedTilt,
      final String recommendedDistance,
      final String recommendedHeight,
      final String lightingDirection,
      final String? tips,
      final bool isFavorite}) = _$PoseModelImpl;

  factory _PoseModel.fromJson(Map<String, dynamic> json) =
      _$PoseModelImpl.fromJson;

  @override
  String get id;
  @override
  String get environmentId;
  @override
  String get title;
  @override
  String get category;
  @override // Portrait, Couple, Solo, Sunset, Architectural
  String get previewImage;
  @override
  String get overlayAsset;
  @override
  String get difficulty;
  @override
  String get instructions;
  @override
  double get recommendedZoom;
  @override
  double get recommendedTilt;
  @override
  String get recommendedDistance;
  @override
  String get recommendedHeight;
  @override
  String get lightingDirection;
  @override
  String? get tips;
  @override
  bool get isFavorite;
  @override
  @JsonKey(ignore: true)
  _$$PoseModelImplCopyWith<_$PoseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
