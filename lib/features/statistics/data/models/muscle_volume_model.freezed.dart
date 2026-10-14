// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'muscle_volume_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MuscleVolumeModel {

 String get muscleGroup; int get weeklySets; int get optimalMinSets; int get optimalMaxSets; double get symmetryScore; String get status;
/// Create a copy of MuscleVolumeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MuscleVolumeModelCopyWith<MuscleVolumeModel> get copyWith => _$MuscleVolumeModelCopyWithImpl<MuscleVolumeModel>(this as MuscleVolumeModel, _$identity);

  /// Serializes this MuscleVolumeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MuscleVolumeModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MuscleVolumeModel&&(identical(other.muscleGroup, _this.muscleGroup) || other.muscleGroup == _this.muscleGroup)&&(identical(other.weeklySets, _this.weeklySets) || other.weeklySets == _this.weeklySets)&&(identical(other.optimalMinSets, _this.optimalMinSets) || other.optimalMinSets == _this.optimalMinSets)&&(identical(other.optimalMaxSets, _this.optimalMaxSets) || other.optimalMaxSets == _this.optimalMaxSets)&&(identical(other.symmetryScore, _this.symmetryScore) || other.symmetryScore == _this.symmetryScore)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MuscleVolumeModel;
  return Object.hash(runtimeType,_this.muscleGroup,_this.weeklySets,_this.optimalMinSets,_this.optimalMaxSets,_this.symmetryScore,_this.status);
}

