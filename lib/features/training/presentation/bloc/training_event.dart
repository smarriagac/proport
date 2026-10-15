import 'package:equatable/equatable.dart';
import '../../domain/entities/training_session.dart';
import '../../domain/entities/exercise.dart';

abstract class TrainingEvent extends Equatable {
  const TrainingEvent();

  @override
  List<Object?> get props => [];
}

class LoadWorkoutPlansEvent extends TrainingEvent {
  const LoadWorkoutPlansEvent();
}

class SelectWorkoutPlanEvent extends TrainingEvent {
  final String planId;
  const SelectWorkoutPlanEvent(this.planId);

  @override
  List<Object?> get props => [planId];
}

class StartWorkoutSessionEvent extends TrainingEvent {
  final TrainingSession session;
  const StartWorkoutSessionEvent(this.session);

  @override
  List<Object?> get props => [session];
}

class AddExerciseToSessionEvent extends TrainingEvent {
  final Exercise exercise;
  const AddExerciseToSessionEvent(this.exercise);

  @override
  List<Object?> get props => [exercise];
}

class ToggleSetCompletionEvent extends TrainingEvent {
  final int exerciseIndex;
  final int setIndex;
  final double weight;
  final int reps;

  const ToggleSetCompletionEvent({
    required this.exerciseIndex,
    required this.setIndex,
    required this.weight,
    required this.reps,
  });

  @override
  List<Object?> get props => [exerciseIndex, setIndex, weight, reps];
}

class AddSetEvent extends TrainingEvent {
  final int exerciseIndex;
  const AddSetEvent(this.exerciseIndex);

  @override
  List<Object?> get props => [exerciseIndex];
}

class FinishWorkoutSessionEvent extends TrainingEvent {
  const FinishWorkoutSessionEvent();
}

class TickRestTimerEvent extends TrainingEvent {
  final int secondsRemaining;
  const TickRestTimerEvent(this.secondsRemaining);

  @override
  List<Object?> get props => [secondsRemaining];
}

class StopRestTimerEvent extends TrainingEvent {
  const StopRestTimerEvent();
}
