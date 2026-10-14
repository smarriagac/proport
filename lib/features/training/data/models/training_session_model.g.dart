// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingSessionModel _$TrainingSessionModelFromJson(
  Map<String, dynamic> json,
) => _TrainingSessionModel(
  dayOfWeek: (json['dayOfWeek'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  exercises:
      (json['exercises'] as List<dynamic>?)
          ?.map((e) => ExerciseModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isCompleted: json['isCompleted'] as bool? ?? false,
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
);

Map<String, dynamic> _$TrainingSessionModelToJson(
  _TrainingSessionModel instance,
) => <String, dynamic>{
  'dayOfWeek': instance.dayOfWeek,
  'name': instance.name,
  'description': instance.description,
  'exercises': instance.exercises,
  'isCompleted': instance.isCompleted,
  'completedAt': instance.completedAt?.toIso8601String(),
  'durationMinutes': instance.durationMinutes,
};
