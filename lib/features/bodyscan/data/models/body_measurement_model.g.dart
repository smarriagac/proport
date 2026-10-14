// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_measurement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BodyMeasurementModel _$BodyMeasurementModelFromJson(
  Map<String, dynamic> json,
) => _BodyMeasurementModel(
  id: json['id'] as String,
  scanDate: DateTime.parse(json['scanDate'] as String),
  bodyFatPercentage: (json['bodyFatPercentage'] as num).toDouble(),
  muscleMassKg: (json['muscleMassKg'] as num).toDouble(),
  symmetryIndex: (json['symmetryIndex'] as num).toDouble(),
  chestCm: (json['chestCm'] as num).toDouble(),
  waistCm: (json['waistCm'] as num).toDouble(),
  bicepsCm: (json['bicepsCm'] as num).toDouble(),
  thighsCm: (json['thighsCm'] as num).toDouble(),
  calvesCm: (json['calvesCm'] as num).toDouble(),
  shouldersCm: (json['shouldersCm'] as num).toDouble(),
  frontPhotoUrl: json['frontPhotoUrl'] as String?,
  sidePhotoUrl: json['sidePhotoUrl'] as String?,
  aiAnalysisNotes:
      (json['aiAnalysisNotes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$BodyMeasurementModelToJson(
  _BodyMeasurementModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'scanDate': instance.scanDate.toIso8601String(),
  'bodyFatPercentage': instance.bodyFatPercentage,
  'muscleMassKg': instance.muscleMassKg,
  'symmetryIndex': instance.symmetryIndex,
  'chestCm': instance.chestCm,
  'waistCm': instance.waistCm,
  'bicepsCm': instance.bicepsCm,
  'thighsCm': instance.thighsCm,
  'calvesCm': instance.calvesCm,
  'shouldersCm': instance.shouldersCm,
  'frontPhotoUrl': instance.frontPhotoUrl,
  'sidePhotoUrl': instance.sidePhotoUrl,
  'aiAnalysisNotes': instance.aiAnalysisNotes,
};
