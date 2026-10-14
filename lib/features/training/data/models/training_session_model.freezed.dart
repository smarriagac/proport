// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingSessionModel {

 int get dayOfWeek; String get name; String get description; List<ExerciseModel> get exercises; bool get isCompleted; DateTime? get completedAt; int? get durationMinutes;
/// Create a copy of TrainingSessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingSessionModelCopyWith<TrainingSessionModel> get copyWith => _$TrainingSessionModelCopyWithImpl<TrainingSessionModel>(this as TrainingSessionModel, _$identity);

  /// Serializes this TrainingSessionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TrainingSessionModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingSessionModel&&(identical(other.dayOfWeek, _this.dayOfWeek) || other.dayOfWeek == _this.dayOfWeek)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&const DeepCollectionEquality().equals(other.exercises, _this.exercises)&&(identical(other.isCompleted, _this.isCompleted) || other.isCompleted == _this.isCompleted)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt)&&(identical(other.durationMinutes, _this.durationMinutes) || other.durationMinutes == _this.durationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TrainingSessionModel;
  return Object.hash(runtimeType,_this.dayOfWeek,_this.name,_this.description,const DeepCollectionEquality().hash(_this.exercises),_this.isCompleted,_this.completedAt,_this.durationMinutes);
}

@override
String toString() {
  final _this = this as TrainingSessionModel;
  return 'TrainingSessionModel(dayOfWeek: ${_this.dayOfWeek}, name: ${_this.name}, description: ${_this.description}, exercises: ${_this.exercises}, isCompleted: ${_this.isCompleted}, completedAt: ${_this.completedAt}, durationMinutes: ${_this.durationMinutes})';
}


}

/// @nodoc
abstract mixin class $TrainingSessionModelCopyWith<$Res>  {
  factory $TrainingSessionModelCopyWith(TrainingSessionModel value, $Res Function(TrainingSessionModel) _then) = _$TrainingSessionModelCopyWithImpl;
@useResult
$Res call({
 int dayOfWeek, String name, String description, List<ExerciseModel> exercises, bool isCompleted, DateTime? completedAt, int? durationMinutes
});




}
/// @nodoc
class _$TrainingSessionModelCopyWithImpl<$Res>
    implements $TrainingSessionModelCopyWith<$Res> {
  _$TrainingSessionModelCopyWithImpl(this._self, this._then);

  final TrainingSessionModel _self;
  final $Res Function(TrainingSessionModel) _then;

/// Create a copy of TrainingSessionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayOfWeek = null,Object? name = null,Object? description = null,Object? exercises = null,Object? isCompleted = null,Object? completedAt = freezed,Object? durationMinutes = freezed,}) {
  return _then(TrainingSessionModel(
dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ExerciseModel>,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingSessionModel].
extension TrainingSessionModelPatterns on TrainingSessionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingSessionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingSessionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingSessionModel value)  $default,){
final _that = this;
switch (_that) {
case _TrainingSessionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingSessionModel value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingSessionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dayOfWeek,  String name,  String description,  List<ExerciseModel> exercises,  bool isCompleted,  DateTime? completedAt,  int? durationMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingSessionModel() when $default != null:
return $default(_that.dayOfWeek,_that.name,_that.description,_that.exercises,_that.isCompleted,_that.completedAt,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dayOfWeek,  String name,  String description,  List<ExerciseModel> exercises,  bool isCompleted,  DateTime? completedAt,  int? durationMinutes)  $default,) {final _that = this;
switch (_that) {
case _TrainingSessionModel():
return $default(_that.dayOfWeek,_that.name,_that.description,_that.exercises,_that.isCompleted,_that.completedAt,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dayOfWeek,  String name,  String description,  List<ExerciseModel> exercises,  bool isCompleted,  DateTime? completedAt,  int? durationMinutes)?  $default,) {final _that = this;
switch (_that) {
case _TrainingSessionModel() when $default != null:
return $default(_that.dayOfWeek,_that.name,_that.description,_that.exercises,_that.isCompleted,_that.completedAt,_that.durationMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingSessionModel extends TrainingSessionModel {
  const _TrainingSessionModel({required this.dayOfWeek, required this.name, this.description = '',  List<ExerciseModel> exercises = const [], this.isCompleted = false, this.completedAt, this.durationMinutes}): _exercises = exercises,super._();
  factory _TrainingSessionModel.fromJson(Map<String, dynamic> json) => _$TrainingSessionModelFromJson(json);

@override final  int dayOfWeek;
@override final  String name;
@override@JsonKey() final  String description;
 final  List<ExerciseModel> _exercises;
@override@JsonKey() List<ExerciseModel> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}

@override@JsonKey() final  bool isCompleted;
@override final  DateTime? completedAt;
@override final  int? durationMinutes;

/// Create a copy of TrainingSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingSessionModelCopyWith<_TrainingSessionModel> get copyWith => __$TrainingSessionModelCopyWithImpl<_TrainingSessionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingSessionModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingSessionModel&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.exercises, _exercises)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,dayOfWeek,name,description,const DeepCollectionEquality().hash(_exercises),isCompleted,completedAt,durationMinutes);
}

@override
String toString() {
    return 'TrainingSessionModel(dayOfWeek: $dayOfWeek, name: $name, description: $description, exercises: $exercises, isCompleted: $isCompleted, completedAt: $completedAt, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class _$TrainingSessionModelCopyWith<$Res> implements $TrainingSessionModelCopyWith<$Res> {
  factory _$TrainingSessionModelCopyWith(_TrainingSessionModel value, $Res Function(_TrainingSessionModel) _then) = __$TrainingSessionModelCopyWithImpl;
@override @useResult
$Res call({
 int dayOfWeek, String name, String description, List<ExerciseModel> exercises, bool isCompleted, DateTime? completedAt, int? durationMinutes
});




}
/// @nodoc
class __$TrainingSessionModelCopyWithImpl<$Res>
    implements _$TrainingSessionModelCopyWith<$Res> {
  __$TrainingSessionModelCopyWithImpl(this._self, this._then);

  final _TrainingSessionModel _self;
  final $Res Function(_TrainingSessionModel) _then;

/// Create a copy of TrainingSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayOfWeek = null,Object? name = null,Object? description = null,Object? exercises = null,Object? isCompleted = null,Object? completedAt = freezed,Object? durationMinutes = freezed,}) {
  return _then(_TrainingSessionModel(
dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ExerciseModel>,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationMinutes: freezed == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
