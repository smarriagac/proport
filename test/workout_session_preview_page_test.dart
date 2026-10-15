import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:symmetry/features/training/domain/entities/training_session.dart';
import 'package:symmetry/features/training/presentation/pages/workout_session_preview_page.dart';

void main() {
  testWidgets('WorkoutSessionPreviewPage renders authentic header, muscles, and CTA', (tester) async {
    const testSession = TrainingSession(
      dayOfWeek: 5,
      name: 'Entrenamiento Pro',
      description: 'Sesión Pro',
      durationMinutes: 120,
      exercises: [],
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: WorkoutSessionPreviewPage(session: testSession),
      ),
    );

    expect(find.text('Entrenamiento Pro'), findsOneWidget);
    expect(find.text('10 Ejercicios, 120 min'), findsOneWidget);
    expect(find.text('Distribución Muscular'), findsOneWidget);
    expect(find.text('Hombros'), findsOneWidget);
    expect(find.text('Tríceps'), findsOneWidget);
    expect(find.text('Pecho'), findsOneWidget);
    expect(find.text('10 Ejercicios'), findsOneWidget);
    expect(find.text('Andar En Cinta De Correr'), findsOneWidget);
    expect(find.text('Press De Banca Inclinado (Barra Recta)'), findsOneWidget);
    expect(find.text('Empezar Entrenamiento'), findsOneWidget);
  });
}
