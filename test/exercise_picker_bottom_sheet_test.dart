import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proport/features/training/domain/entities/exercise.dart';
import 'package:proport/features/training/presentation/widgets/exercise_picker_bottom_sheet.dart';

void main() {
  testWidgets('ExercisePickerBottomSheet renders search, categories, and exercise list',
      (tester) async {
    Exercise? selectedExercise;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                selectedExercise = await ExercisePickerBottomSheet.show(context);
              },
              child: const Text('Open Picker'),
            ),
          ),
        ),
      ),
    );

    // Tap to open bottom sheet
    await tester.tap(find.text('Open Picker'));
    await tester.pumpAndSettle();

    // Verify title and search field
    expect(find.text('Añadir Ejercicio'), findsOneWidget);
    expect(find.text('Buscar por nombre o músculo...'), findsOneWidget);

    // Verify category chips
    expect(find.text('Todos'), findsOneWidget);
    expect(find.text('Pecho'), findsWidgets);
    expect(find.text('Espalda'), findsWidgets);
    expect(find.text('Piernas'), findsWidgets);
    expect(find.text('Hombros'), findsWidgets);

    // Verify fallback exercises are visible
    expect(find.text('Press De Banca Inclinado (Barra Recta)'), findsOneWidget);

    // Search for a specific exercise
    await tester.enterText(
        find.widgetWithText(TextField, 'Buscar por nombre o músculo...'), 'Cinta');
    await tester.pumpAndSettle();

    // Verify filtered results
    expect(find.text('Andar En Cinta De Correr'), findsOneWidget);
    expect(find.text('Press De Banca Inclinado (Barra Recta)'), findsNothing);

    // Tap the exercise item to select it
    await tester.tap(find.text('Andar En Cinta De Correr'));
    await tester.pumpAndSettle();

    // Verify the bottom sheet closed and returned an exercise with 3 default sets
    expect(selectedExercise, isNotNull);
    expect(selectedExercise!.name, 'Andar En Cinta De Correr');
    expect(selectedExercise!.sets.length, 3);
    expect(selectedExercise!.sets.first.reps, 10);
  });
}
