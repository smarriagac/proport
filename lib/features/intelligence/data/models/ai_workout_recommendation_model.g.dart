// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_workout_recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AIWorkoutRecommendationModel _$AIWorkoutRecommendationModelFromJson(
  Map<String, dynamic> json,
) => _AIWorkoutRecommendationModel(
  id: json['id'] as String,
  title: json['title'] as String,
  targetMuscles:
      (json['targetMuscles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  difficulty: json['difficulty'] as String? ?? 'Intermediate',
  estimatedDuration: (json['estimatedDuration'] as num?)?.toInt() ?? 45,
  intensityScore: (json['intensityScore'] as num?)?.toInt() ?? 8,
  rationale: json['rationale'] as String? ?? '',
  tips:
      (json['tips'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  exercises:
      (json['exercises'] as List<dynamic>?)
          ?.map((e) => ExerciseModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$AIWorkoutRecommendationModelToJson(
  _AIWorkoutRecommendationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'targetMuscles': instance.targetMuscles,
  'difficulty': instance.difficulty,
  'estimatedDuration': instance.estimatedDuration,
  'intensityScore': instance.intensityScore,
  'rationale': instance.rationale,
  'tips': instance.tips,
  'exercises': instance.exercises,
};
