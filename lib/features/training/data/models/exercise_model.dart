import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/exercise.dart';
import 'exercise_set_model.dart';

part 'exercise_model.freezed.dart';
part 'exercise_model.g.dart';

@freezed
abstract class ExerciseModel with _$ExerciseModel {
  const ExerciseModel._();

  const factory ExerciseModel({
    required int exerciseTemplateId,
    @Default('') String name,
    String? note,
    @Default('General') String muscleGroup,
    @Default([]) List<ExerciseSetModel> sets,
  }) = _ExerciseModel;

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);

  Exercise toDomain({String? fallbackName, String? thumbnailURL}) {
    return Exercise(
      exerciseTemplateId: exerciseTemplateId,
      name: name.isNotEmpty ? name : (fallbackName ?? 'Exercise #$exerciseTemplateId'),
      note: note,
      muscleGroup: muscleGroup,
      thumbnailURL: thumbnailURL,
      sets: sets.asMap().entries.map((entry) {
        final idx = entry.key + 1;
        final s = entry.value.toDomain();
        return s.copyWith(setNumber: s.setNumber <= 1 ? idx : s.setNumber);
      }).toList(),
    );
  }

  factory ExerciseModel.fromDomain(Exercise exercise) {
    return ExerciseModel(
      exerciseTemplateId: exercise.exerciseTemplateId,
      name: exercise.name,
      note: exercise.note,
      muscleGroup: exercise.muscleGroup,
      sets: exercise.sets.map(ExerciseSetModel.fromDomain).toList(),
    );
  }
}
