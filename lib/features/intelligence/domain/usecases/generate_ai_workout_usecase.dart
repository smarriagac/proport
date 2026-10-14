import '../entities/ai_workout_recommendation.dart';
import '../repositories/intelligence_repository.dart';

class GenerateAIWorkoutUseCase {
  final IntelligenceRepository repository;

  GenerateAIWorkoutUseCase(this.repository);

  Future<AIWorkoutRecommendation> call({
    required List<String> muscleFocus,
    required String equipment,
    required int durationMinutes,
    required String goal,
  }) async {
    return await repository.generateWorkout(
      muscleFocus: muscleFocus,
      equipment: equipment,
      durationMinutes: durationMinutes,
      goal: goal,
    );
  }
}
