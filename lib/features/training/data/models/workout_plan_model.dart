import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/workout_plan.dart';
import 'training_session_model.dart';

part 'workout_plan_model.freezed.dart';
part 'workout_plan_model.g.dart';

@freezed
abstract class WorkoutPlanModel with _$WorkoutPlanModel {
  const WorkoutPlanModel._();

  const factory WorkoutPlanModel({
    required String planId,
    required String name,
    @Default('') String description,
    @Default('hypertrophy') String ruleset,
    @Default('gym') String equipmentCategory,
    @Default('beginner') String level,
    @Default('all') String gender,
    @Default(45) int durationPerSession,
    @Default([]) List<TrainingSessionModel> trainingSessions,
    String? thumbnailURL,
  }) = _WorkoutPlanModel;

  factory WorkoutPlanModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanModelFromJson(json);

  WorkoutPlan toDomain({Map<int, String>? nameMap}) {
    return WorkoutPlan(
      planId: planId,
      name: name,
      description: description,
      ruleset: ruleset,
      equipmentCategory: equipmentCategory,
      level: level,
      gender: gender,
      durationPerSession: durationPerSession,
      trainingSessions: trainingSessions
          .map((s) => s.toDomain(nameMap: nameMap))
          .toList(),
      thumbnailURL: thumbnailURL,
    );
  }

  factory WorkoutPlanModel.fromDomain(WorkoutPlan plan) {
    return WorkoutPlanModel(
      planId: plan.planId,
      name: plan.name,
      description: plan.description,
      ruleset: plan.ruleset,
      equipmentCategory: plan.equipmentCategory,
      level: plan.level,
      gender: plan.gender,
      durationPerSession: plan.durationPerSession,
      trainingSessions:
          plan.trainingSessions.map(TrainingSessionModel.fromDomain).toList(),
      thumbnailURL: plan.thumbnailURL,
    );
  }
}
