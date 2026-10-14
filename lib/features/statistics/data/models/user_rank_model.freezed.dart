// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_rank_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserRankModel {

 int get exerciseId; String get exerciseName; double get currentWeight; double get bodyweight; double get ratio; String get rankTier; int get tierIndex; double get nextTierRatio; double get progressPercentage; int get percentile;
/// Create a copy of UserRankModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserRankModelCopyWith<UserRankModel> get copyWith => _$UserRankModelCopyWithImpl<UserRankModel>(this as UserRankModel, _$identity);

  /// Serializes this UserRankModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserRankModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserRankModel&&(identical(other.exerciseId, _this.exerciseId) || other.exerciseId == _this.exerciseId)&&(identical(other.exerciseName, _this.exerciseName) || other.exerciseName == _this.exerciseName)&&(identical(other.currentWeight, _this.currentWeight) || other.currentWeight == _this.currentWeight)&&(identical(other.bodyweight, _this.bodyweight) || other.bodyweight == _this.bodyweight)&&(identical(other.ratio, _this.ratio) || other.ratio == _this.ratio)&&(identical(other.rankTier, _this.rankTier) || other.rankTier == _this.rankTier)&&(identical(other.tierIndex, _this.tierIndex) || other.tierIndex == _this.tierIndex)&&(identical(other.nextTierRatio, _this.nextTierRatio) || other.nextTierRatio == _this.nextTierRatio)&&(identical(other.progressPercentage, _this.progressPercentage) || other.progressPercentage == _this.progressPercentage)&&(identical(other.percentile, _this.percentile) || other.percentile == _this.percentile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserRankModel;
  return Object.hash(runtimeType,_this.exerciseId,_this.exerciseName,_this.currentWeight,_this.bodyweight,_this.ratio,_this.rankTier,_this.tierIndex,_this.nextTierRatio,_this.progressPercentage,_this.percentile);
}

@override
String toString() {
  final _this = this as UserRankModel;
  return 'UserRankModel(exerciseId: ${_this.exerciseId}, exerciseName: ${_this.exerciseName}, currentWeight: ${_this.currentWeight}, bodyweight: ${_this.bodyweight}, ratio: ${_this.ratio}, rankTier: ${_this.rankTier}, tierIndex: ${_this.tierIndex}, nextTierRatio: ${_this.nextTierRatio}, progressPercentage: ${_this.progressPercentage}, percentile: ${_this.percentile})';
}


}

