import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:proport/features/training/data/models/exercise_model.dart';
import '../../domain/entities/ai_workout_recommendation.dart';

part 'ai_workout_recommendation_model.freezed.dart';
part 'ai_workout_recommendation_model.g.dart';

@freezed
abstract class AIWorkoutRecommendationModel with _$AIWorkoutRecommendationModel {
  const AIWorkoutRecommendationModel._();

  const factory AIWorkoutRecommendationModel({
    required String id,
    required String title,
    @Default([]) List<String> targetMuscles,
    @Default('Intermediate') String difficulty,
    @Default(45) int estimatedDuration,
    @Default(8) int intensityScore,
    @Default('') String rationale,
    @Default([]) List<String> tips,
    @Default([]) List<ExerciseModel> exercises,
  }) = _AIWorkoutRecommendationModel;

  factory AIWorkoutRecommendationModel.fromJson(Map<String, dynamic> json) =>
      _$AIWorkoutRecommendationModelFromJson(json);

  AIWorkoutRecommendation toDomain() {
    return AIWorkoutRecommendation(
      id: id,
      title: title,
      targetMuscles: targetMuscles,
      difficulty: difficulty,
      estimatedDuration: estimatedDuration,
      intensityScore: intensityScore,
      rationale: rationale,
      tips: tips,
      exercises: exercises.map((e) => e.toDomain()).toList(),
    );
  }

  factory AIWorkoutRecommendationModel.fromDomain(AIWorkoutRecommendation domain) {
    return AIWorkoutRecommendationModel(
      id: domain.id,
      title: domain.title,
      targetMuscles: domain.targetMuscles,
      difficulty: domain.difficulty,
      estimatedDuration: domain.estimatedDuration,
      intensityScore: domain.intensityScore,
      rationale: domain.rationale,
      tips: domain.tips,
      exercises: domain.exercises.map<ExerciseModel>((e) => ExerciseModel.fromDomain(e)).toList(),
    );
  }
}
