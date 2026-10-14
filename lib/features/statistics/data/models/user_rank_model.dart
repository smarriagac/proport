import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_rank.dart';

part 'user_rank_model.freezed.dart';
part 'user_rank_model.g.dart';

@freezed
abstract class UserRankModel with _$UserRankModel {
  const UserRankModel._();

  const factory UserRankModel({
    required int exerciseId,
    required String exerciseName,
    required double currentWeight,
    required double bodyweight,
    required double ratio,
    required String rankTier,
    required int tierIndex,
    required double nextTierRatio,
    required double progressPercentage,
    required int percentile,
  }) = _UserRankModel;

  factory UserRankModel.fromJson(Map<String, dynamic> json) =>
      _$UserRankModelFromJson(json);

  UserRank toDomain() {
    return UserRank(
      exerciseId: exerciseId,
      exerciseName: exerciseName,
      currentWeight: currentWeight,
      bodyweight: bodyweight,
      ratio: ratio,
      rankTier: rankTier,
      tierIndex: tierIndex,
      nextTierRatio: nextTierRatio,
      progressPercentage: progressPercentage,
      percentile: percentile,
    );
  }

  factory UserRankModel.fromDomain(UserRank domain) {
    return UserRankModel(
      exerciseId: domain.exerciseId,
      exerciseName: domain.exerciseName,
      currentWeight: domain.currentWeight,
      bodyweight: domain.bodyweight,
      ratio: domain.ratio,
      rankTier: domain.rankTier,
      tierIndex: domain.tierIndex,
      nextTierRatio: domain.nextTierRatio,
      progressPercentage: domain.progressPercentage,
      percentile: domain.percentile,
    );
  }
}
