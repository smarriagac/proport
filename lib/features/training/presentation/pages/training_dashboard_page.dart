import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/training_session.dart';
import '../bloc/training_bloc.dart';
import '../bloc/training_event.dart';
import '../bloc/training_state.dart';

class TrainingDashboardPage extends StatelessWidget {
  const TrainingDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            SvgPicture.asset(
              AppAssets.logoSvg,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Symmetry',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          BlocBuilder<TrainingBloc, TrainingState>(
            builder: (context, state) {
              final streakDays = state.maybeWhen(
                loaded: (_, __, ___, ____, _____, completed) =>
                    completed.isNotEmpty ? completed.length : 51,
                orElse: () => 51,
              );

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // PRO badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC7E2FE),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Text(
                      'PRO',
                      style: TextStyle(
                        fontFamily: AppTheme.fontAlbert,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: Colors.black,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Streak badge
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppAssets.streakFlameLit,
                        width: 18,
                        height: 18,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF8E8E93),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$streakDays',
                        style: const TextStyle(
                          fontFamily: AppTheme.fontAlbert,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<TrainingBloc, TrainingState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primaryBlue),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primaryBlue),
            ),
            error: (msg) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                  const SizedBox(height: 12),
                  Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<TrainingBloc>()
                        .add(const LoadWorkoutPlansEvent()),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
            loaded: (plans, selectedPlan, activeSession, _, __, completedSessions) {
              final activePlan = selectedPlan ?? (plans.isNotEmpty ? plans.first : null);
              final primarySession = (activePlan != null && activePlan.trainingSessions.isNotEmpty)
                  ? activePlan.trainingSessions.first
                  : null;

              return RefreshIndicator(
                color: AppColors.primaryBlue,
                backgroundColor: AppColors.surface,
                onRefresh: () async {
                  context.read<TrainingBloc>().add(const LoadWorkoutPlansEvent());
                },
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    // Active Workout in progress indicator (if any)
                    if (activeSession != null) ...[
                      _buildActiveWorkoutNotice(context, activeSession.name),
                      const SizedBox(height: 14),
                    ],

                    // "Tu Plan" Hero Card Section
                    _buildTuPlanHeroCard(
                      context,
                      activePlan: activePlan,
                      session: primarySession,
                    ),

                    const SizedBox(height: 32),

                    // "¿Buscas otra forma de entrenar?" Section
                    _buildAlternativeTrainingSection(context, activePlan: activePlan),

                    const SizedBox(height: 30),

                    // Sessions in Current Plan Section (Scrollable follow-up)
                    if (activePlan != null && activePlan.trainingSessions.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'SESIONES DE LA SEMANA',
                            style: TextStyle(
                              fontFamily: AppTheme.fontAlbert,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '${activePlan.trainingSessions.length} sesiones',
                            style: const TextStyle(
                              fontFamily: AppTheme.fontDM,
                              color: AppColors.accentBlue,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...activePlan.trainingSessions.map((session) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.cardBorder),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            leading: Container(
                              width: 42,
                              height: 42,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.card,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.cardBorder),
                              ),
                              child: Text(
                                'D${session.dayOfWeek}',
                                style: const TextStyle(
                                  fontFamily: AppTheme.fontAlbert,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.accentBlue,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            title: Text(
                              session.name,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontAlbert,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              '${session.exercises.length} ejercicios · ~${session.durationMinutes ?? activePlan.durationPerSession} min',
                              style: const TextStyle(
                                fontFamily: AppTheme.fontDM,
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.18),
                                foregroundColor: AppColors.accentBlue,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<TrainingBloc>()
                                    .add(StartWorkoutSessionEvent(session));
                                context.push('/training/active-workout');
                              },
                              child: const Text(
                                'Iniciar',
                                style: TextStyle(
                                  fontFamily: AppTheme.fontAlbert,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTuPlanHeroCard(
    BuildContext context, {
    required dynamic activePlan,
    required TrainingSession? session,
  }) {
    final workoutTitle = session?.name ?? (activePlan != null ? activePlan.name : 'EMPUJE');
    final exerciseCount = session?.exercises.length ?? 10;
    final durationMin = session?.durationMinutes ?? (activePlan != null ? activePlan.durationPerSession : 120);
    final dayName = _getDayOfWeekName(session?.dayOfWeek ?? DateTime.now().weekday);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row: Tu Plan + Más planes ->
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tu Plan',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                if (activePlan != null) {
                  context.push('/training/plan-detail', extra: activePlan);
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Más planes',
                      style: TextStyle(
                        fontFamily: AppTheme.fontDM,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Color(0xFF8E8E93),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Full-bleed Hero Card
        Container(
          height: 470,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFF26262B), width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(27),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 1. High-res athlete background image
                Image.asset(
                  AppAssets.workoutHeroCleanBg,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppAssets.workoutHeroEmpujeCard,
                      fit: BoxFit.cover,
                    );
                  },
                ),

                // 2. Seamless dark gradient overlay for bottom legibility
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.42, 0.70, 1.0],
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.65),
                          Colors.black.withValues(alpha: 0.98),
                        ],
                      ),
                    ),
                  ),
                ),

                // 3. Frosted Day pill top-left
                Positioned(
                  top: 18,
                  left: 18,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0x73000000),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.18),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      dayName,
                      style: const TextStyle(
                        fontFamily: AppTheme.fontDM,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // 4. Content bottom: EMPUJE, 120 min · 10 ejercicios, Ver button
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        workoutTitle.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: AppTheme.fontAlbert,
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                          color: Colors.white,
                          letterSpacing: 0.6,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$durationMin min · $exerciseCount ejercicios',
                        style: const TextStyle(
                          fontFamily: AppTheme.fontDM,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFFD1D1D6),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: () {
                            if (session != null) {
                              context
                                  .read<TrainingBloc>()
                                  .add(StartWorkoutSessionEvent(session));
                              context.push('/training/active-workout');
                            } else if (activePlan != null && activePlan.trainingSessions.isNotEmpty) {
                              context
                                  .read<TrainingBloc>()
                                  .add(StartWorkoutSessionEvent(activePlan.trainingSessions.first));
                              context.push('/training/active-workout');
                            }
                          },
                          child: const Text(
                            'Ver',
                            style: TextStyle(
                              fontFamily: AppTheme.fontAlbert,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAlternativeTrainingSection(
    BuildContext context, {
    required dynamic activePlan,
  }) {
    return Column(
      children: [
        const Text(
          '¿Buscas otra forma de entrenar?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppTheme.fontAlbert,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),

        // Grouped Card Container with 3 options
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF141416),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFF26262B), width: 1),
          ),
          child: Column(
            children: [
              // 1. Ir a mi Biblioteca
              _buildGroupedItem(
                leading: SvgPicture.asset(
                  AppAssets.navLibrary,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                titleWidget: const Text(
                  'Ir a mi Biblioteca',
                  style: TextStyle(
                    fontFamily: AppTheme.fontAlbert,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                subtitle: 'Crea tus plantillas y úsalas cuando quieras',
                onTap: () => context.go('/library'),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFF26262B),
                indent: 16,
                endIndent: 16,
              ),

              // 2. Generar entrenamiento con IA
              _buildGroupedItem(
                leading: SvgPicture.asset(
                  AppAssets.iconSparkles,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                titleWidget: RichText(
                  text: const TextSpan(
                    text: 'Generar entrenamiento con ',
                    style: TextStyle(
                      fontFamily: AppTheme.fontAlbert,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'IA',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: 'Elige sitio, tiempo y te lo montamos',
                onTap: () => context.push('/intelligence/generator'),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFF26262B),
                indent: 16,
                endIndent: 16,
              ),

              // 3. Empezar entrenamiento libre
              _buildGroupedItem(
                leading: SvgPicture.asset(
                  AppAssets.iconDumbbell,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                titleWidget: const Text(
                  'Empezar entrenamiento libre',
                  style: TextStyle(
                    fontFamily: AppTheme.fontAlbert,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                subtitle: 'Añade ejercicios a medida que entrenas',
                onTap: () {
                  final emptySession = TrainingSession(
                    dayOfWeek: DateTime.now().weekday,
                    name: 'Entrenamiento Libre',
                    description: 'Sesión libre personalizada',
                    exercises: const [],
                    durationMinutes: 45,
                  );
                  context
                      .read<TrainingBloc>()
                      .add(StartWorkoutSessionEvent(emptySession));
                  context.push('/training/active-workout');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGroupedItem({
    required Widget leading,
    required Widget titleWidget,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Row(
          children: [
            SizedBox(
              width: 26,
              height: 26,
              child: Center(child: leading),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleWidget,
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontDM,
                      fontSize: 12,
                      color: Color(0xFF8E8E93),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF8E8E93),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveWorkoutNotice(BuildContext context, String sessionName) {
    return InkWell(
      onTap: () => context.push('/training/active-workout'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryBlue, width: 1.2),
        ),
        child: Row(
          children: [
            const Icon(Icons.fitness_center_rounded, color: AppColors.primaryBlue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ENTRENAMIENTO EN CURSO',
                    style: TextStyle(
                      fontFamily: AppTheme.fontAlbert,
                      color: AppColors.accentBlue,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sessionName,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontAlbert,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.accentBlue, size: 16),
          ],
        ),
      ),
    );
  }

  String _getDayOfWeekName(int day) {
    switch (day) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return 'Viernes';
    }
  }
}
