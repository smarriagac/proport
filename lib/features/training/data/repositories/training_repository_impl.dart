import '../../domain/entities/workout_plan.dart';
import '../../domain/entities/training_session.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/repositories/training_repository.dart';
import '../datasources/training_local_data_source.dart';
import '../models/training_session_model.dart';

class TrainingRepositoryImpl implements TrainingRepository {
  final TrainingLocalDataSource localDataSource;

  TrainingRepositoryImpl(this.localDataSource);

  @override
  Future<List<WorkoutPlan>> getWorkoutPlans() async {
    final nameMap = await localDataSource.getExerciseNameMap();
    final models = await localDataSource.getWorkoutPlans();
    return models.map((m) => m.toDomain(nameMap: nameMap)).toList();
  }

  @override
  Future<WorkoutPlan?> getWorkoutPlanById(String planId) async {
    final plans = await getWorkoutPlans();
    try {
      return plans.firstWhere((p) => p.planId == planId);
    } catch (_) {
      return plans.isNotEmpty ? plans.first : null;
    }
  }

  @override
  Future<List<Exercise>> getExerciseCatalog() async {
    final models = await localDataSource.getExerciseCatalog();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<void> logTrainingSession(TrainingSession session) async {
    final model = TrainingSessionModel.fromDomain(session);
    await localDataSource.saveCompletedSession(model);
  }

  @override
  Future<List<TrainingSession>> getCompletedSessions() async {
    final models = await localDataSource.getCompletedSessions();
    final nameMap = await localDataSource.getExerciseNameMap();
    return models.map((m) => m.toDomain(nameMap: nameMap)).toList();
  }
}
