import '../../domain/entities/user_rank.dart';
import '../../domain/entities/muscle_volume.dart';
import '../../domain/repositories/statistics_repository.dart';
import '../datasources/statistics_local_data_source.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final StatisticsLocalDataSource localDataSource;

  StatisticsRepositoryImpl(this.localDataSource);

  @override
  Future<List<UserRank>> getUserRanks() async {
    final models = await localDataSource.getUserRanks();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<List<MuscleVolume>> getMuscleVolumes() async {
    final models = await localDataSource.getMuscleVolumes();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<double> getOverallSymmetryScore() async {
    return await localDataSource.getOverallSymmetryScore();
  }
}