@override
String toString() {
  final _this = this as MuscleVolumeModel;
  return 'MuscleVolumeModel(muscleGroup: ${_this.muscleGroup}, weeklySets: ${_this.weeklySets}, optimalMinSets: ${_this.optimalMinSets}, optimalMaxSets: ${_this.optimalMaxSets}, symmetryScore: ${_this.symmetryScore}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $MuscleVolumeModelCopyWith<$Res>  {
  factory $MuscleVolumeModelCopyWith(MuscleVolumeModel value, $Res Function(MuscleVolumeModel) _then) = _$MuscleVolumeModelCopyWithImpl;
@useResult
$Res call({
 String muscleGroup, int weeklySets, int optimalMinSets, int optimalMaxSets, double symmetryScore, String status
});




}
/// @nodoc
class _$MuscleVolumeModelCopyWithImpl<$Res>
    implements $MuscleVolumeModelCopyWith<$Res> {
  _$MuscleVolumeModelCopyWithImpl(this._self, this._then);

  final MuscleVolumeModel _self;
  final $Res Function(MuscleVolumeModel) _then;

/// Create a copy of MuscleVolumeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? muscleGroup = null,Object? weeklySets = null,Object? optimalMinSets = null,Object? optimalMaxSets = null,Object? symmetryScore = null,Object? status = null,}) {
  return _then(MuscleVolumeModel(
muscleGroup: null == muscleGroup ? _self.muscleGroup : muscleGroup // ignore: cast_nullable_to_non_nullable
as String,weeklySets: null == weeklySets ? _self.weeklySets : weeklySets // ignore: cast_nullable_to_non_nullable
as int,optimalMinSets: null == optimalMinSets ? _self.optimalMinSets : optimalMinSets // ignore: cast_nullable_to_non_nullable
as int,optimalMaxSets: null == optimalMaxSets ? _self.optimalMaxSets : optimalMaxSets // ignore: cast_nullable_to_non_nullable
as int,symmetryScore: null == symmetryScore ? _self.symmetryScore : symmetryScore // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MuscleVolumeModel].
extension MuscleVolumeModelPatterns on MuscleVolumeModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MuscleVolumeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MuscleVolumeModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MuscleVolumeModel value)  $default,){
final _that = this;
switch (_that) {
case _MuscleVolumeModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MuscleVolumeModel value)?  $default,){
final _that = this;
switch (_that) {
case _MuscleVolumeModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String muscleGroup,  int weeklySets,  int optimalMinSets,  int optimalMaxSets,  double symmetryScore,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MuscleVolumeModel() when $default != null:
return $default(_that.muscleGroup,_that.weeklySets,_that.optimalMinSets,_that.optimalMaxSets,_that.symmetryScore,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String muscleGroup,  int weeklySets,  int optimalMinSets,  int optimalMaxSets,  double symmetryScore,  String status)  $default,) {final _that = this;
switch (_that) {
case _MuscleVolumeModel():
return $default(_that.muscleGroup,_that.weeklySets,_that.optimalMinSets,_that.optimalMaxSets,_that.symmetryScore,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String muscleGroup,  int weeklySets,  int optimalMinSets,  int optimalMaxSets,  double symmetryScore,  String status)?  $default,) {final _that = this;
switch (_that) {
case _MuscleVolumeModel() when $default != null:
return $default(_that.muscleGroup,_that.weeklySets,_that.optimalMinSets,_that.optimalMaxSets,_that.symmetryScore,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MuscleVolumeModel extends MuscleVolumeModel {
  const _MuscleVolumeModel({required this.muscleGroup, required this.weeklySets, this.optimalMinSets = 10, this.optimalMaxSets = 20, required this.symmetryScore, required this.status}): super._();
  factory _MuscleVolumeModel.fromJson(Map<String, dynamic> json) => _$MuscleVolumeModelFromJson(json);

@override final  String muscleGroup;
@override final  int weeklySets;
@override@JsonKey() final  int optimalMinSets;
@override@JsonKey() final  int optimalMaxSets;
@override final  double symmetryScore;
@override final  String status;

/// Create a copy of MuscleVolumeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MuscleVolumeModelCopyWith<_MuscleVolumeModel> get copyWith => __$MuscleVolumeModelCopyWithImpl<_MuscleVolumeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MuscleVolumeModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MuscleVolumeModel&&(identical(other.muscleGroup, muscleGroup) || other.muscleGroup == muscleGroup)&&(identical(other.weeklySets, weeklySets) || other.weeklySets == weeklySets)&&(identical(other.optimalMinSets, optimalMinSets) || other.optimalMinSets == optimalMinSets)&&(identical(other.optimalMaxSets, optimalMaxSets) || other.optimalMaxSets == optimalMaxSets)&&(identical(other.symmetryScore, symmetryScore) || other.symmetryScore == symmetryScore)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,muscleGroup,weeklySets,optimalMinSets,optimalMaxSets,symmetryScore,status);
}

@override
String toString() {
    return 'MuscleVolumeModel(muscleGroup: $muscleGroup, weeklySets: $weeklySets, optimalMinSets: $optimalMinSets, optimalMaxSets: $optimalMaxSets, symmetryScore: $symmetryScore, status: $status)';
}


}

/// @nodoc
abstract mixin class _$MuscleVolumeModelCopyWith<$Res> implements $MuscleVolumeModelCopyWith<$Res> {
  factory _$MuscleVolumeModelCopyWith(_MuscleVolumeModel value, $Res Function(_MuscleVolumeModel) _then) = __$MuscleVolumeModelCopyWithImpl;
@override @useResult
$Res call({
 String muscleGroup, int weeklySets, int optimalMinSets, int optimalMaxSets, double symmetryScore, String status
});




}
/// @nodoc
class __$MuscleVolumeModelCopyWithImpl<$Res>
    implements _$MuscleVolumeModelCopyWith<$Res> {
  __$MuscleVolumeModelCopyWithImpl(this._self, this._then);

  final _MuscleVolumeModel _self;
  final $Res Function(_MuscleVolumeModel) _then;

/// Create a copy of MuscleVolumeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? muscleGroup = null,Object? weeklySets = null,Object? optimalMinSets = null,Object? optimalMaxSets = null,Object? symmetryScore = null,Object? status = null,}) {
  return _then(_MuscleVolumeModel(
muscleGroup: null == muscleGroup ? _self.muscleGroup : muscleGroup // ignore: cast_nullable_to_non_nullable
as String,weeklySets: null == weeklySets ? _self.weeklySets : weeklySets // ignore: cast_nullable_to_non_nullable
as int,optimalMinSets: null == optimalMinSets ? _self.optimalMinSets : optimalMinSets // ignore: cast_nullable_to_non_nullable
as int,optimalMaxSets: null == optimalMaxSets ? _self.optimalMaxSets : optimalMaxSets // ignore: cast_nullable_to_non_nullable
as int,symmetryScore: null == symmetryScore ? _self.symmetryScore : symmetryScore // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
