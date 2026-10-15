import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_workout_plans_usecase.dart';
import '../../domain/usecases/log_workout_session_usecase.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_set.dart';
import '../../domain/entities/training_session.dart';
import 'training_event.dart';
import 'training_state.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  final GetWorkoutPlansUseCase getWorkoutPlansUseCase;
  final LogWorkoutSessionUseCase logWorkoutSessionUseCase;
  Timer? _restTimer;

  TrainingBloc({
    required this.getWorkoutPlansUseCase,
    required this.logWorkoutSessionUseCase,
  }) : super(const TrainingState.initial()) {
    on<LoadWorkoutPlansEvent>(_onLoadWorkoutPlans);
    on<SelectWorkoutPlanEvent>(_onSelectWorkoutPlan);
    on<StartWorkoutSessionEvent>(_onStartWorkoutSession);
    on<AddExerciseToSessionEvent>(_onAddExerciseToSession);
    on<ReplaceExerciseInSessionEvent>(_onReplaceExerciseInSession);
    on<ToggleSetCompletionEvent>(_onToggleSetCompletion);
    on<AddSetEvent>(_onAddSet);
    on<FinishWorkoutSessionEvent>(_onFinishWorkoutSession);
    on<TickRestTimerEvent>(_onTickRestTimer);
    on<StopRestTimerEvent>(_onStopRestTimer);
  }

  Future<void> _onLoadWorkoutPlans(
    LoadWorkoutPlansEvent event,
    Emitter<TrainingState> emit,
  ) async {
    emit(const TrainingState.loading());
    try {
      final plans = await getWorkoutPlansUseCase();
      emit(TrainingState.loaded(
        plans: plans,
        selectedPlan: plans.isNotEmpty ? plans.first : null,
      ));
    } catch (e) {
      emit(TrainingState.error('Failed to load workout plans: $e'));
    }
  }

  void _onSelectWorkoutPlan(
    SelectWorkoutPlanEvent event,
    Emitter<TrainingState> emit,
  ) {
    state.maybeWhen(
      loaded: (plans, _, activeSession, restSec, isRestActive, completed) {
        final plan = plans.firstWhere(
          (p) => p.planId == event.planId,
          orElse: () => plans.first,
        );
        emit(TrainingState.loaded(
          plans: plans,
          selectedPlan: plan,
          activeSession: activeSession,
          restTimerSeconds: restSec,
          isRestTimerActive: isRestActive,
          completedSessions: completed,
        ));
      },
      orElse: () {},
    );
  }

  void _onStartWorkoutSession(
    StartWorkoutSessionEvent event,
    Emitter<TrainingState> emit,
  ) {
    state.maybeWhen(
      loaded: (plans, selectedPlan, _, restSec, isRestActive, completed) {
        emit(TrainingState.loaded(
          plans: plans,
          selectedPlan: selectedPlan,
          activeSession: event.session,
          restTimerSeconds: 0,
          isRestTimerActive: false,
          completedSessions: completed,
        ));
      },
      orElse: () {},
    );
  }

  void _onAddExerciseToSession(
    AddExerciseToSessionEvent event,
    Emitter<TrainingState> emit,
  ) {
    state.maybeWhen(
      loaded: (plans, selectedPlan, activeSession, restSec, isRestActive, completed) {
        final currentSession = activeSession ??
            TrainingSession(
              dayOfWeek: DateTime.now().weekday,
              name: 'Entrenamiento Libre',
              description: '',
              exercises: const [],
            );
        final updatedExercises = List<Exercise>.from(currentSession.exercises)..add(event.exercise);
        final updatedSession = currentSession.copyWith(exercises: updatedExercises);
        emit(TrainingState.loaded(
          plans: plans,
          selectedPlan: selectedPlan,
          activeSession: updatedSession,
          restTimerSeconds: restSec,
          isRestTimerActive: isRestActive,
          completedSessions: completed,
        ));
      },
      orElse: () {},
    );
  }

  void _onReplaceExerciseInSession(
    ReplaceExerciseInSessionEvent event,
    Emitter<TrainingState> emit,
  ) {
    state.maybeWhen(
      loaded: (plans, selectedPlan, activeSession, restSec, isRestActive, completed) {
        if (activeSession == null || event.exerciseIndex >= activeSession.exercises.length) return;
        final currentExercises = List<Exercise>.from(activeSession.exercises);
        final oldExercise = currentExercises[event.exerciseIndex];
        currentExercises[event.exerciseIndex] = event.newExercise.copyWith(
          sets: oldExercise.sets.isNotEmpty ? oldExercise.sets : event.newExercise.sets,
        );
        final updatedSession = activeSession.copyWith(exercises: currentExercises);
        emit(TrainingState.loaded(
          plans: plans,
          selectedPlan: selectedPlan,
          activeSession: updatedSession,
          restTimerSeconds: restSec,
          isRestTimerActive: isRestActive,
          completedSessions: completed,
        ));
      },
      orElse: () {},
    );
  }

  void _onToggleSetCompletion(
    ToggleSetCompletionEvent event,
    Emitter<TrainingState> emit,
  ) {
    state.maybeWhen(
      loaded: (plans, selectedPlan, activeSession, restSec, isRestActive, completed) {
        if (activeSession == null) return;
        if (event.exerciseIndex >= activeSession.exercises.length) return;

        final currentExercise = activeSession.exercises[event.exerciseIndex];
        if (event.setIndex >= currentExercise.sets.length) return;

        final currentSet = currentExercise.sets[event.setIndex];
        final newIsCompleted = !currentSet.isCompleted;

        final updatedSet = currentSet.copyWith(
          reps: event.reps,
          weightKg: event.weight,
          isCompleted: newIsCompleted,
        );

        final updatedSets = List<ExerciseSet>.from(currentExercise.sets);
        updatedSets[event.setIndex] = updatedSet;

        final updatedExercise = currentExercise.copyWith(sets: updatedSets);
        final updatedExercises = List<Exercise>.from(activeSession.exercises);
        updatedExercises[event.exerciseIndex] = updatedExercise;

        final updatedSession = activeSession.copyWith(exercises: updatedExercises);

        if (newIsCompleted) {
          _startRestTimer(currentSet.restSeconds > 0 ? currentSet.restSeconds : 90);
        }

        emit(TrainingState.loaded(
          plans: plans,
          selectedPlan: selectedPlan,
          activeSession: updatedSession,
          restTimerSeconds: newIsCompleted ? (currentSet.restSeconds > 0 ? currentSet.restSeconds : 90) : restSec,
          isRestTimerActive: newIsCompleted ? true : isRestActive,
          completedSessions: completed,
        ));
      },
      orElse: () {},
    );
  }

  void _onAddSet(
    AddSetEvent event,
    Emitter<TrainingState> emit,
  ) {
    state.maybeWhen(
      loaded: (plans, selectedPlan, activeSession, restSec, isRestActive, completed) {
        if (activeSession == null) return;
        if (event.exerciseIndex >= activeSession.exercises.length) return;

        final currentExercise = activeSession.exercises[event.exerciseIndex];
        final lastSet = currentExercise.sets.isNotEmpty
            ? currentExercise.sets.last
            : const ExerciseSet(setNumber: 1, reps: 10, weightKg: 20);

        final newSet = ExerciseSet(
          setNumber: currentExercise.sets.length + 1,
          reps: lastSet.reps,
          weightKg: lastSet.weightKg,
          restSeconds: lastSet.restSeconds,
        );

        final updatedSets = List<ExerciseSet>.from(currentExercise.sets)..add(newSet);
        final updatedExercise = currentExercise.copyWith(sets: updatedSets);
        final updatedExercises = List<Exercise>.from(activeSession.exercises);
        updatedExercises[event.exerciseIndex] = updatedExercise;

        emit(TrainingState.loaded(
          plans: plans,
          selectedPlan: selectedPlan,
          activeSession: activeSession.copyWith(exercises: updatedExercises),
          restTimerSeconds: restSec,
          isRestTimerActive: isRestActive,
          completedSessions: completed,
        ));
      },
      orElse: () {},
    );
  }

  Future<void> _onFinishWorkoutSession(
    FinishWorkoutSessionEvent event,
    Emitter<TrainingState> emit,
  ) async {
    _restTimer?.cancel();
    await state.maybeWhen(
      loaded: (plans, selectedPlan, activeSession, _, __, completed) async {
        if (activeSession == null) return;

        final finishedSession = activeSession.copyWith(
          isCompleted: true,
          completedAt: DateTime.now(),
          durationMinutes: 42,
        );

        await logWorkoutSessionUseCase(finishedSession);

        final updatedCompleted = List<TrainingSession>.from(completed)..add(finishedSession);

        emit(TrainingState.loaded(
          plans: plans,
          selectedPlan: selectedPlan,
          activeSession: null,
          restTimerSeconds: 0,
          isRestTimerActive: false,
          completedSessions: updatedCompleted,
        ));
      },
      orElse: () async {},
    );
  }

  void _onTickRestTimer(
    TickRestTimerEvent event,
    Emitter<TrainingState> emit,
  ) {
    state.maybeWhen(
      loaded: (plans, selectedPlan, activeSession, _, isRestActive, completed) {
        if (event.secondsRemaining <= 0) {
          _restTimer?.cancel();
          emit(TrainingState.loaded(
            plans: plans,
            selectedPlan: selectedPlan,
            activeSession: activeSession,
            restTimerSeconds: 0,
            isRestTimerActive: false,
            completedSessions: completed,
          ));
        } else {
          emit(TrainingState.loaded(
            plans: plans,
            selectedPlan: selectedPlan,
            activeSession: activeSession,
            restTimerSeconds: event.secondsRemaining,
            isRestTimerActive: true,
            completedSessions: completed,
          ));
        }
      },
      orElse: () {},
    );
  }

  void _onStopRestTimer(
    StopRestTimerEvent event,
    Emitter<TrainingState> emit,
  ) {
    _restTimer?.cancel();
    state.maybeWhen(
      loaded: (plans, selectedPlan, activeSession, _, __, completed) {
        emit(TrainingState.loaded(
          plans: plans,
          selectedPlan: selectedPlan,
          activeSession: activeSession,
          restTimerSeconds: 0,
          isRestTimerActive: false,
          completedSessions: completed,
        ));
      },
      orElse: () {},
    );
  }

  void _startRestTimer(int durationSeconds) {
    _restTimer?.cancel();
    int current = durationSeconds;
    add(TickRestTimerEvent(current));
    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      current--;
      add(TickRestTimerEvent(current));
      if (current <= 0) {
        timer.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _restTimer?.cancel();
    return super.close();
  }
}
