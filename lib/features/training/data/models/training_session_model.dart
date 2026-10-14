import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/training_session.dart';
import 'exercise_model.dart';

part 'training_session_model.freezed.dart';
part 'training_session_model.g.dart';

@freezed
abstract class TrainingSessionModel with _$TrainingSessionModel {
  const TrainingSessionModel._();

  const factory TrainingSessionModel({
    required int dayOfWeek,
    required String name,
    @Default('') String description,
    @Default([]) List<ExerciseModel> exercises,
    @Default(false) bool isCompleted,
    DateTime? completedAt,
    int? durationMinutes,
  }) = _TrainingSessionModel;

  factory TrainingSessionModel.fromJson(Map<String, dynamic> json) =>
      _$TrainingSessionModelFromJson(json);

  TrainingSession toDomain({Map<int, String>? nameMap}) {
    return TrainingSession(
      dayOfWeek: dayOfWeek,
      name: name,
      description: description,
      exercises: exercises
          .map((e) => e.toDomain(
                fallbackName: nameMap?[e.exerciseTemplateId],
              ))
          .toList(),
      isCompleted: isCompleted,
      completedAt: completedAt,
      durationMinutes: durationMinutes,
    );
  }

  factory TrainingSessionModel.fromDomain(TrainingSession session) {
    return TrainingSessionModel(
      dayOfWeek: session.dayOfWeek,
      name: session.name,
      description: session.description,
      exercises: session.exercises.map(ExerciseModel.fromDomain).toList(),
      isCompleted: session.isCompleted,
      completedAt: session.completedAt,
      durationMinutes: session.durationMinutes,
    );
  }
}
