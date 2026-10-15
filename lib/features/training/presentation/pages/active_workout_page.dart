import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/symmetry_extended_image.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_set.dart';
import '../bloc/training_bloc.dart';
import '../bloc/training_event.dart';
import '../bloc/training_state.dart';
import '../widgets/rest_timer_banner.dart';
import '../widgets/exercise_picker_bottom_sheet.dart';

class ActiveWorkoutPage extends StatefulWidget {
  const ActiveWorkoutPage({super.key});

  @override
  State<ActiveWorkoutPage> createState() => _ActiveWorkoutPageState();
}

class _ActiveWorkoutPageState extends State<ActiveWorkoutPage> {
  Timer? _workoutTimer;
  int _elapsedSeconds = 2; // Initialized to 2s matching the screenshot
  int _currentExerciseIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _workoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsedSeconds++;
        });
      }
    });
  }

  @override
  void dispose() {
    _workoutTimer?.cancel();
    super.dispose();
  }

  String _formatTimer(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  static List<Exercise> _getDefaultGuiderExercises() {
    return const [
      Exercise(
        exerciseTemplateId: 201,
        name: 'Jalón Al Pecho Agarre Prono (Máquina)',
        muscleGroup: 'Espalda',
        sets: [
          ExerciseSet(setNumber: 1, reps: 10, weightKg: 18),
          ExerciseSet(setNumber: 2, reps: 10, weightKg: 86),
          ExerciseSet(setNumber: 3, reps: 10, weightKg: 86),
        ],
      ),
      Exercise(
        exerciseTemplateId: 202,
        name: 'Jalón Al Pecho Agarre Supino',
        muscleGroup: 'Espalda',
        sets: [
          ExerciseSet(setNumber: 1, reps: 10, weightKg: 70),
          ExerciseSet(setNumber: 2, reps: 10, weightKg: 75),
          ExerciseSet(setNumber: 3, reps: 8, weightKg: 80),
        ],
      ),
      Exercise(
        exerciseTemplateId: 203,
        name: 'Remo En Polea Baja (Agarre Estrecho)',
        muscleGroup: 'Espalda',
        sets: [
          ExerciseSet(setNumber: 1, reps: 10, weightKg: 60),
          ExerciseSet(setNumber: 2, reps: 10, weightKg: 65),
          ExerciseSet(setNumber: 3, reps: 10, weightKg: 70),
        ],
      ),
      Exercise(
        exerciseTemplateId: 204,
        name: 'Remo Con Mancuerna A Una Mano',
        muscleGroup: 'Espalda',
        sets: [
          ExerciseSet(setNumber: 1, reps: 10, weightKg: 28),
          ExerciseSet(setNumber: 2, reps: 10, weightKg: 30),
          ExerciseSet(setNumber: 3, reps: 8, weightKg: 32),
        ],
      ),
      Exercise(
        exerciseTemplateId: 205,
        name: 'Face Pull En Polea Alta',
        muscleGroup: 'Hombros',
        sets: [
          ExerciseSet(setNumber: 1, reps: 12, weightKg: 20),
          ExerciseSet(setNumber: 2, reps: 12, weightKg: 20),
          ExerciseSet(setNumber: 3, reps: 12, weightKg: 25),
        ],
      ),
    ];
  }

  String _getCarouselThumbnail(int index, String exerciseName, [String? thumbnailURL]) {
    if (thumbnailURL != null && thumbnailURL.isNotEmpty) {
      return thumbnailURL;
    }
    final lower = exerciseName.toLowerCase();
    if (lower.contains('supino') || lower.contains('estrecho')) {
      return AppAssets.gifLatPulldownSupinated;
    }
    if (lower.contains('jalón') || lower.contains('jalon')) {
      return AppAssets.gifLatPulldownPronated;
    }
    if (lower.contains('remo') && lower.contains('mancuerna')) {
      return AppAssets.gifDumbbellRow;
    }
    if (lower.contains('remo') && lower.contains('barra')) {
      return AppAssets.gifBarbellRow;
    }
    if (lower.contains('remo')) {
      return AppAssets.gifSeatedCableRow;
    }
    if (lower.contains('face pull')) {
      return AppAssets.gifFacePull;
    }
    if (lower.contains('inclinado')) {
      return AppAssets.gifInclineBenchPress;
    }
    if (lower.contains('plano') || lower.contains('banca')) {
      return AppAssets.gifFlatBenchPress;
    }
    if (lower.contains('fondo') || lower.contains('dip')) {
      return AppAssets.gifBenchDips;
    }
    if (lower.contains('lateral') || lower.contains('elevacion')) {
      return AppAssets.gifLateralRaises;
    }
    if (lower.contains('tríceps') || lower.contains('triceps')) {
      return AppAssets.gifTricepsPushdown;
    }
    if (lower.contains('curl') || lower.contains('biceps') || lower.contains('bíceps')) {
      return AppAssets.gifBicepCurl;
    }
    return AppAssets.gifLatPulldownPronated;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrainingBloc, TrainingState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (_, __, activeSession, ___, ____, _____) {
            if (activeSession == null) {
              context.pop();
            }
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (plans, selectedPlan, activeSession, restSeconds, isRestActive, completed) {
            final effectiveExercises = (activeSession != null && activeSession.exercises.isNotEmpty)
                ? activeSession.exercises
                : _getDefaultGuiderExercises();

            final safeIndex = _currentExerciseIndex < effectiveExercises.length
                ? _currentExerciseIndex
                : 0;
            final currentExercise = effectiveExercises[safeIndex];

            return Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // 1. Top Bar
                    _buildTopBar(context),

                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.only(bottom: 24),
                        children: [
                          const SizedBox(height: 8),

                          // 2. Exercise Carousel (Top Selector)
                          _buildExerciseCarousel(effectiveExercises),

                          const SizedBox(height: 12),

                          // 3. Hero Center Stage (Illustration + Symmetry S Assistant badge)
                          _buildHeroCenterStage(context, currentExercise),

                          const SizedBox(height: 16),

                          // 4. Exercise Title
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Text(
                              currentExercise.name,
                              style: const TextStyle(
                                fontFamily: AppTheme.fontAlbert,
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // 5. Action Pills Row
                          _buildActionPillsRow(context),

                          const SizedBox(height: 24),

                          // 6. Set Table
                          _buildSetTable(context, safeIndex, currentExercise),

                          const SizedBox(height: 20),

                          // 7. Add Exercise Button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: OutlinedButton.icon(
                              onPressed: () => _openAddExercisePicker(
                                effectiveExercises.length,
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF26262B)),
                                backgroundColor: const Color(0xFF141416),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              icon: const Icon(
                                Icons.add_rounded,
                                color: AppColors.primaryBlue,
                                size: 20,
                              ),
                              label: const Text(
                                'Añadir ejercicio',
                                style: TextStyle(
                                  fontFamily: AppTheme.fontAlbert,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Rest Timer Banner (if active)
                    if (isRestActive)
                      RestTimerBanner(
                        secondsRemaining: restSeconds,
                        onSkip: () => context
                            .read<TrainingBloc>()
                            .add(const StopRestTimerEvent()),
                      ),

                    // 7. Bottom Drag Handle Indicator
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12, top: 6),
                      child: Center(
                        child: Container(
                          width: 44,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          orElse: () => const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator(color: AppColors.primaryBlue)),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          // Minimize / Down chevron
          IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: 4),

          // Workout Timer (0:02)
          Text(
            _formatTimer(_elapsedSeconds),
            style: const TextStyle(
              fontFamily: AppTheme.fontAlbert,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.white,
            ),
          ),

          const Spacer(),

          // Stopwatch / Timer icon button
          IconButton(
            icon: const Icon(
              Icons.timer_outlined,
              color: Colors.white,
              size: 22,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 6),

          // Terminar button
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => _confirmFinish(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF141416),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF26262B)),
              ),
              child: const Text(
                'Terminar',
                style: TextStyle(
                  fontFamily: AppTheme.fontAlbert,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openAddExercisePicker(int newIndex) async {
    final chosen = await ExercisePickerBottomSheet.show(context);
    if (!mounted || chosen == null) return;
    context.read<TrainingBloc>().add(AddExerciseToSessionEvent(chosen));
    setState(() {
      _currentExerciseIndex = newIndex;
    });
  }

  Widget _buildExerciseCarousel(List<Exercise> exercises) {
    return SizedBox(
      height: 82,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemCount: exercises.length + 1,
        itemBuilder: (context, index) {
          if (index == exercises.length) {
            return GestureDetector(
              onTap: () => _openAddExercisePicker(exercises.length),
              child: Container(
                width: 78,
                height: 78,
                margin: const EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF141416),
                  border: Border.all(color: const Color(0xFF26262B), width: 1.0),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add_rounded,
                    color: Colors.white70,
                    size: 28,
                  ),
                ),
              ),
            );
          }

          final isSelected = index == _currentExerciseIndex;
          final thumbAsset = _getCarouselThumbnail(
            index,
            exercises[index].name,
            exercises[index].thumbnailURL,
          );

          return GestureDetector(
            onTap: () {
              setState(() {
                _currentExerciseIndex = index;
              });
            },
            child: Container(
              width: 78,
              height: 78,
              margin: const EdgeInsets.only(right: 14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0D0D10),
                border: isSelected
                    ? Border.all(color: Colors.white, width: 2.2)
                    : Border.all(color: const Color(0xFF26262B), width: 1.0),
              ),
              child: ClipOval(
                child: SymmetryExtendedImage(
                  source: thumbAsset,
                  fit: BoxFit.cover,
                  errorWidget: const Center(
                    child: Icon(
                      Icons.fitness_center_rounded,
                      color: Colors.white70,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroCenterStage(BuildContext context, Exercise currentExercise) {
    return Container(
      height: 270,
      width: double.infinity,
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Center athlete render with authentic animated GIF projected via ExtendedImage
          SymmetryExtendedImage(
            source: _getCarouselThumbnail(
              _currentExerciseIndex,
              currentExercise.name,
              currentExercise.thumbnailURL,
            ),
            fit: BoxFit.contain,
            errorWidget: const Center(
              child: Icon(
                Icons.fitness_center_rounded,
                color: AppColors.primaryBlue,
                size: 80,
              ),
            ),
          ),

          // Symmetry S Intelligence Floating Badge
          Positioned(
            right: 18,
            bottom: 12,
            child: GestureDetector(
              onTap: () => _showSymmetryIntelligenceDialog(context),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E2F52), Color(0xFF0F1A30)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: const Color(0xFF4A84FF),
                    width: 1.6,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3875FF).withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.logoSvg,
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionPillsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          // 1. Diamond Crown Rank Badge
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF141416),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.rankDiamondBadge,
                width: 22,
                height: 22,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.military_tech_rounded,
                    color: Color(0xFF4A84FF),
                    size: 20,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 10),

          // 2. Tutorial Button
          _buildActionPill(
            icon: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 16,
            ),
            label: 'Tutorial',
            onTap: () {},
          ),
          const SizedBox(width: 10),

          // 3. Reemplazar Button
          _buildActionPill(
            icon: SvgPicture.asset(
              AppAssets.iconReplaceArrows,
              width: 14,
              height: 14,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            label: 'Reemplazar',
            onTap: () {},
          ),
          const SizedBox(width: 10),

          // 4. Notas Button
          _buildActionPill(
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 14,
            ),
            label: 'Notas',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionPill({
    required Widget icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF18181B),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: AppTheme.fontDM,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSetTable(
    BuildContext context,
    int exerciseIndex,
    Exercise currentExercise,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          // Table Headers
          Row(
            children: [
              const SizedBox(
                width: 48,
                child: Text(
                  'SERIE',
                  style: TextStyle(
                    fontFamily: AppTheme.fontAlbert,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 0.5,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ),
              const Expanded(
                flex: 3,
                child: Text(
                  'PREVIA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTheme.fontAlbert,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 0.5,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ),
              const Expanded(
                flex: 3,
                child: Text(
                  'KG',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTheme.fontAlbert,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 0.5,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ),
              const Expanded(
                flex: 3,
                child: Text(
                  'REPES',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTheme.fontAlbert,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 0.5,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ),
              // Over Check column: Blue circular Sparkle button for progressive overload
              Container(
                width: 42,
                alignment: Alignment.centerRight,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF1B2C52),
                    border: Border.all(
                      color: const Color(0xFF2C4C8A),
                      width: 1.2,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      color: Color(0xFF4A84FF),
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Set Rows
          ...currentExercise.sets.asMap().entries.map((entry) {
            final setIndex = entry.key;
            final set = entry.value;

            final prevWeight = setIndex == 0 ? 18 : 86;
            final prevReps = setIndex == 0 ? 10 : 8;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  // 1. Serie Column (Dark rounded square)
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1D),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${set.setNumber}',
                      style: const TextStyle(
                        fontFamily: AppTheme.fontAlbert,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                  ),

                  // 2. Previa Column (Text)
                  Expanded(
                    flex: 3,
                    child: Text(
                      '$prevWeight x $prevReps',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: AppTheme.fontDM,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                  ),

                  // 3. KG Column (Rounded dark container)
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => _editSetDialog(
                        context: context,
                        exerciseIndex: exerciseIndex,
                        setIndex: setIndex,
                        currentWeight: set.weightKg,
                        currentReps: set.reps,
                      ),
                      child: Container(
                        height: 44,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1D),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          set.weightKg > 0
                              ? '${set.weightKg.toInt()}'
                              : (setIndex == 0 ? '18' : '86'),
                          style: const TextStyle(
                            fontFamily: AppTheme.fontAlbert,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 4. REPES Column (Rounded dark container)
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => _editSetDialog(
                        context: context,
                        exerciseIndex: exerciseIndex,
                        setIndex: setIndex,
                        currentWeight: set.weightKg,
                        currentReps: set.reps,
                      ),
                      child: Container(
                        height: 44,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1D),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          set.reps > 0 ? '${set.reps}' : '10',
                          style: const TextStyle(
                            fontFamily: AppTheme.fontAlbert,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 5. Check Button Column
                  Container(
                    width: 42,
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        context.read<TrainingBloc>().add(
                              ToggleSetCompletionEvent(
                                exerciseIndex: exerciseIndex,
                                setIndex: setIndex,
                                weight: set.weightKg > 0
                                    ? set.weightKg
                                    : (setIndex == 0 ? 18.0 : 86.0),
                                reps: set.reps > 0 ? set.reps : 10,
                              ),
                            );
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: set.isCompleted
                              ? AppColors.primaryBlue
                              : const Color(0xFF242428),
                          border: Border.all(
                            color: set.isCompleted
                                ? AppColors.accentBlue
                                : const Color(0xFF33333A),
                            width: 1.2,
                          ),
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          size: 20,
                          color: set.isCompleted
                              ? Colors.white
                              : const Color(0xFF8E8E93),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _editSetDialog({
    required BuildContext context,
    required int exerciseIndex,
    required int setIndex,
    required double currentWeight,
    required int currentReps,
  }) {
    final weightController = TextEditingController(
      text: currentWeight > 0 ? '${currentWeight.toInt()}' : '86',
    );
    final repsController = TextEditingController(
      text: currentReps > 0 ? '$currentReps' : '10',
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF141416),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFF26262B)),
        ),
        title: const Text(
          'Ingresa tus datos',
          style: TextStyle(
            fontFamily: AppTheme.fontAlbert,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                labelStyle: TextStyle(color: Color(0xFF8E8E93)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF26262B)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryBlue),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: repsController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Repeticiones',
                labelStyle: TextStyle(color: Color(0xFF8E8E93)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF26262B)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryBlue),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Color(0xFF8E8E93)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              final newWeight = double.tryParse(weightController.text) ?? currentWeight;
              final newReps = int.tryParse(repsController.text) ?? currentReps;
              context.read<TrainingBloc>().add(
                    ToggleSetCompletionEvent(
                      exerciseIndex: exerciseIndex,
                      setIndex: setIndex,
                      weight: newWeight,
                      reps: newReps,
                    ),
                  );
              Navigator.pop(ctx);
            },
            child: const Text(
              'Aceptar',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSymmetryIntelligenceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF141416),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFF26262B)),
        ),
        title: const Row(
          children: [
            Icon(Icons.auto_awesome_rounded, color: AppColors.accentBlue, size: 22),
            SizedBox(width: 8),
            Text(
              'Proport Intelligence',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ],
        ),
        content: const Text(
          'Symmetry Intelligence calcula el peso y repeticiones por ti para maximizar tu progreso y minimizar la fatiga muscular.',
          style: TextStyle(
            fontFamily: AppTheme.fontDM,
            color: Color(0xFFD1D1D6),
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Entendido', style: TextStyle(color: AppColors.accentBlue)),
          ),
        ],
      ),
    );
  }

  void _confirmFinish(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF141416),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFF26262B)),
        ),
        title: const Text(
          'Terminar Entrenamiento',
          style: TextStyle(
            fontFamily: AppTheme.fontAlbert,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        content: const Text(
          '¿Deseas terminar y registrar tu sesión de entrenamiento?',
          style: TextStyle(
            fontFamily: AppTheme.fontDM,
            color: Color(0xFFD1D1D6),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Continuar', style: TextStyle(color: Color(0xFF8E8E93))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              context.read<TrainingBloc>().add(const FinishWorkoutSessionEvent());
            },
            child: const Text(
              'Terminar',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
