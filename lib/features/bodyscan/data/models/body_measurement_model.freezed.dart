// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_measurement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BodyMeasurementModel {

 String get id; DateTime get scanDate; double get bodyFatPercentage; double get muscleMassKg; double get symmetryIndex; double get chestCm; double get waistCm; double get bicepsCm; double get thighsCm; double get calvesCm; double get shouldersCm; String? get frontPhotoUrl; String? get sidePhotoUrl; List<String> get aiAnalysisNotes;
/// Create a copy of BodyMeasurementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyMeasurementModelCopyWith<BodyMeasurementModel> get copyWith => _$BodyMeasurementModelCopyWithImpl<BodyMeasurementModel>(this as BodyMeasurementModel, _$identity);

  /// Serializes this BodyMeasurementModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BodyMeasurementModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyMeasurementModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.scanDate, _this.scanDate) || other.scanDate == _this.scanDate)&&(identical(other.bodyFatPercentage, _this.bodyFatPercentage) || other.bodyFatPercentage == _this.bodyFatPercentage)&&(identical(other.muscleMassKg, _this.muscleMassKg) || other.muscleMassKg == _this.muscleMassKg)&&(identical(other.symmetryIndex, _this.symmetryIndex) || other.symmetryIndex == _this.symmetryIndex)&&(identical(other.chestCm, _this.chestCm) || other.chestCm == _this.chestCm)&&(identical(other.waistCm, _this.waistCm) || other.waistCm == _this.waistCm)&&(identical(other.bicepsCm, _this.bicepsCm) || other.bicepsCm == _this.bicepsCm)&&(identical(other.thighsCm, _this.thighsCm) || other.thighsCm == _this.thighsCm)&&(identical(other.calvesCm, _this.calvesCm) || other.calvesCm == _this.calvesCm)&&(identical(other.shouldersCm, _this.shouldersCm) || other.shouldersCm == _this.shouldersCm)&&(identical(other.frontPhotoUrl, _this.frontPhotoUrl) || other.frontPhotoUrl == _this.frontPhotoUrl)&&(identical(other.sidePhotoUrl, _this.sidePhotoUrl) || other.sidePhotoUrl == _this.sidePhotoUrl)&&const DeepCollectionEquality().equals(other.aiAnalysisNotes, _this.aiAnalysisNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BodyMeasurementModel;
  return Object.hash(runtimeType,_this.id,_this.scanDate,_this.bodyFatPercentage,_this.muscleMassKg,_this.symmetryIndex,_this.chestCm,_this.waistCm,_this.bicepsCm,_this.thighsCm,_this.calvesCm,_this.shouldersCm,_this.frontPhotoUrl,_this.sidePhotoUrl,const DeepCollectionEquality().hash(_this.aiAnalysisNotes));
}

@override
String toString() {
  final _this = this as BodyMeasurementModel;
  return 'BodyMeasurementModel(id: ${_this.id}, scanDate: ${_this.scanDate}, bodyFatPercentage: ${_this.bodyFatPercentage}, muscleMassKg: ${_this.muscleMassKg}, symmetryIndex: ${_this.symmetryIndex}, chestCm: ${_this.chestCm}, waistCm: ${_this.waistCm}, bicepsCm: ${_this.bicepsCm}, thighsCm: ${_this.thighsCm}, calvesCm: ${_this.calvesCm}, shouldersCm: ${_this.shouldersCm}, frontPhotoUrl: ${_this.frontPhotoUrl}, sidePhotoUrl: ${_this.sidePhotoUrl}, aiAnalysisNotes: ${_this.aiAnalysisNotes})';
}


}

