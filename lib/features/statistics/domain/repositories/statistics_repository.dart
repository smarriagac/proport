import '../entities/user_rank.dart';
import '../entities/muscle_volume.dart';

abstract class StatisticsRepository {
  Future<List<UserRank>> getUserRanks();
  Future<List<MuscleVolume>> getMuscleVolumes();
  Future<double> getOverallSymmetryScore();
}
