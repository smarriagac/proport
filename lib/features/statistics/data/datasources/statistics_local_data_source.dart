import '../models/user_rank_model.dart';
import '../models/muscle_volume_model.dart';

abstract class StatisticsLocalDataSource {
  Future<List<UserRankModel>> getUserRanks();
  Future<List<MuscleVolumeModel>> getMuscleVolumes();
  Future<double> getOverallSymmetryScore();
}

class StatisticsLocalDataSourceImpl implements StatisticsLocalDataSource {
  @override
  Future<List<UserRankModel>> getUserRanks() async {
    // Benchmark exercises calibrated against Symmetry rankThresholds
    return const [
      UserRankModel(
        exerciseId: 1,
        exerciseName: 'Sentadilla (Barra Alta)',
        currentWeight: 110.0,
        bodyweight: 78.0,
        ratio: 1.41,
        rankTier: 'Advanced (Platino)',
        tierIndex: 4,
        nextTierRatio: 1.60,
        progressPercentage: 0.82,
        percentile: 84,
      ),
      UserRankModel(
        exerciseId: 740,
        exerciseName: 'Press De Banca (Barra)',
        currentWeight: 95.0,
        bodyweight: 78.0,
        ratio: 1.22,
        rankTier: 'Proficient (Oro)',
        tierIndex: 3,
        nextTierRatio: 1.35,
        progressPercentage: 0.65,
        percentile: 74,
      ),
      UserRankModel(
        exerciseId: 1896,
        exerciseName: 'Peso Muerto Convencional',
        currentWeight: 155.0,
        bodyweight: 78.0,
        ratio: 1.98,
        rankTier: 'Advanced (Platino)',
        tierIndex: 4,
        nextTierRatio: 2.10,
        progressPercentage: 0.88,
        percentile: 89,
      ),
      UserRankModel(
        exerciseId: 1834,
        exerciseName: 'Press Militar (Barra)',
        currentWeight: 62.5,
        bodyweight: 78.0,
        ratio: 0.80,
        rankTier: 'Proficient (Oro)',
        tierIndex: 3,
        nextTierRatio: 0.90,
        progressPercentage: 0.70,
        percentile: 76,
      ),
      UserRankModel(
        exerciseId: 25,
        exerciseName: 'Curl De Bíceps (Mancuerna)',
        currentWeight: 22.0,
        bodyweight: 78.0,
        ratio: 0.28,
        rankTier: 'Proficient (Oro)',
        tierIndex: 3,
        nextTierRatio: 0.32,
        progressPercentage: 0.60,
        percentile: 71,
      ),
    ];
  }

  @override
  Future<List<MuscleVolumeModel>> getMuscleVolumes() async {
    return const [
      MuscleVolumeModel(
        muscleGroup: 'Chest',
        weeklySets: 14,
        optimalMinSets: 10,
        optimalMaxSets: 18,
        symmetryScore: 92.0,
        status: 'Optimal',
      ),
      MuscleVolumeModel(
        muscleGroup: 'Back',
        weeklySets: 16,
        optimalMinSets: 12,
        optimalMaxSets: 20,
        symmetryScore: 95.0,
        status: 'Optimal',
      ),
      MuscleVolumeModel(
        muscleGroup: 'Quads',
        weeklySets: 12,
        optimalMinSets: 10,
        optimalMaxSets: 16,
        symmetryScore: 88.0,
        status: 'Optimal',
      ),
      MuscleVolumeModel(
        muscleGroup: 'Hamstrings',
        weeklySets: 10,
        optimalMinSets: 8,
        optimalMaxSets: 14,
        symmetryScore: 84.0,
        status: 'Recovering',
      ),
      MuscleVolumeModel(
        muscleGroup: 'Shoulders',
        weeklySets: 14,
        optimalMinSets: 10,
        optimalMaxSets: 18,
        symmetryScore: 90.0,
        status: 'Optimal',
      ),
      MuscleVolumeModel(
        muscleGroup: 'Arms',
        weeklySets: 15,
        optimalMinSets: 10,
        optimalMaxSets: 18,
        symmetryScore: 91.0,
        status: 'Optimal',
      ),
    ];
  }

  @override
  Future<double> getOverallSymmetryScore() async {
    return 89.2;
  }
}
