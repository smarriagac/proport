import 'package:equatable/equatable.dart';

class UserRank extends Equatable {
  final int exerciseId;
  final String exerciseName;
  final double currentWeight;
  final double bodyweight;
  final double ratio;
  final String rankTier;
  final int tierIndex;
  final double nextTierRatio;
  final double progressPercentage;
  final int percentile;

  const UserRank({
    required this.exerciseId,
    required this.exerciseName,
    required this.currentWeight,
    required this.bodyweight,
    required this.ratio,
    required this.rankTier,
    required this.tierIndex,
    required this.nextTierRatio,
    required this.progressPercentage,
    required this.percentile,
  });

  @override
  List<Object?> get props => [
        exerciseId,
        exerciseName,
        currentWeight,
        bodyweight,
        ratio,
        rankTier,
        tierIndex,
        nextTierRatio,
        progressPercentage,
        percentile,
      ];
}
