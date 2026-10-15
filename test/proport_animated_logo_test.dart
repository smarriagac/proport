import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proport/features/splash/presentation/widgets/proport_animated_logo.dart';

void main() {
  group('ProportAnimatedLogo Widget Tests', () {
    testWidgets('renders cleanly at progress 0.0 (initial state)', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProportAnimatedLogo(
              progress: 0.0,
              size: 120,
            ),
          ),
        ),
      );

      expect(find.byType(ProportAnimatedLogo), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('renders cleanly at progress 0.35 (line tracing phase)', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProportAnimatedLogo(
              progress: 0.35,
              size: 120,
            ),
          ),
        ),
      );

      expect(find.byType(ProportAnimatedLogo), findsOneWidget);
    });

    testWidgets('renders cleanly at progress 0.70 (fill fade-in phase)', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProportAnimatedLogo(
              progress: 0.70,
              size: 120,
            ),
          ),
        ),
      );

      expect(find.byType(ProportAnimatedLogo), findsOneWidget);
    });

    testWidgets('renders cleanly at progress 1.0 (completed logo with shimmer)', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProportAnimatedLogo(
              progress: 1.0,
              size: 120,
            ),
          ),
        ),
      );

      expect(find.byType(ProportAnimatedLogo), findsOneWidget);
    });
  });
}
