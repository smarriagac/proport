import 'package:equatable/equatable.dart';

class ExerciseSet extends Equatable {
  final int setNumber;
  final int reps;
  final double weightKg;
  final int restSeconds;
  final int? durationSeconds;
  final bool isCompleted;

  const ExerciseSet({
    required this.setNumber,
    required this.reps,
    this.weightKg = 0.0,
    this.restSeconds = 90,
    this.durationSeconds,
    this.isCompleted = false,
  });

  ExerciseSet copyWith({
    int? setNumber,
    int? reps,
    double? weightKg,
    int? restSeconds,
    int? durationSeconds,
    bool? isCompleted,
  }) {
    return ExerciseSet(
      setNumber: setNumber ?? this.setNumber,
      reps: reps ?? this.reps,
      weightKg: weightKg ?? this.weightKg,
      restSeconds: restSeconds ?? this.restSeconds,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        setNumber,
        reps,
        weightKg,
        restSeconds,
        durationSeconds,
        isCompleted,
      ];
}
