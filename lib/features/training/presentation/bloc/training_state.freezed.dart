// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrainingState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TrainingState()';
}


}

/// @nodoc
class $TrainingStateCopyWith<$Res>  {
$TrainingStateCopyWith(TrainingState _, $Res Function(TrainingState) __);
}


/// Adds pattern-matching-related methods to [TrainingState].
extension TrainingStatePatterns on TrainingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<WorkoutPlan> plans,  WorkoutPlan? selectedPlan,  TrainingSession? activeSession,  int restTimerSeconds,  bool isRestTimerActive,  List<TrainingSession> completedSessions)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.plans,_that.selectedPlan,_that.activeSession,_that.restTimerSeconds,_that.isRestTimerActive,_that.completedSessions);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<WorkoutPlan> plans,  WorkoutPlan? selectedPlan,  TrainingSession? activeSession,  int restTimerSeconds,  bool isRestTimerActive,  List<TrainingSession> completedSessions)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.plans,_that.selectedPlan,_that.activeSession,_that.restTimerSeconds,_that.isRestTimerActive,_that.completedSessions);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<WorkoutPlan> plans,  WorkoutPlan? selectedPlan,  TrainingSession? activeSession,  int restTimerSeconds,  bool isRestTimerActive,  List<TrainingSession> completedSessions)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.plans,_that.selectedPlan,_that.activeSession,_that.restTimerSeconds,_that.isRestTimerActive,_that.completedSessions);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements TrainingState {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TrainingState.initial()';
}


}




/// @nodoc


class _Loading implements TrainingState {
  const _Loading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TrainingState.loading()';
}


}




/// @nodoc


class _Loaded implements TrainingState {
  const _Loaded({required  List<WorkoutPlan> plans, this.selectedPlan, this.activeSession, this.restTimerSeconds = 0, this.isRestTimerActive = false,  List<TrainingSession> completedSessions = const []}): _plans = plans,_completedSessions = completedSessions;
  

 final  List<WorkoutPlan> _plans;
 List<WorkoutPlan> get plans {
  if (_plans is EqualUnmodifiableListView) return _plans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plans);
}

 final  WorkoutPlan? selectedPlan;
 final  TrainingSession? activeSession;
@JsonKey() final  int restTimerSeconds;
@JsonKey() final  bool isRestTimerActive;
 final  List<TrainingSession> _completedSessions;
@JsonKey() List<TrainingSession> get completedSessions {
  if (_completedSessions is EqualUnmodifiableListView) return _completedSessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_completedSessions);
}


/// Create a copy of TrainingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other.plans, _plans)&&(identical(other.selectedPlan, selectedPlan) || other.selectedPlan == selectedPlan)&&(identical(other.activeSession, activeSession) || other.activeSession == activeSession)&&(identical(other.restTimerSeconds, restTimerSeconds) || other.restTimerSeconds == restTimerSeconds)&&(identical(other.isRestTimerActive, isRestTimerActive) || other.isRestTimerActive == isRestTimerActive)&&const DeepCollectionEquality().equals(other.completedSessions, _completedSessions));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_plans),selectedPlan,activeSession,restTimerSeconds,isRestTimerActive,const DeepCollectionEquality().hash(_completedSessions));
}

@override
String toString() {
    return 'TrainingState.loaded(plans: $plans, selectedPlan: $selectedPlan, activeSession: $activeSession, restTimerSeconds: $restTimerSeconds, isRestTimerActive: $isRestTimerActive, completedSessions: $completedSessions)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $TrainingStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<WorkoutPlan> plans, WorkoutPlan? selectedPlan, TrainingSession? activeSession, int restTimerSeconds, bool isRestTimerActive, List<TrainingSession> completedSessions
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of TrainingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? plans = null,Object? selectedPlan = freezed,Object? activeSession = freezed,Object? restTimerSeconds = null,Object? isRestTimerActive = null,Object? completedSessions = null,}) {
  return _then(_Loaded(
plans: null == plans ? _self._plans : plans // ignore: cast_nullable_to_non_nullable
as List<WorkoutPlan>,selectedPlan: freezed == selectedPlan ? _self.selectedPlan : selectedPlan // ignore: cast_nullable_to_non_nullable
as WorkoutPlan?,activeSession: freezed == activeSession ? _self.activeSession : activeSession // ignore: cast_nullable_to_non_nullable
as TrainingSession?,restTimerSeconds: null == restTimerSeconds ? _self.restTimerSeconds : restTimerSeconds // ignore: cast_nullable_to_non_nullable
as int,isRestTimerActive: null == isRestTimerActive ? _self.isRestTimerActive : isRestTimerActive // ignore: cast_nullable_to_non_nullable
as bool,completedSessions: null == completedSessions ? _self._completedSessions : completedSessions // ignore: cast_nullable_to_non_nullable
as List<TrainingSession>,
  ));
}


}

/// @nodoc


class _Error implements TrainingState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of TrainingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'TrainingState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $TrainingStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of TrainingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
