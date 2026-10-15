import 'package:equatable/equatable.dart';
import 'exercise.dart';

class TrainingSession extends Equatable {
  final String? templateId;
  final int dayOfWeek;
  final String name;
  final String description;
  final List<Exercise> exercises;
  final bool isCompleted;
  final DateTime? completedAt;
  final int? durationMinutes;

  const TrainingSession({
    this.templateId,
    required this.dayOfWeek,
    required this.name,
    required this.description,
    required this.exercises,
    this.isCompleted = false,
    this.completedAt,
    this.durationMinutes,
  });

  String? get id => templateId;

  TrainingSession copyWith({
    String? templateId,
    String? id,
    int? dayOfWeek,
    String? name,
    String? description,
    List<Exercise>? exercises,
    bool? isCompleted,
    DateTime? completedAt,
    int? durationMinutes,
  }) {
    return TrainingSession(
      templateId: templateId ?? id ?? this.templateId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      name: name ?? this.name,
      description: description ?? this.description,
      exercises: exercises ?? this.exercises,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
    );
  }

  @override
  List<Object?> get props => [
        templateId,
        dayOfWeek,
        name,
        description,
        exercises,
        isCompleted,
        completedAt,
        durationMinutes,
      ];
}
