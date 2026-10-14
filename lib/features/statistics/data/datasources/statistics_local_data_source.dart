import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/di/injection.dart';
import '../models/user_rank_model.dart';
import '../models/muscle_volume_model.dart';

abstract class StatisticsLocalDataSource {
  Future<List<UserRankModel>> getUserRanks();
  Future<List<MuscleVolumeModel>> getMuscleVolumes();
  Future<double> getOverallSymmetryScore();
  Future<void> updateUserRank({
    required String muscleGroup,
    required String currentRank,
    required int tierLevel,
    required double estimated1Rm,
    required double percentile,
    DateTime? lastTrained,
  });
}

class StatisticsLocalDataSourceImpl implements StatisticsLocalDataSource {
  final AppDatabase db;

  StatisticsLocalDataSourceImpl([AppDatabase? database])
      : db = database ?? getIt<AppDatabase>();

  @override
  Future<List<UserRankModel>> getUserRanks() async {
    // 1. Query Drift UserRanksTable
    var rows = await db.select(db.userRanksTable).get();

    // 2. Seed initial benchmark ranks if table is empty
    if (rows.isEmpty) {
      final defaultRanks = [
        UserRanksTableCompanion.insert(
          muscleGroup: 'Sentadilla (Barra Alta)',
          currentRank: 'Advanced (Platino)',
          tierLevel: 4,
          estimated1Rm: 110.0,
          percentile: 84.0,
          lastTrained: Value(DateTime.now().subtract(const Duration(days: 3))),
        ),
        UserRanksTableCompanion.insert(
          muscleGroup: 'Press De Banca (Barra)',
          currentRank: 'Proficient (Oro)',
          tierLevel: 3,
          estimated1Rm: 95.0,
          percentile: 74.0,
          lastTrained: Value(DateTime.now().subtract(const Duration(days: 1))),
        ),
        UserRanksTableCompanion.insert(
          muscleGroup: 'Peso Muerto Convencional',
          currentRank: 'Advanced (Platino)',
          tierLevel: 4,
          estimated1Rm: 155.0,
          percentile: 89.0,
          lastTrained: Value(DateTime.now().subtract(const Duration(days: 2))),
        ),
        UserRanksTableCompanion.insert(
          muscleGroup: 'Press Militar (Barra)',
          currentRank: 'Proficient (Oro)',
          tierLevel: 3,
          estimated1Rm: 62.5,
          percentile: 76.0,
          lastTrained: Value(DateTime.now().subtract(const Duration(days: 4))),
        ),
        UserRanksTableCompanion.insert(
          muscleGroup: 'Curl De Bíceps (Mancuerna)',
          currentRank: 'Proficient (Oro)',
          tierLevel: 3,
          estimated1Rm: 22.0,
          percentile: 71.0,
          lastTrained: Value(DateTime.now().subtract(const Duration(days: 1))),
        ),
      ];

      for (final rank in defaultRanks) {
        await db.into(db.userRanksTable).insert(rank);
      }

      rows = await db.select(db.userRanksTable).get();
    }

    // 3. Map Drift rows to UserRankModel
    const double bodyweight = 78.0;
    return rows.map((r) {
      final id = _getExerciseIdForMuscle(r.muscleGroup);
      final ratio = double.parse((r.estimated1Rm / bodyweight).toStringAsFixed(2));
      return UserRankModel(
        exerciseId: id,
        exerciseName: r.muscleGroup,
        currentWeight: r.estimated1Rm,
        bodyweight: bodyweight,
        ratio: ratio,
        rankTier: r.currentRank,
        tierIndex: r.tierLevel,
        nextTierRatio: double.parse((ratio * 1.15).toStringAsFixed(2)),
        progressPercentage: r.percentile / 100.0,
        percentile: r.percentile.round(),
      );
    }).toList();
  }

  @override
  Future<void> updateUserRank({
    required String muscleGroup,
    required String currentRank,
    required int tierLevel,
    required double estimated1Rm,
    required double percentile,
    DateTime? lastTrained,
  }) async {
    await db.into(db.userRanksTable).insertOnConflictUpdate(
          UserRanksTableCompanion.insert(
            muscleGroup: muscleGroup,
            currentRank: currentRank,
            tierLevel: tierLevel,
            estimated1Rm: estimated1Rm,
            percentile: percentile,
            lastTrained: Value(lastTrained ?? DateTime.now()),
          ),
        );
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

  int _getExerciseIdForMuscle(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('sentadilla') || lower.contains('squat')) return 1;
    if (lower.contains('banca') || lower.contains('bench')) return 740;
    if (lower.contains('muerto') || lower.contains('deadlift')) return 1896;
    if (lower.contains('militar') || lower.contains('overhead')) return 1834;
    if (lower.contains('curl') || lower.contains('bicep')) return 25;
    return 100;
  }
}
