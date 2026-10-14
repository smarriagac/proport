import '../entities/exercise.dart';
import '../repositories/training_repository.dart';

class GetExerciseCatalogUseCase {
  final TrainingRepository repository;

  GetExerciseCatalogUseCase(this.repository);

  Future<List<Exercise>> call() async {
    return await repository.getExerciseCatalog();
  }
}
