import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proport/features/splash/presentation/pages/splash_page.dart';

void main() {
  testWidgets('SplashPage renders logo, title, and subtitle', (tester) async {
    SharedPreferences.setMockInitialValues({'has_completed_onboarding': true});

    final testRouter = GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/ranks',
          builder: (context, state) => const Scaffold(body: Text('Ranks Page')),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const Scaffold(body: Text('Onboarding Page')),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: testRouter));
    await tester.pump();

    // Verify Title & Subtitle
    expect(find.text('PROPORT'), findsOneWidget);
    expect(find.text('PROPORTION · SYMMETRY · PERFORMANCE'), findsOneWidget);

    // Fast-forward past 1800ms
    await tester.pump(const Duration(milliseconds: 2000));
    await tester.pump();

    // Navigates to /ranks because has_completed_onboarding is true
    expect(find.text('Ranks Page'), findsOneWidget);
  });

  testWidgets('SplashPage navigates to /onboarding for first-time users', (tester) async {
    SharedPreferences.setMockInitialValues({'has_completed_onboarding': false});

    final testRouter = GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/ranks',
          builder: (context, state) => const Scaffold(body: Text('Ranks Page')),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const Scaffold(body: Text('Onboarding Page')),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: testRouter));
    await tester.pump();

    // Fast-forward past 1800ms
    await tester.pump(const Duration(milliseconds: 2000));
    await tester.pump();

    // Navigates to /onboarding because has_completed_onboarding is false
    expect(find.text('Onboarding Page'), findsOneWidget);
  });
}
