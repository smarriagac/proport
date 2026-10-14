// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_set_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseSetModel {

 int get setNumber; int get reps; double get weightKg; int get restSeconds; int? get durationSeconds; bool get isCompleted;
/// Create a copy of ExerciseSetModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseSetModelCopyWith<ExerciseSetModel> get copyWith => _$ExerciseSetModelCopyWithImpl<ExerciseSetModel>(this as ExerciseSetModel, _$identity);

  /// Serializes this ExerciseSetModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ExerciseSetModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseSetModel&&(identical(other.setNumber, _this.setNumber) || other.setNumber == _this.setNumber)&&(identical(other.reps, _this.reps) || other.reps == _this.reps)&&(identical(other.weightKg, _this.weightKg) || other.weightKg == _this.weightKg)&&(identical(other.restSeconds, _this.restSeconds) || other.restSeconds == _this.restSeconds)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds)&&(identical(other.isCompleted, _this.isCompleted) || other.isCompleted == _this.isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ExerciseSetModel;
  return Object.hash(runtimeType,_this.setNumber,_this.reps,_this.weightKg,_this.restSeconds,_this.durationSeconds,_this.isCompleted);
}

@override
String toString() {
  final _this = this as ExerciseSetModel;
  return 'ExerciseSetModel(setNumber: ${_this.setNumber}, reps: ${_this.reps}, weightKg: ${_this.weightKg}, restSeconds: ${_this.restSeconds}, durationSeconds: ${_this.durationSeconds}, isCompleted: ${_this.isCompleted})';
}


}

/// @nodoc
abstract mixin class $ExerciseSetModelCopyWith<$Res>  {
  factory $ExerciseSetModelCopyWith(ExerciseSetModel value, $Res Function(ExerciseSetModel) _then) = _$ExerciseSetModelCopyWithImpl;
@useResult
$Res call({
 int setNumber, int reps, double weightKg, int restSeconds, int? durationSeconds, bool isCompleted
});




}
/// @nodoc
class _$ExerciseSetModelCopyWithImpl<$Res>
    implements $ExerciseSetModelCopyWith<$Res> {
  _$ExerciseSetModelCopyWithImpl(this._self, this._then);

  final ExerciseSetModel _self;
  final $Res Function(ExerciseSetModel) _then;

/// Create a copy of ExerciseSetModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? setNumber = null,Object? reps = null,Object? weightKg = null,Object? restSeconds = null,Object? durationSeconds = freezed,Object? isCompleted = null,}) {
  return _then(ExerciseSetModel(
setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,restSeconds: null == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseSetModel].
extension ExerciseSetModelPatterns on ExerciseSetModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseSetModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseSetModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseSetModel value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseSetModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseSetModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseSetModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int setNumber,  int reps,  double weightKg,  int restSeconds,  int? durationSeconds,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseSetModel() when $default != null:
return $default(_that.setNumber,_that.reps,_that.weightKg,_that.restSeconds,_that.durationSeconds,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int setNumber,  int reps,  double weightKg,  int restSeconds,  int? durationSeconds,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _ExerciseSetModel():
return $default(_that.setNumber,_that.reps,_that.weightKg,_that.restSeconds,_that.durationSeconds,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int setNumber,  int reps,  double weightKg,  int restSeconds,  int? durationSeconds,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseSetModel() when $default != null:
return $default(_that.setNumber,_that.reps,_that.weightKg,_that.restSeconds,_that.durationSeconds,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExerciseSetModel extends ExerciseSetModel {
  const _ExerciseSetModel({this.setNumber = 1, this.reps = 10, this.weightKg = 0.0, this.restSeconds = 90, this.durationSeconds, this.isCompleted = false}): super._();
  factory _ExerciseSetModel.fromJson(Map<String, dynamic> json) => _$ExerciseSetModelFromJson(json);

@override@JsonKey() final  int setNumber;
@override@JsonKey() final  int reps;
@override@JsonKey() final  double weightKg;
@override@JsonKey() final  int restSeconds;
@override final  int? durationSeconds;
@override@JsonKey() final  bool isCompleted;

/// Create a copy of ExerciseSetModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseSetModelCopyWith<_ExerciseSetModel> get copyWith => __$ExerciseSetModelCopyWithImpl<_ExerciseSetModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExerciseSetModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseSetModel&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.restSeconds, restSeconds) || other.restSeconds == restSeconds)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,setNumber,reps,weightKg,restSeconds,durationSeconds,isCompleted);
}

@override
String toString() {
    return 'ExerciseSetModel(setNumber: $setNumber, reps: $reps, weightKg: $weightKg, restSeconds: $restSeconds, durationSeconds: $durationSeconds, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$ExerciseSetModelCopyWith<$Res> implements $ExerciseSetModelCopyWith<$Res> {
  factory _$ExerciseSetModelCopyWith(_ExerciseSetModel value, $Res Function(_ExerciseSetModel) _then) = __$ExerciseSetModelCopyWithImpl;
@override @useResult
$Res call({
 int setNumber, int reps, double weightKg, int restSeconds, int? durationSeconds, bool isCompleted
});




}
/// @nodoc
class __$ExerciseSetModelCopyWithImpl<$Res>
    implements _$ExerciseSetModelCopyWith<$Res> {
  __$ExerciseSetModelCopyWithImpl(this._self, this._then);

  final _ExerciseSetModel _self;
  final $Res Function(_ExerciseSetModel) _then;

/// Create a copy of ExerciseSetModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? setNumber = null,Object? reps = null,Object? weightKg = null,Object? restSeconds = null,Object? durationSeconds = freezed,Object? isCompleted = null,}) {
  return _then(_ExerciseSetModel(
setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,reps: null == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,restSeconds: null == restSeconds ? _self.restSeconds : restSeconds // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
