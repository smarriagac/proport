import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../features/social/presentation/pages/friends_page.dart';
import '../../features/training/domain/entities/workout_plan.dart';
import '../../features/training/presentation/pages/training_dashboard_page.dart';
import '../../features/training/presentation/pages/workout_detail_page.dart';
import '../../features/training/presentation/pages/active_workout_page.dart';
import '../../features/intelligence/presentation/pages/ai_coach_page.dart';
import '../../features/intelligence/presentation/pages/ai_workout_generator_page.dart';
import '../../features/statistics/presentation/pages/statistics_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/ranks',
  routes: [
    // Compatibility aliases
    GoRoute(
      path: '/statistics',
      redirect: (_, __) => '/ranks',
    ),
    GoRoute(
      path: '/train',
      redirect: (_, __) => '/training',
    ),
    GoRoute(
      path: '/intelligence',
      redirect: (_, __) => '/library',
    ),
    GoRoute(
      path: '/bodyscan',
      redirect: (_, __) => '/profile',
    ),
    GoRoute(
      path: '/intelligence/generator',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AIWorkoutGeneratorPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        // Tab 0: Amigos
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/friends',
              builder: (context, state) => const FriendsPage(),
            ),
          ],
        ),

        // Tab 1: Rangos (Initial Tab matching authentic screenshot)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/ranks',
              builder: (context, state) => const StatisticsPage(),
            ),
          ],
        ),

        // Tab 2: Entrenar
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/training',
              builder: (context, state) => const TrainingDashboardPage(),
              routes: [
                GoRoute(
                  path: 'plan-detail',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final plan = state.extra as WorkoutPlan;
                    return WorkoutDetailPage(plan: plan);
                  },
                ),
                GoRoute(
                  path: 'active-workout',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const ActiveWorkoutPage(),
                ),
              ],
            ),
          ],
        ),

        // Tab 3: Biblioteca
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/library',
              builder: (context, state) => const AICoachPage(),
              routes: [
                GoRoute(
                  path: 'generator',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const AIWorkoutGeneratorPage(),
                ),
              ],
            ),
          ],
        ),

        // Tab 4: Perfil
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        height: 60 + bottomPadding,
        padding: EdgeInsets.only(bottom: bottomPadding),
        decoration: const BoxDecoration(
          color: Color(0xFF0B0B0C),
          border: Border(
            top: BorderSide(color: Color(0xFF1E1E22), width: 0.8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Tab 0: Amigos
            _buildNavItem(
              index: 0,
              currentIndex: currentIndex,
              label: 'Amigos',
              iconPath: AppAssets.navFriends,
              onTap: () => _onTabSelected(0),
            ),

            // Tab 1: Rangos (Selected by default)
            _buildNavItem(
              index: 1,
              currentIndex: currentIndex,
              label: 'Rangos',
              iconPath: AppAssets.navRanks,
              onTap: () => _onTabSelected(1),
            ),

            // Tab 2: Entrenar
            _buildNavItem(
              index: 2,
              currentIndex: currentIndex,
              label: 'Entrenar',
              iconPath: AppAssets.navTrain,
              onTap: () => _onTabSelected(2),
            ),

            // Tab 3: Biblioteca
            _buildNavItem(
              index: 3,
              currentIndex: currentIndex,
              label: 'Biblioteca',
              iconPath: AppAssets.navLibrary,
              onTap: () => _onTabSelected(3),
            ),

            // Tab 4: Perfil
            _buildNavItem(
              index: 4,
              currentIndex: currentIndex,
              label: 'Perfil',
              iconPath: AppAssets.navProfile,
              onTap: () => _onTabSelected(4),
            ),
          ],
        ),
      ),
    );
  }

  void _onTabSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  Widget _buildNavItem({
    required int index,
    required int currentIndex,
    required String label,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    final isSelected = currentIndex == index;
    const activeColor = Colors.white;
    const inactiveColor = Color(0xFF8E8E93);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                isSelected ? activeColor : inactiveColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: isSelected ? AppTheme.fontAlbert : AppTheme.fontDM,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? activeColor : inactiveColor,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

