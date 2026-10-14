// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_workout_recommendation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AIWorkoutRecommendationModel {

 String get id; String get title; List<String> get targetMuscles; String get difficulty; int get estimatedDuration; int get intensityScore; String get rationale; List<String> get tips; List<ExerciseModel> get exercises;
/// Create a copy of AIWorkoutRecommendationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AIWorkoutRecommendationModelCopyWith<AIWorkoutRecommendationModel> get copyWith => _$AIWorkoutRecommendationModelCopyWithImpl<AIWorkoutRecommendationModel>(this as AIWorkoutRecommendationModel, _$identity);

  /// Serializes this AIWorkoutRecommendationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AIWorkoutRecommendationModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AIWorkoutRecommendationModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&const DeepCollectionEquality().equals(other.targetMuscles, _this.targetMuscles)&&(identical(other.difficulty, _this.difficulty) || other.difficulty == _this.difficulty)&&(identical(other.estimatedDuration, _this.estimatedDuration) || other.estimatedDuration == _this.estimatedDuration)&&(identical(other.intensityScore, _this.intensityScore) || other.intensityScore == _this.intensityScore)&&(identical(other.rationale, _this.rationale) || other.rationale == _this.rationale)&&const DeepCollectionEquality().equals(other.tips, _this.tips)&&const DeepCollectionEquality().equals(other.exercises, _this.exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AIWorkoutRecommendationModel;
  return Object.hash(runtimeType,_this.id,_this.title,const DeepCollectionEquality().hash(_this.targetMuscles),_this.difficulty,_this.estimatedDuration,_this.intensityScore,_this.rationale,const DeepCollectionEquality().hash(_this.tips),const DeepCollectionEquality().hash(_this.exercises));
}

@override
String toString() {
  final _this = this as AIWorkoutRecommendationModel;
  return 'AIWorkoutRecommendationModel(id: ${_this.id}, title: ${_this.title}, targetMuscles: ${_this.targetMuscles}, difficulty: ${_this.difficulty}, estimatedDuration: ${_this.estimatedDuration}, intensityScore: ${_this.intensityScore}, rationale: ${_this.rationale}, tips: ${_this.tips}, exercises: ${_this.exercises})';
}


}

