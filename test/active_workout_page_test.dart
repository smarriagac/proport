import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proport/features/training/domain/entities/exercise.dart';
import 'package:proport/features/training/domain/entities/exercise_set.dart';
import 'package:proport/features/training/domain/entities/training_session.dart';
import 'package:proport/features/training/presentation/bloc/training_bloc.dart';
import 'package:proport/features/training/presentation/bloc/training_state.dart';
import 'package:proport/features/training/presentation/pages/active_workout_page.dart';

class MockTrainingBloc extends Cubit<TrainingState> implements TrainingBloc {
  MockTrainingBloc()
      : super(
          const TrainingState.loaded(
            plans: [],
            selectedPlan: null,
            activeSession: TrainingSession(
              dayOfWeek: 1,
              name: 'Sesión de Espalda',
              description: 'Prueba',
              exercises: [
                Exercise(
                  exerciseTemplateId: 201,
                  name: 'Jalón Al Pecho Agarre Prono (Máquina)',
                  muscleGroup: 'Espalda',
                  sets: [
                    ExerciseSet(setNumber: 1, reps: 10, weightKg: 18),
                    ExerciseSet(setNumber: 2, reps: 10, weightKg: 86),
                    ExerciseSet(setNumber: 3, reps: 10, weightKg: 86),
                  ],
                ),
              ],
            ),
            restTimerSeconds: 0,
            isRestTimerActive: false,
            completedSessions: [],
          ),
        );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('ActiveWorkoutPage renders authentic workout runner components', (tester) async {
    final mockBloc = MockTrainingBloc();

    await tester.pumpWidget(
      BlocProvider<TrainingBloc>.value(
        value: mockBloc,
        child: const MaterialApp(
          home: ActiveWorkoutPage(),
        ),
      ),
    );

    // Initial pump and frame
    await tester.pump();

    expect(find.text('Terminar'), findsOneWidget);
    expect(find.text('Jalón Al Pecho Agarre Prono (Máquina)'), findsOneWidget);
    expect(find.text('Tutorial'), findsOneWidget);
    expect(find.text('Reemplazar'), findsOneWidget);
    expect(find.text('Notas'), findsOneWidget);
    expect(find.text('SERIE'), findsOneWidget);
    expect(find.text('PREVIA'), findsOneWidget);
    expect(find.text('KG'), findsOneWidget);
    expect(find.text('REPES'), findsOneWidget);
    expect(find.text('18 x 10'), findsOneWidget);
    expect(find.text('86 x 8'), findsWidgets);
    expect(find.text('Añadir ejercicio', skipOffstage: false), findsOneWidget);
  });
}
