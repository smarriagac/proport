import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/exercise_set.dart';

part 'exercise_set_model.freezed.dart';
part 'exercise_set_model.g.dart';

@freezed
abstract class ExerciseSetModel with _$ExerciseSetModel {
  const ExerciseSetModel._();

  const factory ExerciseSetModel({
    @Default(1) int setNumber,
    @Default(10) int reps,
    @Default(0.0) double weightKg,
    @Default(90) int restSeconds,
    int? durationSeconds,
    @Default(false) bool isCompleted,
  }) = _ExerciseSetModel;

  factory ExerciseSetModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSetModelFromJson(json);

  ExerciseSet toDomain() {
    return ExerciseSet(
      setNumber: setNumber,
      reps: reps,
      weightKg: weightKg,
      restSeconds: restSeconds,
      durationSeconds: durationSeconds,
      isCompleted: isCompleted,
    );
  }

  factory ExerciseSetModel.fromDomain(ExerciseSet set) {
    return ExerciseSetModel(
      setNumber: set.setNumber,
      reps: set.reps,
      weightKg: set.weightKg,
      restSeconds: set.restSeconds,
      durationSeconds: set.durationSeconds,
      isCompleted: set.isCompleted,
    );
  }
}