/// @nodoc
abstract mixin class $UserRankModelCopyWith<$Res>  {
  factory $UserRankModelCopyWith(UserRankModel value, $Res Function(UserRankModel) _then) = _$UserRankModelCopyWithImpl;
@useResult
$Res call({
 int exerciseId, String exerciseName, double currentWeight, double bodyweight, double ratio, String rankTier, int tierIndex, double nextTierRatio, double progressPercentage, int percentile
});




}
/// @nodoc
class _$UserRankModelCopyWithImpl<$Res>
    implements $UserRankModelCopyWith<$Res> {
  _$UserRankModelCopyWithImpl(this._self, this._then);

  final UserRankModel _self;
  final $Res Function(UserRankModel) _then;

/// Create a copy of UserRankModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exerciseId = null,Object? exerciseName = null,Object? currentWeight = null,Object? bodyweight = null,Object? ratio = null,Object? rankTier = null,Object? tierIndex = null,Object? nextTierRatio = null,Object? progressPercentage = null,Object? percentile = null,}) {
  return _then(UserRankModel(
exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as int,exerciseName: null == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String,currentWeight: null == currentWeight ? _self.currentWeight : currentWeight // ignore: cast_nullable_to_non_nullable
as double,bodyweight: null == bodyweight ? _self.bodyweight : bodyweight // ignore: cast_nullable_to_non_nullable
as double,ratio: null == ratio ? _self.ratio : ratio // ignore: cast_nullable_to_non_nullable
as double,rankTier: null == rankTier ? _self.rankTier : rankTier // ignore: cast_nullable_to_non_nullable
as String,tierIndex: null == tierIndex ? _self.tierIndex : tierIndex // ignore: cast_nullable_to_non_nullable
as int,nextTierRatio: null == nextTierRatio ? _self.nextTierRatio : nextTierRatio // ignore: cast_nullable_to_non_nullable
as double,progressPercentage: null == progressPercentage ? _self.progressPercentage : progressPercentage // ignore: cast_nullable_to_non_nullable
as double,percentile: null == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserRankModel].
extension UserRankModelPatterns on UserRankModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserRankModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserRankModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserRankModel value)  $default,){
final _that = this;
switch (_that) {
case _UserRankModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserRankModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserRankModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int exerciseId,  String exerciseName,  double currentWeight,  double bodyweight,  double ratio,  String rankTier,  int tierIndex,  double nextTierRatio,  double progressPercentage,  int percentile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserRankModel() when $default != null:
return $default(_that.exerciseId,_that.exerciseName,_that.currentWeight,_that.bodyweight,_that.ratio,_that.rankTier,_that.tierIndex,_that.nextTierRatio,_that.progressPercentage,_that.percentile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int exerciseId,  String exerciseName,  double currentWeight,  double bodyweight,  double ratio,  String rankTier,  int tierIndex,  double nextTierRatio,  double progressPercentage,  int percentile)  $default,) {final _that = this;
switch (_that) {
case _UserRankModel():
return $default(_that.exerciseId,_that.exerciseName,_that.currentWeight,_that.bodyweight,_that.ratio,_that.rankTier,_that.tierIndex,_that.nextTierRatio,_that.progressPercentage,_that.percentile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int exerciseId,  String exerciseName,  double currentWeight,  double bodyweight,  double ratio,  String rankTier,  int tierIndex,  double nextTierRatio,  double progressPercentage,  int percentile)?  $default,) {final _that = this;
switch (_that) {
case _UserRankModel() when $default != null:
return $default(_that.exerciseId,_that.exerciseName,_that.currentWeight,_that.bodyweight,_that.ratio,_that.rankTier,_that.tierIndex,_that.nextTierRatio,_that.progressPercentage,_that.percentile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserRankModel extends UserRankModel {
  const _UserRankModel({required this.exerciseId, required this.exerciseName, required this.currentWeight, required this.bodyweight, required this.ratio, required this.rankTier, required this.tierIndex, required this.nextTierRatio, required this.progressPercentage, required this.percentile}): super._();
  factory _UserRankModel.fromJson(Map<String, dynamic> json) => _$UserRankModelFromJson(json);

@override final  int exerciseId;
@override final  String exerciseName;
@override final  double currentWeight;
@override final  double bodyweight;
@override final  double ratio;
@override final  String rankTier;
@override final  int tierIndex;
@override final  double nextTierRatio;
@override final  double progressPercentage;
@override final  int percentile;

/// Create a copy of UserRankModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserRankModelCopyWith<_UserRankModel> get copyWith => __$UserRankModelCopyWithImpl<_UserRankModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserRankModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserRankModel&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.currentWeight, currentWeight) || other.currentWeight == currentWeight)&&(identical(other.bodyweight, bodyweight) || other.bodyweight == bodyweight)&&(identical(other.ratio, ratio) || other.ratio == ratio)&&(identical(other.rankTier, rankTier) || other.rankTier == rankTier)&&(identical(other.tierIndex, tierIndex) || other.tierIndex == tierIndex)&&(identical(other.nextTierRatio, nextTierRatio) || other.nextTierRatio == nextTierRatio)&&(identical(other.progressPercentage, progressPercentage) || other.progressPercentage == progressPercentage)&&(identical(other.percentile, percentile) || other.percentile == percentile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,exerciseId,exerciseName,currentWeight,bodyweight,ratio,rankTier,tierIndex,nextTierRatio,progressPercentage,percentile);
}

@override
String toString() {
    return 'UserRankModel(exerciseId: $exerciseId, exerciseName: $exerciseName, currentWeight: $currentWeight, bodyweight: $bodyweight, ratio: $ratio, rankTier: $rankTier, tierIndex: $tierIndex, nextTierRatio: $nextTierRatio, progressPercentage: $progressPercentage, percentile: $percentile)';
}


}

/// @nodoc
abstract mixin class _$UserRankModelCopyWith<$Res> implements $UserRankModelCopyWith<$Res> {
  factory _$UserRankModelCopyWith(_UserRankModel value, $Res Function(_UserRankModel) _then) = __$UserRankModelCopyWithImpl;
@override @useResult
$Res call({
 int exerciseId, String exerciseName, double currentWeight, double bodyweight, double ratio, String rankTier, int tierIndex, double nextTierRatio, double progressPercentage, int percentile
});




}
/// @nodoc
class __$UserRankModelCopyWithImpl<$Res>
    implements _$UserRankModelCopyWith<$Res> {
  __$UserRankModelCopyWithImpl(this._self, this._then);

  final _UserRankModel _self;
  final $Res Function(_UserRankModel) _then;

/// Create a copy of UserRankModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exerciseId = null,Object? exerciseName = null,Object? currentWeight = null,Object? bodyweight = null,Object? ratio = null,Object? rankTier = null,Object? tierIndex = null,Object? nextTierRatio = null,Object? progressPercentage = null,Object? percentile = null,}) {
  return _then(_UserRankModel(
exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as int,exerciseName: null == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String,currentWeight: null == currentWeight ? _self.currentWeight : currentWeight // ignore: cast_nullable_to_non_nullable
as double,bodyweight: null == bodyweight ? _self.bodyweight : bodyweight // ignore: cast_nullable_to_non_nullable
as double,ratio: null == ratio ? _self.ratio : ratio // ignore: cast_nullable_to_non_nullable
as double,rankTier: null == rankTier ? _self.rankTier : rankTier // ignore: cast_nullable_to_non_nullable
as String,tierIndex: null == tierIndex ? _self.tierIndex : tierIndex // ignore: cast_nullable_to_non_nullable
as int,nextTierRatio: null == nextTierRatio ? _self.nextTierRatio : nextTierRatio // ignore: cast_nullable_to_non_nullable
as double,progressPercentage: null == progressPercentage ? _self.progressPercentage : progressPercentage // ignore: cast_nullable_to_non_nullable
as double,percentile: null == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