/// @nodoc
abstract mixin class $BodyMeasurementModelCopyWith<$Res>  {
  factory $BodyMeasurementModelCopyWith(BodyMeasurementModel value, $Res Function(BodyMeasurementModel) _then) = _$BodyMeasurementModelCopyWithImpl;
@useResult
$Res call({
 String id, DateTime scanDate, double bodyFatPercentage, double muscleMassKg, double symmetryIndex, double chestCm, double waistCm, double bicepsCm, double thighsCm, double calvesCm, double shouldersCm, String? frontPhotoUrl, String? sidePhotoUrl, List<String> aiAnalysisNotes
});




}
/// @nodoc
class _$BodyMeasurementModelCopyWithImpl<$Res>
    implements $BodyMeasurementModelCopyWith<$Res> {
  _$BodyMeasurementModelCopyWithImpl(this._self, this._then);

  final BodyMeasurementModel _self;
  final $Res Function(BodyMeasurementModel) _then;

/// Create a copy of BodyMeasurementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? scanDate = null,Object? bodyFatPercentage = null,Object? muscleMassKg = null,Object? symmetryIndex = null,Object? chestCm = null,Object? waistCm = null,Object? bicepsCm = null,Object? thighsCm = null,Object? calvesCm = null,Object? shouldersCm = null,Object? frontPhotoUrl = freezed,Object? sidePhotoUrl = freezed,Object? aiAnalysisNotes = null,}) {
  return _then(BodyMeasurementModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,scanDate: null == scanDate ? _self.scanDate : scanDate // ignore: cast_nullable_to_non_nullable
as DateTime,bodyFatPercentage: null == bodyFatPercentage ? _self.bodyFatPercentage : bodyFatPercentage // ignore: cast_nullable_to_non_nullable
as double,muscleMassKg: null == muscleMassKg ? _self.muscleMassKg : muscleMassKg // ignore: cast_nullable_to_non_nullable
as double,symmetryIndex: null == symmetryIndex ? _self.symmetryIndex : symmetryIndex // ignore: cast_nullable_to_non_nullable
as double,chestCm: null == chestCm ? _self.chestCm : chestCm // ignore: cast_nullable_to_non_nullable
as double,waistCm: null == waistCm ? _self.waistCm : waistCm // ignore: cast_nullable_to_non_nullable
as double,bicepsCm: null == bicepsCm ? _self.bicepsCm : bicepsCm // ignore: cast_nullable_to_non_nullable
as double,thighsCm: null == thighsCm ? _self.thighsCm : thighsCm // ignore: cast_nullable_to_non_nullable
as double,calvesCm: null == calvesCm ? _self.calvesCm : calvesCm // ignore: cast_nullable_to_non_nullable
as double,shouldersCm: null == shouldersCm ? _self.shouldersCm : shouldersCm // ignore: cast_nullable_to_non_nullable
as double,frontPhotoUrl: freezed == frontPhotoUrl ? _self.frontPhotoUrl : frontPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,sidePhotoUrl: freezed == sidePhotoUrl ? _self.sidePhotoUrl : sidePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,aiAnalysisNotes: null == aiAnalysisNotes ? _self.aiAnalysisNotes : aiAnalysisNotes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyMeasurementModel].
extension BodyMeasurementModelPatterns on BodyMeasurementModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyMeasurementModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyMeasurementModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyMeasurementModel value)  $default,){
final _that = this;
switch (_that) {
case _BodyMeasurementModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyMeasurementModel value)?  $default,){
final _that = this;
switch (_that) {
case _BodyMeasurementModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime scanDate,  double bodyFatPercentage,  double muscleMassKg,  double symmetryIndex,  double chestCm,  double waistCm,  double bicepsCm,  double thighsCm,  double calvesCm,  double shouldersCm,  String? frontPhotoUrl,  String? sidePhotoUrl,  List<String> aiAnalysisNotes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyMeasurementModel() when $default != null:
return $default(_that.id,_that.scanDate,_that.bodyFatPercentage,_that.muscleMassKg,_that.symmetryIndex,_that.chestCm,_that.waistCm,_that.bicepsCm,_that.thighsCm,_that.calvesCm,_that.shouldersCm,_that.frontPhotoUrl,_that.sidePhotoUrl,_that.aiAnalysisNotes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime scanDate,  double bodyFatPercentage,  double muscleMassKg,  double symmetryIndex,  double chestCm,  double waistCm,  double bicepsCm,  double thighsCm,  double calvesCm,  double shouldersCm,  String? frontPhotoUrl,  String? sidePhotoUrl,  List<String> aiAnalysisNotes)  $default,) {final _that = this;
switch (_that) {
case _BodyMeasurementModel():
return $default(_that.id,_that.scanDate,_that.bodyFatPercentage,_that.muscleMassKg,_that.symmetryIndex,_that.chestCm,_that.waistCm,_that.bicepsCm,_that.thighsCm,_that.calvesCm,_that.shouldersCm,_that.frontPhotoUrl,_that.sidePhotoUrl,_that.aiAnalysisNotes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime scanDate,  double bodyFatPercentage,  double muscleMassKg,  double symmetryIndex,  double chestCm,  double waistCm,  double bicepsCm,  double thighsCm,  double calvesCm,  double shouldersCm,  String? frontPhotoUrl,  String? sidePhotoUrl,  List<String> aiAnalysisNotes)?  $default,) {final _that = this;
switch (_that) {
case _BodyMeasurementModel() when $default != null:
return $default(_that.id,_that.scanDate,_that.bodyFatPercentage,_that.muscleMassKg,_that.symmetryIndex,_that.chestCm,_that.waistCm,_that.bicepsCm,_that.thighsCm,_that.calvesCm,_that.shouldersCm,_that.frontPhotoUrl,_that.sidePhotoUrl,_that.aiAnalysisNotes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BodyMeasurementModel extends BodyMeasurementModel {
  const _BodyMeasurementModel({required this.id, required this.scanDate, required this.bodyFatPercentage, required this.muscleMassKg, required this.symmetryIndex, required this.chestCm, required this.waistCm, required this.bicepsCm, required this.thighsCm, required this.calvesCm, required this.shouldersCm, this.frontPhotoUrl, this.sidePhotoUrl,  List<String> aiAnalysisNotes = const []}): _aiAnalysisNotes = aiAnalysisNotes,super._();
  factory _BodyMeasurementModel.fromJson(Map<String, dynamic> json) => _$BodyMeasurementModelFromJson(json);

@override final  String id;
@override final  DateTime scanDate;
@override final  double bodyFatPercentage;
@override final  double muscleMassKg;
@override final  double symmetryIndex;
@override final  double chestCm;
@override final  double waistCm;
@override final  double bicepsCm;
@override final  double thighsCm;
@override final  double calvesCm;
@override final  double shouldersCm;
@override final  String? frontPhotoUrl;
@override final  String? sidePhotoUrl;
 final  List<String> _aiAnalysisNotes;
@override@JsonKey() List<String> get aiAnalysisNotes {
  if (_aiAnalysisNotes is EqualUnmodifiableListView) return _aiAnalysisNotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aiAnalysisNotes);
}


/// Create a copy of BodyMeasurementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyMeasurementModelCopyWith<_BodyMeasurementModel> get copyWith => __$BodyMeasurementModelCopyWithImpl<_BodyMeasurementModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BodyMeasurementModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyMeasurementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.scanDate, scanDate) || other.scanDate == scanDate)&&(identical(other.bodyFatPercentage, bodyFatPercentage) || other.bodyFatPercentage == bodyFatPercentage)&&(identical(other.muscleMassKg, muscleMassKg) || other.muscleMassKg == muscleMassKg)&&(identical(other.symmetryIndex, symmetryIndex) || other.symmetryIndex == symmetryIndex)&&(identical(other.chestCm, chestCm) || other.chestCm == chestCm)&&(identical(other.waistCm, waistCm) || other.waistCm == waistCm)&&(identical(other.bicepsCm, bicepsCm) || other.bicepsCm == bicepsCm)&&(identical(other.thighsCm, thighsCm) || other.thighsCm == thighsCm)&&(identical(other.calvesCm, calvesCm) || other.calvesCm == calvesCm)&&(identical(other.shouldersCm, shouldersCm) || other.shouldersCm == shouldersCm)&&(identical(other.frontPhotoUrl, frontPhotoUrl) || other.frontPhotoUrl == frontPhotoUrl)&&(identical(other.sidePhotoUrl, sidePhotoUrl) || other.sidePhotoUrl == sidePhotoUrl)&&const DeepCollectionEquality().equals(other.aiAnalysisNotes, _aiAnalysisNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,scanDate,bodyFatPercentage,muscleMassKg,symmetryIndex,chestCm,waistCm,bicepsCm,thighsCm,calvesCm,shouldersCm,frontPhotoUrl,sidePhotoUrl,const DeepCollectionEquality().hash(_aiAnalysisNotes));
}

@override
String toString() {
    return 'BodyMeasurementModel(id: $id, scanDate: $scanDate, bodyFatPercentage: $bodyFatPercentage, muscleMassKg: $muscleMassKg, symmetryIndex: $symmetryIndex, chestCm: $chestCm, waistCm: $waistCm, bicepsCm: $bicepsCm, thighsCm: $thighsCm, calvesCm: $calvesCm, shouldersCm: $shouldersCm, frontPhotoUrl: $frontPhotoUrl, sidePhotoUrl: $sidePhotoUrl, aiAnalysisNotes: $aiAnalysisNotes)';
}


}

/// @nodoc
abstract mixin class _$BodyMeasurementModelCopyWith<$Res> implements $BodyMeasurementModelCopyWith<$Res> {
  factory _$BodyMeasurementModelCopyWith(_BodyMeasurementModel value, $Res Function(_BodyMeasurementModel) _then) = __$BodyMeasurementModelCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime scanDate, double bodyFatPercentage, double muscleMassKg, double symmetryIndex, double chestCm, double waistCm, double bicepsCm, double thighsCm, double calvesCm, double shouldersCm, String? frontPhotoUrl, String? sidePhotoUrl, List<String> aiAnalysisNotes
});




}
/// @nodoc
class __$BodyMeasurementModelCopyWithImpl<$Res>
    implements _$BodyMeasurementModelCopyWith<$Res> {
  __$BodyMeasurementModelCopyWithImpl(this._self, this._then);

  final _BodyMeasurementModel _self;
  final $Res Function(_BodyMeasurementModel) _then;

/// Create a copy of BodyMeasurementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? scanDate = null,Object? bodyFatPercentage = null,Object? muscleMassKg = null,Object? symmetryIndex = null,Object? chestCm = null,Object? waistCm = null,Object? bicepsCm = null,Object? thighsCm = null,Object? calvesCm = null,Object? shouldersCm = null,Object? frontPhotoUrl = freezed,Object? sidePhotoUrl = freezed,Object? aiAnalysisNotes = null,}) {
  return _then(_BodyMeasurementModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,scanDate: null == scanDate ? _self.scanDate : scanDate // ignore: cast_nullable_to_non_nullable
as DateTime,bodyFatPercentage: null == bodyFatPercentage ? _self.bodyFatPercentage : bodyFatPercentage // ignore: cast_nullable_to_non_nullable
as double,muscleMassKg: null == muscleMassKg ? _self.muscleMassKg : muscleMassKg // ignore: cast_nullable_to_non_nullable
as double,symmetryIndex: null == symmetryIndex ? _self.symmetryIndex : symmetryIndex // ignore: cast_nullable_to_non_nullable
as double,chestCm: null == chestCm ? _self.chestCm : chestCm // ignore: cast_nullable_to_non_nullable
as double,waistCm: null == waistCm ? _self.waistCm : waistCm // ignore: cast_nullable_to_non_nullable
as double,bicepsCm: null == bicepsCm ? _self.bicepsCm : bicepsCm // ignore: cast_nullable_to_non_nullable
as double,thighsCm: null == thighsCm ? _self.thighsCm : thighsCm // ignore: cast_nullable_to_non_nullable
as double,calvesCm: null == calvesCm ? _self.calvesCm : calvesCm // ignore: cast_nullable_to_non_nullable
as double,shouldersCm: null == shouldersCm ? _self.shouldersCm : shouldersCm // ignore: cast_nullable_to_non_nullable
as double,frontPhotoUrl: freezed == frontPhotoUrl ? _self.frontPhotoUrl : frontPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,sidePhotoUrl: freezed == sidePhotoUrl ? _self.sidePhotoUrl : sidePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,aiAnalysisNotes: null == aiAnalysisNotes ? _self._aiAnalysisNotes : aiAnalysisNotes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
