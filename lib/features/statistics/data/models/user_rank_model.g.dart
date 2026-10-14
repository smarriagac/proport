// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserRankModel _$UserRankModelFromJson(Map<String, dynamic> json) =>
    _UserRankModel(
      exerciseId: (json['exerciseId'] as num).toInt(),
      exerciseName: json['exerciseName'] as String,
      currentWeight: (json['currentWeight'] as num).toDouble(),
      bodyweight: (json['bodyweight'] as num).toDouble(),
      ratio: (json['ratio'] as num).toDouble(),
      rankTier: json['rankTier'] as String,
      tierIndex: (json['tierIndex'] as num).toInt(),
      nextTierRatio: (json['nextTierRatio'] as num).toDouble(),
      progressPercentage: (json['progressPercentage'] as num).toDouble(),
      percentile: (json['percentile'] as num).toInt(),
    );

Map<String, dynamic> _$UserRankModelToJson(_UserRankModel instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'exerciseName': instance.exerciseName,
      'currentWeight': instance.currentWeight,
      'bodyweight': instance.bodyweight,
      'ratio': instance.ratio,
      'rankTier': instance.rankTier,
      'tierIndex': instance.tierIndex,
      'nextTierRatio': instance.nextTierRatio,
      'progressPercentage': instance.progressPercentage,
      'percentile': instance.percentile,
    };
