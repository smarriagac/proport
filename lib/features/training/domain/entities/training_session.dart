import 'package:equatable/equatable.dart';
import 'exercise.dart';

class TrainingSession extends Equatable {
  final int dayOfWeek;
  final String name;
  final String description;
  final List<Exercise> exercises;
  final bool isCompleted;
  final DateTime? completedAt;
  final int? durationMinutes;

  const TrainingSession({
    required this.dayOfWeek,
    required this.name,
    required this.description,
    required this.exercises,
    this.isCompleted = false,
    this.completedAt,
    this.durationMinutes,
  });

  TrainingSession copyWith({
    int? dayOfWeek,
    String? name,
    String? description,
    List<Exercise>? exercises,
    bool? isCompleted,
    DateTime? completedAt,
    int? durationMinutes,
  }) {
    return TrainingSession(
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
        dayOfWeek,
        name,
        description,
        exercises,
        isCompleted,
        completedAt,
        durationMinutes,
      ];
}
