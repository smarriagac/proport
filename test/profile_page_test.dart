import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:symmetry/features/profile/presentation/pages/profile_page.dart';
import 'package:symmetry/features/statistics/presentation/widgets/symmetry_body_painter.dart';

void main() {
  testWidgets('ProfilePage renders authentic header, stats, action buttons and history grid',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfilePage(),
      ),
    );

    // Header & User Handle
    expect(find.text('@smarriagac'), findsOneWidget);
    expect(find.text('smarriagac'), findsOneWidget);

    // Stats
    expect(find.text('133'), findsOneWidget);
    expect(find.text('Entrenos'), findsOneWidget);
    expect(find.text('Seguidores'), findsOneWidget);
    expect(find.text('Siguiendo'), findsOneWidget);

    // Action buttons
    expect(find.text('Escaneo'), findsOneWidget);
    expect(find.text('Peso'), findsOneWidget);

    // Grid cards
    expect(find.text('Ayer'), findsOneWidget);
    expect(find.text('11/10'), findsOneWidget);
    expect(find.text('10/10'), findsOneWidget);

    // Mini anatomical body diagrams
    expect(find.byType(SymmetryBodyDiagram), findsWidgets);
  });
}
