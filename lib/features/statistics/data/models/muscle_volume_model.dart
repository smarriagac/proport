import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/muscle_volume.dart';

part 'muscle_volume_model.freezed.dart';
part 'muscle_volume_model.g.dart';

@freezed
abstract class MuscleVolumeModel with _$MuscleVolumeModel {
  const MuscleVolumeModel._();

  const factory MuscleVolumeModel({
    required String muscleGroup,
    required int weeklySets,
    @Default(10) int optimalMinSets,
    @Default(20) int optimalMaxSets,
    required double symmetryScore,
    required String status,
  }) = _MuscleVolumeModel;

  factory MuscleVolumeModel.fromJson(Map<String, dynamic> json) =>
      _$MuscleVolumeModelFromJson(json);

  MuscleVolume toDomain() {
    return MuscleVolume(
      muscleGroup: muscleGroup,
      weeklySets: weeklySets,
      optimalMinSets: optimalMinSets,
      optimalMaxSets: optimalMaxSets,
      symmetryScore: symmetryScore,
      status: status,
    );
  }

  factory MuscleVolumeModel.fromDomain(MuscleVolume domain) {
    return MuscleVolumeModel(
      muscleGroup: domain.muscleGroup,
      weeklySets: domain.weeklySets,
      optimalMinSets: domain.optimalMinSets,
      optimalMaxSets: domain.optimalMaxSets,
      symmetryScore: domain.symmetryScore,
      status: domain.status,
    );
  }
}
