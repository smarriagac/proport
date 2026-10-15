import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_set.dart';
import '../../domain/entities/training_session.dart';
import '../bloc/training_bloc.dart';
import '../bloc/training_event.dart';

class WorkoutSessionPreviewPage extends StatefulWidget {
  final TrainingSession session;

  const WorkoutSessionPreviewPage({
    super.key,
    required this.session,
  });

  @override
  State<WorkoutSessionPreviewPage> createState() =>
      _WorkoutSessionPreviewPageState();
}

class _WorkoutSessionPreviewPageState extends State<WorkoutSessionPreviewPage> {
  late List<Exercise> _exercises;

  @override
  void initState() {
    super.initState();
    if (widget.session.exercises.isNotEmpty) {
      _exercises = List.from(widget.session.exercises);
    } else {
      _exercises = _buildDefault10Exercises();
    }
  }

  static List<Exercise> _buildDefault10Exercises() {
    return const [
      Exercise(
        exerciseTemplateId: 101,
        name: 'Andar En Cinta De Correr',
        muscleGroup: 'Cardio',
        sets: [
          ExerciseSet(setNumber: 1, reps: 0, durationSeconds: 720),
        ],
      ),
      Exercise(
        exerciseTemplateId: 102,
        name: 'Press De Banca Inclinado (Barra Recta)',
        muscleGroup: 'Pecho',
        sets: [
          ExerciseSet(setNumber: 1, reps: 10, weightKg: 60),
          ExerciseSet(setNumber: 2, reps: 10, weightKg: 60),
          ExerciseSet(setNumber: 3, reps: 10, weightKg: 60),
        ],
      ),
      Exercise(
        exerciseTemplateId: 103,
        name: 'Aperturas En Polea Alta (Cable)',
        muscleGroup: 'Pecho',
        sets: [
          ExerciseSet(setNumber: 1, reps: 10, weightKg: 15),
          ExerciseSet(setNumber: 2, reps: 10, weightKg: 15),
          ExerciseSet(setNumber: 3, reps: 10, weightKg: 15),
        ],
      ),
      Exercise(
        exerciseTemplateId: 104,
        name: 'Press De Hombros Sentado (Mancuerna)',
        muscleGroup: 'Hombros',
        sets: [
          ExerciseSet(setNumber: 1, reps: 10, weightKg: 22),
          ExerciseSet(setNumber: 2, reps: 10, weightKg: 22),
          ExerciseSet(setNumber: 3, reps: 10, weightKg: 22),
        ],
      ),
      Exercise(
        exerciseTemplateId: 105,
        name: 'Elevaciones Laterales (Mancuerna)',
        muscleGroup: 'Hombros',
        sets: [
          ExerciseSet(setNumber: 1, reps: 10, weightKg: 12),
          ExerciseSet(setNumber: 2, reps: 10, weightKg: 12),
          ExerciseSet(setNumber: 3, reps: 10, weightKg: 12),
        ],
      ),
      Exercise(
        exerciseTemplateId: 106,
        name: 'Extensiones De Tríceps En Polea (Cuerda)',
        muscleGroup: 'Tríceps',
        sets: [
          ExerciseSet(setNumber: 1, reps: 12, weightKg: 25),
          ExerciseSet(setNumber: 2, reps: 12, weightKg: 25),
          ExerciseSet(setNumber: 3, reps: 12, weightKg: 25),
        ],
      ),
      Exercise(
        exerciseTemplateId: 107,
        name: 'Press De Banca Plano (Mancuerna)',
        muscleGroup: 'Pecho',
        sets: [
          ExerciseSet(setNumber: 1, reps: 10, weightKg: 28),
          ExerciseSet(setNumber: 2, reps: 10, weightKg: 28),
          ExerciseSet(setNumber: 3, reps: 10, weightKg: 28),
        ],
      ),
      Exercise(
        exerciseTemplateId: 108,
        name: 'Fondos En Paralelas (Tríceps)',
        muscleGroup: 'Tríceps',
        sets: [
          ExerciseSet(setNumber: 1, reps: 10, weightKg: 0),
          ExerciseSet(setNumber: 2, reps: 10, weightKg: 0),
          ExerciseSet(setNumber: 3, reps: 10, weightKg: 0),
        ],
      ),
      Exercise(
        exerciseTemplateId: 109,
        name: 'Press Militar De Pie (Barra)',
        muscleGroup: 'Hombros',
        sets: [
          ExerciseSet(setNumber: 1, reps: 8, weightKg: 45),
          ExerciseSet(setNumber: 2, reps: 8, weightKg: 45),
          ExerciseSet(setNumber: 3, reps: 8, weightKg: 45),
        ],
      ),
      Exercise(
        exerciseTemplateId: 110,
        name: 'Cruces En Polea Baja',
        muscleGroup: 'Pecho',
        sets: [
          ExerciseSet(setNumber: 1, reps: 12, weightKg: 12),
          ExerciseSet(setNumber: 2, reps: 12, weightKg: 12),
          ExerciseSet(setNumber: 3, reps: 12, weightKg: 12),
        ],
      ),
    ];
  }

