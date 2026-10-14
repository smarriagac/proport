import 'package:equatable/equatable.dart';
import 'training_session.dart';

class WorkoutPlan extends Equatable {
  final String planId;
  final String name;
  final String description;
  final String ruleset;
  final String equipmentCategory;
  final String level;
  final String gender;
  final int durationPerSession;
  final List<TrainingSession> trainingSessions;
  final String? thumbnailURL;

  const WorkoutPlan({
    required this.planId,
    required this.name,
    required this.description,
    required this.ruleset,
    required this.equipmentCategory,
    required this.level,
    required this.gender,
    required this.durationPerSession,
    required this.trainingSessions,
    this.thumbnailURL,
  });

  WorkoutPlan copyWith({
    String? planId,
    String? name,
    String? description,
    String? ruleset,
    String? equipmentCategory,
    String? level,
    String? gender,
    int? durationPerSession,
    List<TrainingSession>? trainingSessions,
    String? thumbnailURL,
  }) {
    return WorkoutPlan(
      planId: planId ?? this.planId,
      name: name ?? this.name,
      description: description ?? this.description,
      ruleset: ruleset ?? this.ruleset,
      equipmentCategory: equipmentCategory ?? this.equipmentCategory,
      level: level ?? this.level,
      gender: gender ?? this.gender,
      durationPerSession: durationPerSession ?? this.durationPerSession,
      trainingSessions: trainingSessions ?? this.trainingSessions,
      thumbnailURL: thumbnailURL ?? this.thumbnailURL,
    );
  }

  @override
  List<Object?> get props => [
        planId,
        name,
        description,
        ruleset,
        equipmentCategory,
        level,
        gender,
        durationPerSession,
        trainingSessions,
        thumbnailURL,
      ];
}
