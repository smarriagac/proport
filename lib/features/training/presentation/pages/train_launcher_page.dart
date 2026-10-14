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
import 'active_workout_page.dart';

class TrainLauncherPage extends StatelessWidget {
  const TrainLauncherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingBloc, TrainingState>(
      builder: (context, state) {
        final activeSession = state.maybeWhen(
          loaded: (_, __, active, ___, ____, _____) => active,
          orElse: () => null,
        );

        // If a workout is already in progress, show active workout page directly
        if (activeSession != null) {
          return const ActiveWorkoutPage();
        }

        final plans = state.maybeWhen(
          loaded: (p, _, __, ___, ____, _____) => p,
          orElse: () => null,
        );
        final activePlan = plans != null && plans.isNotEmpty ? plans.first : null;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            title: const Text(
              'ENTRENAR',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            centerTitle: false,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              // Free Workout Hero Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E2838), Color(0xFF141416)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primaryBlue.withValues(alpha: 0.4),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.navTrain,
                            width: 22,
                            height: 22,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primaryBlue,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Entrenamiento Libre',
                                style: TextStyle(
                                  fontFamily: AppTheme.fontAlbert,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Añade ejercicios a medida que entrenas',
                                style: TextStyle(
                                  fontFamily: AppTheme.fontDM,
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
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
                        icon: const Icon(Icons.play_arrow_rounded, size: 22),
                        label: const Text(
                          'EMPEZAR AHORA',
                          style: TextStyle(
                            fontFamily: AppTheme.fontAlbert,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // AI Workout Generator Card
              InkWell(
                onTap: () => context.push('/intelligence/generator'),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.accentBlue.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          color: AppColors.accentBlue,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Generar con IA',
                              style: TextStyle(
                                fontFamily: AppTheme.fontAlbert,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Dinos tu objetivo y lo tienes en segundos',
                              style: TextStyle(
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
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Continue Active Plan Card
              if (activePlan != null && activePlan.trainingSessions.isNotEmpty)
                InkWell(
                  onTap: () {
                    final firstSession = activePlan.trainingSessions.first;
                    context
                        .read<TrainingBloc>()
                        .add(StartWorkoutSessionEvent(firstSession));
                    context.push('/training/active-workout');
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.flameOrange.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.calendar_month_rounded,
                            color: AppColors.flameOrange,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activePlan.trainingSessions.first.name,
                                style: const TextStyle(
                                  fontFamily: AppTheme.fontAlbert,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${activePlan.name} · ${activePlan.trainingSessions.first.exercises.length} ejercicios',
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
                          Icons.play_circle_fill_rounded,
                          color: AppColors.primaryBlue,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
