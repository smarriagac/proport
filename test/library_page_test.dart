import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:symmetry/features/library/presentation/pages/library_page.dart';

void main() {
  testWidgets('LibraryPage renders authentic header, category chips, templates, and action cards',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LibraryPage(),
      ),
    );

    // App Bar Title
    expect(find.text('Mi biblioteca'), findsOneWidget);

    // Category Chips
    expect(find.text('Tu plan inteligente'), findsOneWidget);
    expect(find.text('Programas'), findsOneWidget);
    expect(find.text('Plantillas'), findsOneWidget);
    expect(find.text('Ejercicios'), findsOneWidget);

    // Workout Templates
    expect(find.text('Domingo'), findsOneWidget);
    expect(find.text('Sábado de Tracción 🦍'), findsOneWidget);
    expect(find.text('Sábado de Empuje 😤'), findsOneWidget);
    expect(find.text('Pecho, Triceps'), findsOneWidget);
    expect(find.text('Espalda, Biceps'), findsOneWidget);
    expect(find.text('Piernas, Hombros'), findsOneWidget);

    // Scroll down to reveal Bottom Action Cards
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
    await tester.pump();

    // Bottom Action Cards
    expect(find.text('Explorar programas'), findsOneWidget);
    expect(find.text('Elige de entre 80+ programas distintos'), findsOneWidget);
    expect(find.text('Crear programa'), findsOneWidget);
    expect(find.text('Arma tu plan para seguir semanalmente'), findsOneWidget);
  });
}
