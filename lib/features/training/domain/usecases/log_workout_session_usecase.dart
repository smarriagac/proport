import '../entities/training_session.dart';
import '../repositories/training_repository.dart';

class LogWorkoutSessionUseCase {
  final TrainingRepository repository;

  LogWorkoutSessionUseCase(this.repository);

  Future<void> call(TrainingSession session) async {
    return await repository.logTrainingSession(session);
  }
}
