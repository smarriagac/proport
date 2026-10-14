import 'package:equatable/equatable.dart';

class MuscleVolume extends Equatable {
  final String muscleGroup;
  final int weeklySets;
  final int optimalMinSets;
  final int optimalMaxSets;
  final double symmetryScore;
  final String status;

  const MuscleVolume({
    required this.muscleGroup,
    required this.weeklySets,
    this.optimalMinSets = 10,
    this.optimalMaxSets = 20,
    required this.symmetryScore,
    required this.status,
  });

  @override
  List<Object?> get props => [
        muscleGroup,
        weeklySets,
        optimalMinSets,
        optimalMaxSets,
        symmetryScore,
        status,
      ];
}
