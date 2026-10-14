// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseModel _$ExerciseModelFromJson(Map<String, dynamic> json) =>
    _ExerciseModel(
      exerciseTemplateId: (json['exerciseTemplateId'] as num).toInt(),
      name: json['name'] as String? ?? '',
      note: json['note'] as String?,
      muscleGroup: json['muscleGroup'] as String? ?? 'General',
      sets:
          (json['sets'] as List<dynamic>?)
              ?.map((e) => ExerciseSetModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ExerciseModelToJson(_ExerciseModel instance) =>
    <String, dynamic>{
      'exerciseTemplateId': instance.exerciseTemplateId,
      'name': instance.name,
      'note': instance.note,
      'muscleGroup': instance.muscleGroup,
      'sets': instance.sets,
    };