/// @nodoc
abstract mixin class $AIWorkoutRecommendationModelCopyWith<$Res>  {
  factory $AIWorkoutRecommendationModelCopyWith(AIWorkoutRecommendationModel value, $Res Function(AIWorkoutRecommendationModel) _then) = _$AIWorkoutRecommendationModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<String> targetMuscles, String difficulty, int estimatedDuration, int intensityScore, String rationale, List<String> tips, List<ExerciseModel> exercises
});




}
/// @nodoc
class _$AIWorkoutRecommendationModelCopyWithImpl<$Res>
    implements $AIWorkoutRecommendationModelCopyWith<$Res> {
  _$AIWorkoutRecommendationModelCopyWithImpl(this._self, this._then);

  final AIWorkoutRecommendationModel _self;
  final $Res Function(AIWorkoutRecommendationModel) _then;

/// Create a copy of AIWorkoutRecommendationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? targetMuscles = null,Object? difficulty = null,Object? estimatedDuration = null,Object? intensityScore = null,Object? rationale = null,Object? tips = null,Object? exercises = null,}) {
  return _then(AIWorkoutRecommendationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,targetMuscles: null == targetMuscles ? _self.targetMuscles : targetMuscles // ignore: cast_nullable_to_non_nullable
as List<String>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,estimatedDuration: null == estimatedDuration ? _self.estimatedDuration : estimatedDuration // ignore: cast_nullable_to_non_nullable
as int,intensityScore: null == intensityScore ? _self.intensityScore : intensityScore // ignore: cast_nullable_to_non_nullable
as int,rationale: null == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String,tips: null == tips ? _self.tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ExerciseModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [AIWorkoutRecommendationModel].
extension AIWorkoutRecommendationModelPatterns on AIWorkoutRecommendationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AIWorkoutRecommendationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AIWorkoutRecommendationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AIWorkoutRecommendationModel value)  $default,){
final _that = this;
switch (_that) {
case _AIWorkoutRecommendationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AIWorkoutRecommendationModel value)?  $default,){
final _that = this;
switch (_that) {
case _AIWorkoutRecommendationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  List<String> targetMuscles,  String difficulty,  int estimatedDuration,  int intensityScore,  String rationale,  List<String> tips,  List<ExerciseModel> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AIWorkoutRecommendationModel() when $default != null:
return $default(_that.id,_that.title,_that.targetMuscles,_that.difficulty,_that.estimatedDuration,_that.intensityScore,_that.rationale,_that.tips,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  List<String> targetMuscles,  String difficulty,  int estimatedDuration,  int intensityScore,  String rationale,  List<String> tips,  List<ExerciseModel> exercises)  $default,) {final _that = this;
switch (_that) {
case _AIWorkoutRecommendationModel():
return $default(_that.id,_that.title,_that.targetMuscles,_that.difficulty,_that.estimatedDuration,_that.intensityScore,_that.rationale,_that.tips,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  List<String> targetMuscles,  String difficulty,  int estimatedDuration,  int intensityScore,  String rationale,  List<String> tips,  List<ExerciseModel> exercises)?  $default,) {final _that = this;
switch (_that) {
case _AIWorkoutRecommendationModel() when $default != null:
return $default(_that.id,_that.title,_that.targetMuscles,_that.difficulty,_that.estimatedDuration,_that.intensityScore,_that.rationale,_that.tips,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AIWorkoutRecommendationModel extends AIWorkoutRecommendationModel {
  const _AIWorkoutRecommendationModel({required this.id, required this.title,  List<String> targetMuscles = const [], this.difficulty = 'Intermediate', this.estimatedDuration = 45, this.intensityScore = 8, this.rationale = '',  List<String> tips = const [],  List<ExerciseModel> exercises = const []}): _targetMuscles = targetMuscles,_tips = tips,_exercises = exercises,super._();
  factory _AIWorkoutRecommendationModel.fromJson(Map<String, dynamic> json) => _$AIWorkoutRecommendationModelFromJson(json);

@override final  String id;
@override final  String title;
 final  List<String> _targetMuscles;
@override@JsonKey() List<String> get targetMuscles {
  if (_targetMuscles is EqualUnmodifiableListView) return _targetMuscles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_targetMuscles);
}

@override@JsonKey() final  String difficulty;
@override@JsonKey() final  int estimatedDuration;
@override@JsonKey() final  int intensityScore;
@override@JsonKey() final  String rationale;
 final  List<String> _tips;
@override@JsonKey() List<String> get tips {
  if (_tips is EqualUnmodifiableListView) return _tips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tips);
}

 final  List<ExerciseModel> _exercises;
@override@JsonKey() List<ExerciseModel> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of AIWorkoutRecommendationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AIWorkoutRecommendationModelCopyWith<_AIWorkoutRecommendationModel> get copyWith => __$AIWorkoutRecommendationModelCopyWithImpl<_AIWorkoutRecommendationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AIWorkoutRecommendationModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AIWorkoutRecommendationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.targetMuscles, _targetMuscles)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.estimatedDuration, estimatedDuration) || other.estimatedDuration == estimatedDuration)&&(identical(other.intensityScore, intensityScore) || other.intensityScore == intensityScore)&&(identical(other.rationale, rationale) || other.rationale == rationale)&&const DeepCollectionEquality().equals(other.tips, _tips)&&const DeepCollectionEquality().equals(other.exercises, _exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_targetMuscles),difficulty,estimatedDuration,intensityScore,rationale,const DeepCollectionEquality().hash(_tips),const DeepCollectionEquality().hash(_exercises));
}

@override
String toString() {
    return 'AIWorkoutRecommendationModel(id: $id, title: $title, targetMuscles: $targetMuscles, difficulty: $difficulty, estimatedDuration: $estimatedDuration, intensityScore: $intensityScore, rationale: $rationale, tips: $tips, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$AIWorkoutRecommendationModelCopyWith<$Res> implements $AIWorkoutRecommendationModelCopyWith<$Res> {
  factory _$AIWorkoutRecommendationModelCopyWith(_AIWorkoutRecommendationModel value, $Res Function(_AIWorkoutRecommendationModel) _then) = __$AIWorkoutRecommendationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<String> targetMuscles, String difficulty, int estimatedDuration, int intensityScore, String rationale, List<String> tips, List<ExerciseModel> exercises
});




}
/// @nodoc
class __$AIWorkoutRecommendationModelCopyWithImpl<$Res>
    implements _$AIWorkoutRecommendationModelCopyWith<$Res> {
  __$AIWorkoutRecommendationModelCopyWithImpl(this._self, this._then);

  final _AIWorkoutRecommendationModel _self;
  final $Res Function(_AIWorkoutRecommendationModel) _then;

/// Create a copy of AIWorkoutRecommendationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? targetMuscles = null,Object? difficulty = null,Object? estimatedDuration = null,Object? intensityScore = null,Object? rationale = null,Object? tips = null,Object? exercises = null,}) {
  return _then(_AIWorkoutRecommendationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,targetMuscles: null == targetMuscles ? _self._targetMuscles : targetMuscles // ignore: cast_nullable_to_non_nullable
as List<String>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,estimatedDuration: null == estimatedDuration ? _self.estimatedDuration : estimatedDuration // ignore: cast_nullable_to_non_nullable
as int,intensityScore: null == intensityScore ? _self.intensityScore : intensityScore // ignore: cast_nullable_to_non_nullable
as int,rationale: null == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String,tips: null == tips ? _self._tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ExerciseModel>,
  ));
}


}

// dart format on