  String _getExerciseThumbnail(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('cinta') ||
        lower.contains('correr') ||
        lower.contains('andar') ||
        lower.contains('cardio')) {
      return AppAssets.exTreadmill;
    }
    if (lower.contains('inclinado') ||
        lower.contains('plano') ||
        lower.contains('fondos')) {
      return AppAssets.exInclineBench;
    }
    if (lower.contains('apertura') ||
        lower.contains('polea') ||
        lower.contains('cruce') ||
        lower.contains('tríceps') ||
        lower.contains('triceps')) {
      return AppAssets.exCableCrossover;
    }
    if (lower.contains('hombro') || lower.contains('militar')) {
      return AppAssets.exShoulderPress;
    }
    if (lower.contains('lateral') || lower.contains('elevacion')) {
      return AppAssets.exLateralRaise;
    }
    return AppAssets.exInclineBench;
  }

  String _formatExerciseSubtitle(Exercise exercise) {
    final lower = exercise.name.toLowerCase();
    if (lower.contains('cinta') ||
        lower.contains('correr') ||
        lower.contains('andar')) {
      return '1 series x 12m 0s';
    }
    final setsCount = exercise.sets.isNotEmpty ? exercise.sets.length : 3;
    final repsCount = exercise.sets.isNotEmpty && exercise.sets.first.reps > 0
        ? exercise.sets.first.reps
        : 10;
    return '$setsCount series x $repsCount reps';
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.session.name.isNotEmpty && widget.session.name != 'EMPUJE'
        ? widget.session.name
        : 'Entrenamiento Pro';
    final duration = widget.session.durationMinutes ?? 120;
    final exerciseCount = _exercises.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          onPressed: () => context.pop(),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white, size: 24),
            color: AppColors.surface,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.cardBorder),
            ),
            onSelected: (value) {},
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'rename',
                child: Text('Cambiar Nombre', style: TextStyle(color: Colors.white)),
              ),
              const PopupMenuItem(
                value: 'edit',
                child: Text('Editar Rutina', style: TextStyle(color: Colors.white)),
              ),
              const PopupMenuItem(
                value: 'duplicate',
                child: Text('Duplicar Sesión', style: TextStyle(color: Colors.white)),
              ),
              const PopupMenuItem(
                value: 'share',
                child: Text('Compartir', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 110),
            children: [
              // Title Header
              Text(
                title,
                style: const TextStyle(
                  fontFamily: AppTheme.fontAlbert,
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$exerciseCount Ejercicios, $duration min',
                style: const TextStyle(
                  fontFamily: AppTheme.fontDM,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Color(0xFF8E8E93),
                ),
              ),

              const SizedBox(height: 28),

              // Distribución Muscular Section
              const Text(
                'Distribución Muscular',
                style: TextStyle(
                  fontFamily: AppTheme.fontAlbert,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 14),

              // Horizontal Muscle Distribution Cards
              SizedBox(
                height: 84,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildMuscleCard(
                      imageAsset: AppAssets.muscleDistributionHombros,
                      name: 'Hombros',
                      percentage: '32%',
                    ),
                    const SizedBox(width: 14),
                    _buildMuscleCard(
                      imageAsset: AppAssets.muscleDistributionTriceps,
                      name: 'Tríceps',
                      percentage: '32%',
                    ),
                    const SizedBox(width: 14),
                    _buildMuscleCard(
                      imageAsset: AppAssets.muscleDistributionPecho,
                      name: 'Pecho',
                      percentage: '16%',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Exercises List Header: "10 Ejercicios" + "+" button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$exerciseCount Ejercicios',
                    style: const TextStyle(
                      fontFamily: AppTheme.fontAlbert,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1D),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF26262B)),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Exercise List
              ..._exercises.asMap().entries.map((entry) {
                final exercise = entry.value;
                final thumbnail = _getExerciseThumbnail(exercise.name);
                final subtitle = _formatExerciseSubtitle(exercise);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Row(
                    children: [
                      // Exercise Squircle Thumbnail
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              thumbnail,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.fitness_center_rounded,
                                  color: Colors.black,
                                  size: 28,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Text Info (Subtitle on top, title on bottom)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subtitle,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontDM,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8E8E93),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              exercise.name,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontAlbert,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Reorder / Swap icon on right
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: SvgPicture.asset(
                          AppAssets.iconReplaceArrows,
                          width: 22,
                          height: 22,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),

          // Bottom Floating CTA Button: "Empezar Entrenamiento"
          Positioned(
            left: 18,
            right: 18,
            bottom: 24,
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 8,
                  shadowColor: Colors.black.withValues(alpha: 0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  final activeSession = widget.session.copyWith(
                    exercises: _exercises,
                  );
                  context
                      .read<TrainingBloc>()
                      .add(StartWorkoutSessionEvent(activeSession));
                  context.push('/training/active-workout');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.black,
                      size: 26,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Empezar Entrenamiento',
                      style: TextStyle(
                        fontFamily: AppTheme.fontAlbert,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMuscleCard({
    required String imageAsset,
    required String name,
    required String percentage,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF26262B)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E22),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.accessibility_new_rounded,
                    color: AppColors.primaryBlue,
                    size: 28,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: AppTheme.fontAlbert,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  percentage,
                  style: const TextStyle(
                    fontFamily: AppTheme.fontDM,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
