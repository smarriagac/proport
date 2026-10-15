import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proport/features/onboarding/presentation/pages/onboarding_page.dart';

void main() {
  testWidgets('OnboardingPage renders all 4 steps and completes onboarding', (tester) async {
    SharedPreferences.setMockInitialValues({'has_completed_onboarding': false});

    final testRouter = GoRouter(
      initialLocation: '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: '/ranks',
          builder: (context, state) => const Scaffold(body: Text('Ranks Destination')),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: testRouter));
    await tester.pump();

    // Step 0: Welcome & Philosophy
    expect(find.text('MÉTRICAS & BIOMECÁNICA'), findsOneWidget);
    expect(find.text('Entrena por proporciones, no solo por volumen'), findsOneWidget);
    expect(find.text('Saltar'), findsOneWidget);
    expect(find.text('CONTINUAR'), findsOneWidget);

    // Tap CONTINUAR -> Step 1
    await tester.tap(find.text('CONTINUAR'));
    await tester.pumpAndSettle();

    // Step 1: Objective
    expect(find.text('¿Cuál es tu objetivo principal?'), findsOneWidget);
    expect(find.text('Ganar masa muscular estética'), findsOneWidget);
    expect(find.text('Definición y pérdida de grasa'), findsOneWidget);
    expect(find.text('Fuerza máxima y potencia'), findsOneWidget);
    expect(find.text('Rendimiento atlético funcional'), findsOneWidget);

    // Select second objective
    await tester.tap(find.text('Definición y pérdida de grasa'));
    await tester.pump();

    // Tap CONTINUAR -> Step 2
    await tester.tap(find.text('CONTINUAR'));
    await tester.pumpAndSettle();

    // Step 2: Experience
    expect(find.text('¿Cuánta experiencia tienes en el gimnasio?'), findsOneWidget);
    expect(find.text('Principiante'), findsOneWidget);
    expect(find.text('Intermedio'), findsOneWidget);
    expect(find.text('Avanzado'), findsOneWidget);

    // Select Avanzado
    await tester.tap(find.text('Avanzado'));
    await tester.pump();

    // Tap CONTINUAR -> Step 3
    await tester.tap(find.text('CONTINUAR'));
    await tester.pumpAndSettle();

    // Step 3: Ready
    expect(find.text('Tu plan Proport está listo'), findsOneWidget);
    expect(find.text('Perfil Biomecánico Listo'), findsOneWidget);
    expect(find.text('COMENZAR AHORA'), findsOneWidget);

    // Tap COMENZAR AHORA -> Navigates to /ranks & sets SharedPreferences
    await tester.tap(find.text('COMENZAR AHORA'));
    await tester.pumpAndSettle();

    expect(find.text('Ranks Destination'), findsOneWidget);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('has_completed_onboarding'), isTrue);
  });

  testWidgets('OnboardingPage skip button immediately finishes onboarding', (tester) async {
    SharedPreferences.setMockInitialValues({'has_completed_onboarding': false});

    final testRouter = GoRouter(
      initialLocation: '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: '/ranks',
          builder: (context, state) => const Scaffold(body: Text('Ranks Destination')),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: testRouter));
    await tester.pump();

    // Tap Saltar
    await tester.tap(find.text('Saltar'));
    await tester.pumpAndSettle();

    expect(find.text('Ranks Destination'), findsOneWidget);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('has_completed_onboarding'), isTrue);
  });
}
