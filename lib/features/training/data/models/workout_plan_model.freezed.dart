// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutPlanModel {

 String get planId; String get name; String get description; String get ruleset; String get equipmentCategory; String get level; String get gender; int get durationPerSession; List<TrainingSessionModel> get trainingSessions; String? get thumbnailURL;
/// Create a copy of WorkoutPlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutPlanModelCopyWith<WorkoutPlanModel> get copyWith => _$WorkoutPlanModelCopyWithImpl<WorkoutPlanModel>(this as WorkoutPlanModel, _$identity);

  /// Serializes this WorkoutPlanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WorkoutPlanModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutPlanModel&&(identical(other.planId, _this.planId) || other.planId == _this.planId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.ruleset, _this.ruleset) || other.ruleset == _this.ruleset)&&(identical(other.equipmentCategory, _this.equipmentCategory) || other.equipmentCategory == _this.equipmentCategory)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.gender, _this.gender) || other.gender == _this.gender)&&(identical(other.durationPerSession, _this.durationPerSession) || other.durationPerSession == _this.durationPerSession)&&const DeepCollectionEquality().equals(other.trainingSessions, _this.trainingSessions)&&(identical(other.thumbnailURL, _this.thumbnailURL) || other.thumbnailURL == _this.thumbnailURL));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WorkoutPlanModel;
  return Object.hash(runtimeType,_this.planId,_this.name,_this.description,_this.ruleset,_this.equipmentCategory,_this.level,_this.gender,_this.durationPerSession,const DeepCollectionEquality().hash(_this.trainingSessions),_this.thumbnailURL);
}

@override
String toString() {
  final _this = this as WorkoutPlanModel;
  return 'WorkoutPlanModel(planId: ${_this.planId}, name: ${_this.name}, description: ${_this.description}, ruleset: ${_this.ruleset}, equipmentCategory: ${_this.equipmentCategory}, level: ${_this.level}, gender: ${_this.gender}, durationPerSession: ${_this.durationPerSession}, trainingSessions: ${_this.trainingSessions}, thumbnailURL: ${_this.thumbnailURL})';
}


}

/// @nodoc
abstract mixin class $WorkoutPlanModelCopyWith<$Res>  {
  factory $WorkoutPlanModelCopyWith(WorkoutPlanModel value, $Res Function(WorkoutPlanModel) _then) = _$WorkoutPlanModelCopyWithImpl;
@useResult
$Res call({
 String planId, String name, String description, String ruleset, String equipmentCategory, String level, String gender, int durationPerSession, List<TrainingSessionModel> trainingSessions, String? thumbnailURL
});




}
/// @nodoc
class _$WorkoutPlanModelCopyWithImpl<$Res>
    implements $WorkoutPlanModelCopyWith<$Res> {
  _$WorkoutPlanModelCopyWithImpl(this._self, this._then);

  final WorkoutPlanModel _self;
  final $Res Function(WorkoutPlanModel) _then;

/// Create a copy of WorkoutPlanModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? planId = null,Object? name = null,Object? description = null,Object? ruleset = null,Object? equipmentCategory = null,Object? level = null,Object? gender = null,Object? durationPerSession = null,Object? trainingSessions = null,Object? thumbnailURL = freezed,}) {
  return _then(WorkoutPlanModel(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,ruleset: null == ruleset ? _self.ruleset : ruleset // ignore: cast_nullable_to_non_nullable
as String,equipmentCategory: null == equipmentCategory ? _self.equipmentCategory : equipmentCategory // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,durationPerSession: null == durationPerSession ? _self.durationPerSession : durationPerSession // ignore: cast_nullable_to_non_nullable
as int,trainingSessions: null == trainingSessions ? _self.trainingSessions : trainingSessions // ignore: cast_nullable_to_non_nullable
as List<TrainingSessionModel>,thumbnailURL: freezed == thumbnailURL ? _self.thumbnailURL : thumbnailURL // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutPlanModel].
extension WorkoutPlanModelPatterns on WorkoutPlanModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutPlanModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutPlanModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutPlanModel value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutPlanModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutPlanModel value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutPlanModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String planId,  String name,  String description,  String ruleset,  String equipmentCategory,  String level,  String gender,  int durationPerSession,  List<TrainingSessionModel> trainingSessions,  String? thumbnailURL)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutPlanModel() when $default != null:
return $default(_that.planId,_that.name,_that.description,_that.ruleset,_that.equipmentCategory,_that.level,_that.gender,_that.durationPerSession,_that.trainingSessions,_that.thumbnailURL);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String planId,  String name,  String description,  String ruleset,  String equipmentCategory,  String level,  String gender,  int durationPerSession,  List<TrainingSessionModel> trainingSessions,  String? thumbnailURL)  $default,) {final _that = this;
switch (_that) {
case _WorkoutPlanModel():
return $default(_that.planId,_that.name,_that.description,_that.ruleset,_that.equipmentCategory,_that.level,_that.gender,_that.durationPerSession,_that.trainingSessions,_that.thumbnailURL);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String planId,  String name,  String description,  String ruleset,  String equipmentCategory,  String level,  String gender,  int durationPerSession,  List<TrainingSessionModel> trainingSessions,  String? thumbnailURL)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutPlanModel() when $default != null:
return $default(_that.planId,_that.name,_that.description,_that.ruleset,_that.equipmentCategory,_that.level,_that.gender,_that.durationPerSession,_that.trainingSessions,_that.thumbnailURL);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkoutPlanModel extends WorkoutPlanModel {
  const _WorkoutPlanModel({required this.planId, required this.name, this.description = '', this.ruleset = 'hypertrophy', this.equipmentCategory = 'gym', this.level = 'beginner', this.gender = 'all', this.durationPerSession = 45,  List<TrainingSessionModel> trainingSessions = const [], this.thumbnailURL}): _trainingSessions = trainingSessions,super._();
  factory _WorkoutPlanModel.fromJson(Map<String, dynamic> json) => _$WorkoutPlanModelFromJson(json);

@override final  String planId;
@override final  String name;
@override@JsonKey() final  String description;
@override@JsonKey() final  String ruleset;
@override@JsonKey() final  String equipmentCategory;
@override@JsonKey() final  String level;
@override@JsonKey() final  String gender;
@override@JsonKey() final  int durationPerSession;
 final  List<TrainingSessionModel> _trainingSessions;
@override@JsonKey() List<TrainingSessionModel> get trainingSessions {
  if (_trainingSessions is EqualUnmodifiableListView) return _trainingSessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trainingSessions);
}

@override final  String? thumbnailURL;

/// Create a copy of WorkoutPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutPlanModelCopyWith<_WorkoutPlanModel> get copyWith => __$WorkoutPlanModelCopyWithImpl<_WorkoutPlanModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkoutPlanModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutPlanModel&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.ruleset, ruleset) || other.ruleset == ruleset)&&(identical(other.equipmentCategory, equipmentCategory) || other.equipmentCategory == equipmentCategory)&&(identical(other.level, level) || other.level == level)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.durationPerSession, durationPerSession) || other.durationPerSession == durationPerSession)&&const DeepCollectionEquality().equals(other.trainingSessions, _trainingSessions)&&(identical(other.thumbnailURL, thumbnailURL) || other.thumbnailURL == thumbnailURL));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,planId,name,description,ruleset,equipmentCategory,level,gender,durationPerSession,const DeepCollectionEquality().hash(_trainingSessions),thumbnailURL);
}

