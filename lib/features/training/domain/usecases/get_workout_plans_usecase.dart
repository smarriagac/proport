import '../entities/workout_plan.dart';
import '../repositories/training_repository.dart';

class GetWorkoutPlansUseCase {
  final TrainingRepository repository;

  GetWorkoutPlansUseCase(this.repository);

  Future<List<WorkoutPlan>> call() async {
    return await repository.getWorkoutPlans();
  }
}
