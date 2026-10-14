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
              width: 26,
              height: 26,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryBlue,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'SYMMETRY',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
                fontSize: 18,
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
                    completed.isNotEmpty ? completed.length : 5,
                orElse: () => 5,
              );

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.flameOrange.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssets.streakFlameLit,
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$streakDays DÍAS',
                      style: const TextStyle(
                        fontFamily: AppTheme.fontAlbert,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: AppColors.flameOrange,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: SvgPicture.asset(
              AppAssets.notificationIcon,
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  children: [
                    // Active Workout in progress indicator (if any)
                    if (activeSession != null) ...[
                      _buildActiveWorkoutNotice(context, activeSession.name),
                      const SizedBox(height: 18),
                    ],

                    // "Tu Plan" Hero Card Section
                    _buildTuPlanHeroCard(
                      context,
                      activePlan: activePlan,
                      session: primarySession,
                    ),

                    const SizedBox(height: 24),

                    // "¿Buscas otra forma de entrenar?" Section
                    _buildAlternativeTrainingSection(context, activePlan: activePlan),

                    const SizedBox(height: 26),

                    // Sessions in Current Plan Section
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
                      const SizedBox(height: 16),
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
    final workoutTitle = session?.name ?? (activePlan != null ? activePlan.name : 'Torso Potencia A');
    final exerciseCount = session?.exercises.length ?? 6;
    final durationMin = session?.durationMinutes ?? (activePlan != null ? activePlan.durationPerSession : 45);
    final ruleset = activePlan != null ? activePlan.ruleset : 'Torso / Pierna';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tu Plan',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            InkWell(
              onTap: () {
                if (activePlan != null) {
                  context.push('/training/plan-detail', extra: activePlan);
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: Text(
                  'Más planes',
                  style: TextStyle(
                    fontFamily: AppTheme.fontDM,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.accentBlue,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Premium Workout Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.cardBorder),
            gradient: const LinearGradient(
              colors: [Color(0xFF1E2430), AppColors.card],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlue.withValues(alpha: 0.12),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge & Tag row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.primaryBlue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      ruleset.toString().toUpperCase(),
                      style: const TextStyle(
                        fontFamily: AppTheme.fontAlbert,
                        color: AppColors.accentBlue,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 14,
                        color: AppColors.textMuted,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'SESIÓN DE HOY',
                        style: TextStyle(
                          fontFamily: AppTheme.fontAlbert,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textMuted,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Workout title
              Text(
                workoutTitle,
                style: const TextStyle(
                  fontFamily: AppTheme.fontAlbert,
                  fontWeight: FontWeight.w800,
                  fontSize: 21,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),

              // Subtitle: 45 min · 6 ejercicios
              Text(
                '$durationMin min · $exerciseCount ejercicios',
                style: const TextStyle(
                  fontFamily: AppTheme.fontDM,
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              // High-impact "INICIAR ENTRENAMIENTO" button with gradient sheen
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryBlue, AppColors.accentBlue],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
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
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow_rounded, color: Colors.white, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'INICIAR ENTRENAMIENTO',
                            style: TextStyle(
                              fontFamily: AppTheme.fontAlbert,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '¿Buscas otra forma de entrenar?',
          style: TextStyle(
            fontFamily: AppTheme.fontAlbert,
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),

        // 1. Generar entrenamiento con IA
        _buildActionCard(
          icon: const Icon(
            Icons.auto_awesome_rounded,
            color: AppColors.accentBlue,
            size: 22,
          ),
          iconBgColor: AppColors.accentBlue.withValues(alpha: 0.15),
          title: 'Generar entrenamiento con IA',
          subtitle: 'Dinos tu objetivo y lo tienes en segundos',
          onTap: () => context.push('/intelligence/generator'),
        ),
        const SizedBox(height: 10),

        // 2. Empezar entrenamiento libre
        _buildActionCard(
          icon: SvgPicture.asset(
            AppAssets.navTrain,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryBlue,
              BlendMode.srcIn,
            ),
          ),
          iconBgColor: AppColors.primaryBlue.withValues(alpha: 0.15),
          title: 'Empezar entrenamiento libre',
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
        const SizedBox(height: 10),

        // 3. Tus plantillas
        _buildActionCard(
          icon: const Icon(
            Icons.folder_outlined,
            color: AppColors.flameOrange,
            size: 22,
          ),
          iconBgColor: AppColors.flameOrange.withValues(alpha: 0.15),
          title: 'Tus plantillas',
          subtitle: 'Crea o usa rutinas guardadas',
          onTap: () {
            if (activePlan != null) {
              context.push('/training/plan-detail', extra: activePlan);
            }
          },
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required Widget icon,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: icon,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontAlbert,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontDM,
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted,
              size: 22,
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
}

