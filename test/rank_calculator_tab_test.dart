import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:symmetry/features/statistics/presentation/widgets/rank_calculator_tab_content.dart';

void main() {
  testWidgets('RankCalculatorTabContent renders authentic hero badges, title, and cta',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RankCalculatorTabContent(),
        ),
      ),
    );

    // Hero title
    expect(find.text('Descubre tu rango en 20\nsegundos'), findsOneWidget);

    // Subtitle
    expect(
        find.text(
            'Dinos tu mejor serie en un ejercicio y te damos una estimación.'),
        findsOneWidget);

    // Button
    expect(find.text('Calcula tu rango'), findsOneWidget);

    // Badges hero image
    expect(find.byType(Image), findsOneWidget);
  });
}
