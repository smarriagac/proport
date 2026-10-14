// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_set_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseSetModel _$ExerciseSetModelFromJson(Map<String, dynamic> json) =>
    _ExerciseSetModel(
      setNumber: (json['setNumber'] as num?)?.toInt() ?? 1,
      reps: (json['reps'] as num?)?.toInt() ?? 10,
      weightKg: (json['weightKg'] as num?)?.toDouble() ?? 0.0,
      restSeconds: (json['restSeconds'] as num?)?.toInt() ?? 90,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$ExerciseSetModelToJson(_ExerciseSetModel instance) =>
    <String, dynamic>{
      'setNumber': instance.setNumber,
      'reps': instance.reps,
      'weightKg': instance.weightKg,
      'restSeconds': instance.restSeconds,
      'durationSeconds': instance.durationSeconds,
      'isCompleted': instance.isCompleted,
    };
