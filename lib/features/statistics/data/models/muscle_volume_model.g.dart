// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muscle_volume_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MuscleVolumeModel _$MuscleVolumeModelFromJson(Map<String, dynamic> json) =>
    _MuscleVolumeModel(
      muscleGroup: json['muscleGroup'] as String,
      weeklySets: (json['weeklySets'] as num).toInt(),
      optimalMinSets: (json['optimalMinSets'] as num?)?.toInt() ?? 10,
      optimalMaxSets: (json['optimalMaxSets'] as num?)?.toInt() ?? 20,
      symmetryScore: (json['symmetryScore'] as num).toDouble(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$MuscleVolumeModelToJson(_MuscleVolumeModel instance) =>
    <String, dynamic>{
      'muscleGroup': instance.muscleGroup,
      'weeklySets': instance.weeklySets,
      'optimalMinSets': instance.optimalMinSets,
      'optimalMaxSets': instance.optimalMaxSets,
      'symmetryScore': instance.symmetryScore,
      'status': instance.status,
    };
