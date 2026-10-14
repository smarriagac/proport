// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkoutPlanModel _$WorkoutPlanModelFromJson(Map<String, dynamic> json) =>
    _WorkoutPlanModel(
      planId: json['planId'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      ruleset: json['ruleset'] as String? ?? 'hypertrophy',
      equipmentCategory: json['equipmentCategory'] as String? ?? 'gym',
      level: json['level'] as String? ?? 'beginner',
      gender: json['gender'] as String? ?? 'all',
      durationPerSession: (json['durationPerSession'] as num?)?.toInt() ?? 45,
      trainingSessions:
          (json['trainingSessions'] as List<dynamic>?)
              ?.map(
                (e) => TrainingSessionModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      thumbnailURL: json['thumbnailURL'] as String?,
    );

Map<String, dynamic> _$WorkoutPlanModelToJson(_WorkoutPlanModel instance) =>
    <String, dynamic>{
      'planId': instance.planId,
      'name': instance.name,
      'description': instance.description,
      'ruleset': instance.ruleset,
      'equipmentCategory': instance.equipmentCategory,
      'level': instance.level,
      'gender': instance.gender,
      'durationPerSession': instance.durationPerSession,
      'trainingSessions': instance.trainingSessions,
      'thumbnailURL': instance.thumbnailURL,
    };
