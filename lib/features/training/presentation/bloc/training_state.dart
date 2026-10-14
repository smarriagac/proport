import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/workout_plan.dart';
import '../../domain/entities/training_session.dart';

part 'training_state.freezed.dart';

@freezed
class TrainingState with _$TrainingState {
  const factory TrainingState.initial() = _Initial;
  const factory TrainingState.loading() = _Loading;
  const factory TrainingState.loaded({
    required List<WorkoutPlan> plans,
    WorkoutPlan? selectedPlan,
    TrainingSession? activeSession,
    @Default(0) int restTimerSeconds,
    @Default(false) bool isRestTimerActive,
    @Default([]) List<TrainingSession> completedSessions,
  }) = _Loaded;
  const factory TrainingState.error(String message) = _Error;
}
