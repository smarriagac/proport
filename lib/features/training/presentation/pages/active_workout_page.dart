import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../bloc/training_bloc.dart';
import '../bloc/training_event.dart';
import '../bloc/training_state.dart';
import '../widgets/exercise_tile.dart';
import '../widgets/rest_timer_banner.dart';

class ActiveWorkoutPage extends StatelessWidget {
  const ActiveWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrainingBloc, TrainingState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (_, __, activeSession, ___, ____, _____) {
            if (activeSession == null) {
              // Session was finished
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🎉 Workout Session Logged! Great work!'),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              context.pop();
            }
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (_, __, activeSession, restSeconds, isRestActive, ___) {
            if (activeSession == null) {
              return Scaffold(
                appBar: AppBar(title: const Text('No Active Workout')),
                body: const Center(child: Text('No active session in progress.')),
              );
            }

            final totalSets = activeSession.exercises.fold<int>(
              0,
              (sum, ex) => sum + ex.sets.length,
            );
            final completedSets = activeSession.exercises.fold<int>(
              0,
              (sum, ex) => sum + ex.sets.where((s) => s.isCompleted).length,
            );
            final progress = totalSets > 0 ? completedSets / totalSets : 0.0;

            return Scaffold(
              appBar: AppBar(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activeSession.name,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    Text(
                      '$completedSets / $totalSets sets completed',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                leading: IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => _confirmExit(context),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _confirmFinish(context),
                      icon: const Icon(Icons.flag_rounded, size: 16),
                      label: const Text(
                        'Finish',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.surface,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
                    minHeight: 4,
                  ),
                ),
              ),
              bottomNavigationBar: isRestActive
                  ? RestTimerBanner(
                      secondsRemaining: restSeconds,
                      onSkip: () => context
                          .read<TrainingBloc>()
                          .add(const StopRestTimerEvent()),
                    )
                  : null,
              body: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: activeSession.exercises.length,
                itemBuilder: (context, exIdx) {
                  final exercise = activeSession.exercises[exIdx];
                  return ExerciseTile(
                    exercise: exercise,
                    exerciseIndex: exIdx,
                    onToggleSet: (setIdx, weight, reps) {
                      context.read<TrainingBloc>().add(
                            ToggleSetCompletionEvent(
                              exerciseIndex: exIdx,
                              setIndex: setIdx,
                              weight: weight,
                              reps: reps,
                            ),
                          );
                    },
                    onAddSet: () {
                      context.read<TrainingBloc>().add(AddSetEvent(exIdx));
                    },
                  );
                },
              ),
            );
          },
          orElse: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text('Leave Active Workout?'),
        content: const Text('Your current set progress will be preserved.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.cardBorder),
            onPressed: () {
              Navigator.pop(ctx);
              context.pop();
            },
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }

  void _confirmFinish(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text('Finish Workout Session?'),
        content: const Text(
          'Great job! Finishing will log this workout to your Symmetry history and update your streak.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Keep Training'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
            onPressed: () {
              Navigator.pop(ctx);
              context.read<TrainingBloc>().add(const FinishWorkoutSessionEvent());
            },
            child: const Text('Finish & Log'),
          ),
        ],
      ),
    );
  }
}
