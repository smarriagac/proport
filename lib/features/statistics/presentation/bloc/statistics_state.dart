import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_rank.dart';
import '../../domain/entities/muscle_volume.dart';

part 'statistics_state.freezed.dart';

@freezed
class StatisticsState with _$StatisticsState {
  const factory StatisticsState.initial() = _Initial;
  const factory StatisticsState.loading() = _Loading;
  const factory StatisticsState.loaded({
    required double symmetryScore,
    required List<UserRank> ranks,
    required List<MuscleVolume> volumes,
  }) = _Loaded;
  const factory StatisticsState.error(String message) = _Error;
}
