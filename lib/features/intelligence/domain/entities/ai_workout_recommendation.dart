import 'package:equatable/equatable.dart';
import 'package:symmetry/features/training/domain/entities/exercise.dart';

class AIWorkoutRecommendation extends Equatable {
  final String id;
  final String title;
  final List<String> targetMuscles;
  final String difficulty;
  final int estimatedDuration;
  final int intensityScore; // 1-10
  final String rationale;
  final List<String> tips;
  final List<Exercise> exercises;

  const AIWorkoutRecommendation({
    required this.id,
    required this.title,
    required this.targetMuscles,
    required this.difficulty,
    required this.estimatedDuration,
    required this.intensityScore,
    required this.rationale,
    required this.tips,
    required this.exercises,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        targetMuscles,
        difficulty,
        estimatedDuration,
        intensityScore,
        rationale,
        tips,
        exercises,
      ];
}
