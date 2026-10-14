import '../entities/user_rank.dart';
import '../entities/muscle_volume.dart';
import '../repositories/statistics_repository.dart';

class StatisticsSummary {
  final double symmetryScore;
  final List<UserRank> ranks;
  final List<MuscleVolume> volumes;

  const StatisticsSummary({
    required this.symmetryScore,
    required this.ranks,
    required this.volumes,
  });
}

class GetUserRanksUseCase {
  final StatisticsRepository repository;

  GetUserRanksUseCase(this.repository);

  Future<StatisticsSummary> call() async {
    final ranks = await repository.getUserRanks();
    final volumes = await repository.getMuscleVolumes();
    final score = await repository.getOverallSymmetryScore();
    return StatisticsSummary(
      symmetryScore: score,
      ranks: ranks,
      volumes: volumes,
    );
  }
}
