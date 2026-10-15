import '../entities/workout_plan.dart';
import '../entities/training_session.dart';
import '../entities/exercise.dart';

abstract class TrainingRepository {
  Future<List<WorkoutPlan>> getWorkoutPlans();
  Future<WorkoutPlan?> getWorkoutPlanById(String planId);
  Future<List<Exercise>> getExerciseCatalog();
  Future<void> logTrainingSession(TrainingSession session);
  Future<List<TrainingSession>> getCompletedSessions();
  Future<List<TrainingSession>> getTemplates();
  Future<void> saveTemplate(TrainingSession session);
  Future<void> deleteTemplate(String sessionId);
}
