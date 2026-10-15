import 'package:equatable/equatable.dart';
import 'exercise_set.dart';

class Exercise extends Equatable {
  final int exerciseTemplateId;
  final String name;
  final String? note;
  final String muscleGroup;
  final String? thumbnailURL;
  final List<ExerciseSet> sets;

  const Exercise({
    required this.exerciseTemplateId,
    required this.name,
    this.note,
    this.muscleGroup = 'General',
    this.thumbnailURL,
    this.sets = const [],
  });

  Exercise copyWith({
    int? exerciseTemplateId,
    String? name,
    String? note,
    String? muscleGroup,
    String? thumbnailURL,
    List<ExerciseSet>? sets,
  }) {
    return Exercise(
      exerciseTemplateId: exerciseTemplateId ?? this.exerciseTemplateId,
      name: name ?? this.name,
      note: note ?? this.note,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      thumbnailURL: thumbnailURL ?? this.thumbnailURL,
      sets: sets ?? this.sets,
    );
  }

  @override
  List<Object?> get props => [
        exerciseTemplateId,
        name,
        note,
        muscleGroup,
        thumbnailURL,
        sets,
      ];
}