@override
String toString() {
    return 'WorkoutPlanModel(planId: $planId, name: $name, description: $description, ruleset: $ruleset, equipmentCategory: $equipmentCategory, level: $level, gender: $gender, durationPerSession: $durationPerSession, trainingSessions: $trainingSessions, thumbnailURL: $thumbnailURL)';
}


}

/// @nodoc
abstract mixin class _$WorkoutPlanModelCopyWith<$Res> implements $WorkoutPlanModelCopyWith<$Res> {
  factory _$WorkoutPlanModelCopyWith(_WorkoutPlanModel value, $Res Function(_WorkoutPlanModel) _then) = __$WorkoutPlanModelCopyWithImpl;
@override @useResult
$Res call({
 String planId, String name, String description, String ruleset, String equipmentCategory, String level, String gender, int durationPerSession, List<TrainingSessionModel> trainingSessions, String? thumbnailURL
});




}
/// @nodoc
class __$WorkoutPlanModelCopyWithImpl<$Res>
    implements _$WorkoutPlanModelCopyWith<$Res> {
  __$WorkoutPlanModelCopyWithImpl(this._self, this._then);

  final _WorkoutPlanModel _self;
  final $Res Function(_WorkoutPlanModel) _then;

/// Create a copy of WorkoutPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? planId = null,Object? name = null,Object? description = null,Object? ruleset = null,Object? equipmentCategory = null,Object? level = null,Object? gender = null,Object? durationPerSession = null,Object? trainingSessions = null,Object? thumbnailURL = freezed,}) {
  return _then(_WorkoutPlanModel(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,ruleset: null == ruleset ? _self.ruleset : ruleset // ignore: cast_nullable_to_non_nullable
as String,equipmentCategory: null == equipmentCategory ? _self.equipmentCategory : equipmentCategory // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,durationPerSession: null == durationPerSession ? _self.durationPerSession : durationPerSession // ignore: cast_nullable_to_non_nullable
as int,trainingSessions: null == trainingSessions ? _self._trainingSessions : trainingSessions // ignore: cast_nullable_to_non_nullable
as List<TrainingSessionModel>,thumbnailURL: freezed == thumbnailURL ? _self.thumbnailURL : thumbnailURL // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
