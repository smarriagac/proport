import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:symmetry/features/statistics/presentation/widgets/symmetry_body_painter.dart';

void main() {
  group('SymmetryBodyDiagram & SymmetryBodyPainter Tests', () {
    testWidgets('renders SymmetryBodyDiagram without errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SymmetryBodyDiagram(
              height: 380,
            ),
          ),
        ),
      );

      expect(find.byType(SymmetryBodyDiagram), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('renders SymmetryBodyDiagram with custom muscle colors',
        (WidgetTester tester) async {
      const customColors = {
        'shoulders': Color(0xFF3875FF),
        'chest': Color(0xFF00E599),
        'abs': Color(0xFFFF6A00),
      };

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SymmetryBodyDiagram(
              height: 380,
              muscleColors: customColors,
            ),
          ),
        ),
      );

      expect(find.byType(SymmetryBodyDiagram), findsOneWidget);
    });

    test('SymmetryBodyPainter shouldRepaint returns correct bool', () {
      const painter1 = SymmetryBodyPainter(muscleColors: {'chest': Colors.red});
      const painter2 = SymmetryBodyPainter(muscleColors: {'chest': Colors.blue});
      const painter3 = SymmetryBodyPainter(muscleColors: {'chest': Colors.red});

      expect(painter1.shouldRepaint(painter2), isTrue);
      expect(painter1.shouldRepaint(painter3), isFalse);
    });
  });
}
