import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/symmetry_extended_image.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_set.dart';
import '../../domain/entities/training_session.dart';
import '../../domain/repositories/training_repository.dart';
import '../bloc/training_bloc.dart';
import '../bloc/training_event.dart';
import '../widgets/exercise_picker_bottom_sheet.dart';

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
  late String _routineName;
  late int _durationMinutes;

  @override
  void initState() {
    super.initState();
    _routineName = widget.session.name.isNotEmpty && widget.session.name != 'EMPUJE'
        ? widget.session.name
        : 'Entrenamiento Pro';
    _durationMinutes = widget.session.durationMinutes ?? 120;

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

  void _addExercise(Exercise exercise) {
    // If sets are empty, provide standard 3 sets of 10 reps
    final sets = exercise.sets.isNotEmpty
        ? exercise.sets
        : const [
            ExerciseSet(setNumber: 1, reps: 10, weightKg: 20),
            ExerciseSet(setNumber: 2, reps: 10, weightKg: 20),
            ExerciseSet(setNumber: 3, reps: 10, weightKg: 20),
          ];

    final resolvedMuscle = _resolveMuscleGroup(exercise.name, exercise.muscleGroup);

    final readyExercise = exercise.copyWith(
      muscleGroup: resolvedMuscle,
      sets: sets,
    );

    setState(() {
      _exercises.add(readyExercise);
    });
    _persistCurrentTemplate();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${exercise.name}" añadido a la rutina'),
        backgroundColor: const Color(0xFF1B1B1F),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _removeExercise(int index) {
    if (index >= 0 && index < _exercises.length) {
      final removed = _exercises[index];
      setState(() {
        _exercises.removeAt(index);
      });
      _persistCurrentTemplate();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${removed.name}" eliminado'),
          backgroundColor: const Color(0xFF1B1B1F),
          action: SnackBarAction(
            label: 'Deshacer',
            textColor: AppColors.primaryBlue,
            onPressed: () {
              setState(() {
                _exercises.insert(index, removed);
              });
              _persistCurrentTemplate();
            },
          ),
        ),
      );
    }
  }

  void _persistCurrentTemplate() {
    if (getIt.isRegistered<TrainingRepository>()) {
      final updated = widget.session.copyWith(
        name: _routineName,
        durationMinutes: _durationMinutes,
        exercises: _exercises,
      );
      getIt<TrainingRepository>().saveTemplate(updated);
    }
  }

  /// Biomechanically resolves muscle group by inspecting both metadata and exercise name
  String _resolveMuscleGroup(String name, String raw) {
    final lowerRaw = raw.toLowerCase().trim();
    if (lowerRaw.contains('hombro') || lowerRaw.contains('shoulder') || lowerRaw.contains('deltoid')) {
      return 'Hombros';
    }
    if (lowerRaw.contains('trícep') || lowerRaw.contains('tricep')) {
      return 'Tríceps';
    }
    if (lowerRaw.contains('pecho') || lowerRaw.contains('chest')) {
      return 'Pecho';
    }
    if (lowerRaw.contains('espalda') || lowerRaw.contains('back') || lowerRaw.contains('lat') || lowerRaw.contains('dorsal')) {
      return 'Espalda';
    }
    if (lowerRaw.contains('pierna') || lowerRaw.contains('quad') || lowerRaw.contains('squat') || lowerRaw.contains('femoral') || lowerRaw.contains('glute') || lowerRaw.contains('calv')) {
      return 'Piernas';
    }
    if (lowerRaw.contains('bícep') || lowerRaw.contains('bicep')) {
      return 'Bíceps';
    }
    if (lowerRaw.contains('core') || lowerRaw.contains('abs') || lowerRaw.contains('abdom')) {
      return 'Core';
    }
    if (lowerRaw.contains('cardio') || lowerRaw.contains('cinta') || lowerRaw.contains('correr')) {
      return 'Cardio';
    }

    // Infer from exercise name if raw was unmapped or generic
    final lowerName = name.toLowerCase();
    if (lowerName.contains('remo') ||
        lowerName.contains('row') ||
        lowerName.contains('jalon') ||
        lowerName.contains('jalón') ||
        lowerName.contains('espalda') ||
        lowerName.contains('dominada') ||
        lowerName.contains('pull') ||
        lowerName.contains('lat') ||
        lowerName.contains('dorsal') ||
        lowerName.contains('trapecio')) {
      return 'Espalda';
    }
    if (lowerName.contains('press') ||
        lowerName.contains('banca') ||
        lowerName.contains('pecho') ||
        lowerName.contains('chest') ||
        lowerName.contains('inclinado') ||
        lowerName.contains('plano') ||
        lowerName.contains('apertura') ||
        lowerName.contains('cruce') ||
        lowerName.contains('flexion') ||
        lowerName.contains('push up')) {
      return 'Pecho';
    }
    if (lowerName.contains('hombro') ||
        lowerName.contains('shoulder') ||
        lowerName.contains('militar') ||
        lowerName.contains('lateral') ||
        lowerName.contains('elevacion') ||
        lowerName.contains('elevación') ||
        lowerName.contains('deltoid') ||
        lowerName.contains('pájaro') ||
        lowerName.contains('facepull')) {
      return 'Hombros';
    }
    if (lowerName.contains('tricep') ||
        lowerName.contains('trícep') ||
        lowerName.contains('fondo') ||
        lowerName.contains('dip') ||
        lowerName.contains('katana') ||
        lowerName.contains('cuerda') ||
        lowerName.contains('pushdown') ||
        lowerName.contains('frances')) {
      return 'Tríceps';
    }
    if (lowerName.contains('curl') ||
        lowerName.contains('bicep') ||
        lowerName.contains('bícep') ||
        lowerName.contains('martillo') ||
        lowerName.contains('predicador')) {
      return 'Bíceps';
    }
    if (lowerName.contains('squat') ||
        lowerName.contains('sentadilla') ||
        lowerName.contains('prensa') ||
        lowerName.contains('pierna') ||
        lowerName.contains('quad') ||
        lowerName.contains('femoral') ||
        lowerName.contains('isquio') ||
        lowerName.contains('glute') ||
        lowerName.contains('gemelo') ||
        lowerName.contains('calf') ||
        lowerName.contains('bulgarian') ||
        lowerName.contains('búlgara') ||
        lowerName.contains('zancada') ||
        lowerName.contains('deadlift')) {
      return 'Piernas';
    }
    if (lowerName.contains('plank') ||
        lowerName.contains('crunch') ||
        lowerName.contains('core') ||
        lowerName.contains('abs') ||
        lowerName.contains('abdominal')) {
      return 'Core';
    }
    if (lowerName.contains('cinta') ||
        lowerName.contains('correr') ||
        lowerName.contains('cardio') ||
        lowerName.contains('andar') ||
        lowerName.contains('treadmill')) {
      return 'Cardio';
    }

    return 'Espalda';
  }

  String _assetForMuscle(String muscle) {
    switch (muscle) {
      case 'Espalda':
        return AppAssets.muscleDistributionBack;
      case 'Pecho':
        return AppAssets.muscleDistributionPecho;
      case 'Hombros':
        return AppAssets.muscleDistributionHombros;
      case 'Tríceps':
        return AppAssets.muscleDistributionTriceps;
      case 'Bíceps':
        return AppAssets.muscleDistributionArms;
      case 'Piernas':
        return AppAssets.muscleDistributionLegs;
      case 'Core':
        return AppAssets.muscleDistributionAbs;
      default:
        return AppAssets.muscleDistributionPecho;
    }
  }

  /// Calculates accurate muscle distribution based on active exercises and sets
  List<_MuscleDistributionData> _computeMuscleDistribution() {
    if (_exercises.isEmpty) {
      return const [
        _MuscleDistributionData(name: 'Hombros', percentage: '32%', imageAsset: AppAssets.muscleDistributionHombros),
        _MuscleDistributionData(name: 'Tríceps', percentage: '32%', imageAsset: AppAssets.muscleDistributionTriceps),
        _MuscleDistributionData(name: 'Pecho', percentage: '16%', imageAsset: AppAssets.muscleDistributionPecho),
      ];
    }

    final counts = <String, int>{};
    for (final ex in _exercises) {
      final norm = _resolveMuscleGroup(ex.name, ex.muscleGroup);
      final sets = ex.sets.isNotEmpty ? ex.sets.length : 1;
      counts[norm] = (counts[norm] ?? 0) + sets;
    }

    final totalSets = counts.values.fold<int>(0, (prev, elem) => prev + elem);
    if (totalSets == 0) return const [];

    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final list = sorted.map((entry) {
      final pct = ((entry.value / totalSets) * 100).round();
      return _MuscleDistributionData(
        name: entry.key,
        percentage: '$pct%',
        imageAsset: _assetForMuscle(entry.key),
      );
    }).toList();

    return list;
  }

  String _getExerciseThumbnail(Exercise exercise) {
    if (exercise.thumbnailURL != null && exercise.thumbnailURL!.isNotEmpty) {
      return exercise.thumbnailURL!;
    }
    final name = exercise.name;
    final lower = name.toLowerCase();
    if (lower.contains('cinta') ||
        lower.contains('correr') ||
        lower.contains('andar') ||
        lower.contains('cardio')) {
      return AppAssets.gifTreadmill;
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
    if (lower.contains('tríceps') ||
        lower.contains('triceps') ||
        lower.contains('cuerda')) {
      return AppAssets.gifTricepsPushdown;
    }
    if (lower.contains('apertura') ||
        lower.contains('polea') ||
        lower.contains('cruce')) {
      return AppAssets.gifLowCableCrossover;
    }
    if (lower.contains('militar')) {
      return AppAssets.gifStandingMilitaryPress;
    }
    if (lower.contains('hombro')) {
      return AppAssets.gifSeatedShoulderPress;
    }
    if (lower.contains('lateral') || lower.contains('elevacion')) {
      return AppAssets.gifLateralRaises;
    }
    if (lower.contains('jalón') || lower.contains('jalon')) {
      return AppAssets.gifLatPulldownPronated;
    }
    if (lower.contains('remo')) {
      return AppAssets.gifSeatedCableRow;
    }
    if (lower.contains('curl') || lower.contains('biceps') || lower.contains('bíceps')) {
      return AppAssets.gifBicepCurl;
    }
    return AppAssets.gifInclineBenchPress;
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

  Future<void> _showEditRoutineDialog() async {
    final nameCtrl = TextEditingController(text: _routineName);
    final durationCtrl = TextEditingController(text: _durationMinutes.toString());

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;

        return Container(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 24 + bottomInset),
          decoration: const BoxDecoration(
            color: Color(0xFF141416),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(top: BorderSide(color: Color(0xFF26262B), width: 1.2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF33333A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Editar Rutina',
                    style: TextStyle(
                      fontFamily: AppTheme.fontAlbert,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white70),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Nombre de la rutina',
                style: TextStyle(
                  fontFamily: AppTheme.fontAlbert,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF8E8E93),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: nameCtrl,
                style: const TextStyle(
                  fontFamily: AppTheme.fontAlbert,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF1C1C20),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF26262B)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF26262B)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Duración estimada (minutos)',
                style: TextStyle(
                  fontFamily: AppTheme.fontAlbert,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF8E8E93),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: durationCtrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontFamily: AppTheme.fontAlbert,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF1C1C20),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF26262B)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF26262B)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {
                    final newName = nameCtrl.text.trim();
                    final newDur = int.tryParse(durationCtrl.text.trim()) ?? _durationMinutes;
                    if (newName.isNotEmpty) {
                      setState(() {
                        _routineName = newName;
                        _durationMinutes = newDur;
                      });
                      _persistCurrentTemplate();
                      Navigator.pop(ctx);
                    }
                  },
                  child: const Text(
                    'Guardar Cambios',
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
        );
      },
    );
  }

  Future<void> _showEditExerciseSetsModal(int exerciseIndex) async {
    final exercise = _exercises[exerciseIndex];
    final currentSets = List<ExerciseSet>.from(
      exercise.sets.isNotEmpty
          ? exercise.sets
          : const [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 20),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 20),
              ExerciseSet(setNumber: 3, reps: 10, weightKg: 20),
            ],
    );

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (modalCtx, setModalState) {
            final bottomInset = MediaQuery.of(modalCtx).viewInsets.bottom;

            return Container(
              height: MediaQuery.of(modalCtx).size.height * 0.75,
              padding: EdgeInsets.fromLTRB(20, 16, 20, 24 + bottomInset),
              decoration: const BoxDecoration(
                color: Color(0xFF141416),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(top: BorderSide(color: Color(0xFF26262B), width: 1.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF33333A),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          exercise.name,
                          style: const TextStyle(
                            fontFamily: AppTheme.fontAlbert,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded, color: Colors.white70),
                        onPressed: () => Navigator.pop(modalCtx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      itemCount: currentSets.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, setIdx) {
                        final s = currentSets[setIdx];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1C1C20),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFF26262B)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF26262B),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${setIdx + 1}',
                                  style: const TextStyle(
                                    fontFamily: AppTheme.fontAlbert,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              // Reps controls
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Reps',
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontDM,
                                        fontSize: 11,
                                        color: Color(0xFF8E8E93),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(Icons.remove_circle_outline, color: Colors.white70, size: 20),
                                          onPressed: () {
                                            if (s.reps > 1) {
                                              setModalState(() {
                                                currentSets[setIdx] = s.copyWith(reps: s.reps - 1);
                                              });
                                            }
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Text(
                                            '${s.reps}',
                                            style: const TextStyle(
                                              fontFamily: AppTheme.fontAlbert,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(Icons.add_circle_outline, color: Colors.white70, size: 20),
                                          onPressed: () {
                                            setModalState(() {
                                              currentSets[setIdx] = s.copyWith(reps: s.reps + 1);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Weight controls
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Kg',
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontDM,
                                        fontSize: 11,
                                        color: Color(0xFF8E8E93),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(Icons.remove_circle_outline, color: Colors.white70, size: 20),
                                          onPressed: () {
                                            if (s.weightKg >= 2.5) {
                                              setModalState(() {
                                                currentSets[setIdx] = s.copyWith(weightKg: s.weightKg - 2.5);
                                              });
                                            }
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Text(
                                            s.weightKg % 1 == 0 ? '${s.weightKg.toInt()}' : '${s.weightKg}',
                                            style: const TextStyle(
                                              fontFamily: AppTheme.fontAlbert,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(Icons.add_circle_outline, color: Colors.white70, size: 20),
                                          onPressed: () {
                                            setModalState(() {
                                              currentSets[setIdx] = s.copyWith(weightKg: s.weightKg + 2.5);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (currentSets.length > 1)
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Color(0xFF8E8E93), size: 20),
                                  onPressed: () {
                                    setModalState(() {
                                      currentSets.removeAt(setIdx);
                                    });
                                  },
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Button to add set
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        final lastWeight = currentSets.isNotEmpty ? currentSets.last.weightKg : 20.0;
                        final lastReps = currentSets.isNotEmpty ? currentSets.last.reps : 10;
                        setModalState(() {
                          currentSets.add(
                            ExerciseSet(
                              setNumber: currentSets.length + 1,
                              reps: lastReps,
                              weightKg: lastWeight,
                            ),
                          );
                        });
                      },
                      icon: const Icon(Icons.add_rounded, color: AppColors.primaryBlue),
                      label: const Text(
                        'Añadir Serie',
                        style: TextStyle(
                          fontFamily: AppTheme.fontAlbert,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _exercises[exerciseIndex] = exercise.copyWith(sets: currentSets);
                        });
                        _persistCurrentTemplate();
                        Navigator.pop(modalCtx);
                      },
                      child: const Text(
                        'Guardar Series',
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
            );
          },
        );
      },
    );
  }

  Future<void> _replaceExercise(int index) async {
    if (index < 0 || index >= _exercises.length) return;
    final current = _exercises[index];
    final replacement = await ExercisePickerBottomSheet.show(
      context,
      title: 'Reemplazar Ejercicio',
    );
    if (replacement != null && mounted) {
      setState(() {
        _exercises[index] = replacement.copyWith(
          sets: current.sets.isNotEmpty ? current.sets : replacement.sets,
        );
      });
      _persistCurrentTemplate();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${current.name} reemplazado por ${replacement.name}',
            style: const TextStyle(
              fontFamily: AppTheme.fontDM,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: const Color(0xFF1B1B1F),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xFF26262B)),
          ),
        ),
      );
    }
  }

  void _showExerciseOptions(int index) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: const BoxDecoration(
            color: Color(0xFF141416),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(top: BorderSide(color: Color(0xFF26262B), width: 1.2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF33333A),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 18),
              if (index > 0)
                ListTile(
                  leading: const Icon(Icons.arrow_upward_rounded, color: Colors.white),
                  title: const Text('Subir en el orden', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(ctx);
                    setState(() {
                      final item = _exercises.removeAt(index);
                      _exercises.insert(index - 1, item);
                    });
                    _persistCurrentTemplate();
                  },
                ),
              if (index < _exercises.length - 1)
                ListTile(
                  leading: const Icon(Icons.arrow_downward_rounded, color: Colors.white),
                  title: const Text('Bajar en el orden', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(ctx);
                    setState(() {
                      final item = _exercises.removeAt(index);
                      _exercises.insert(index + 1, item);
                    });
                    _persistCurrentTemplate();
                  },
                ),
              ListTile(
                leading: const Icon(Icons.swap_horiz_rounded, color: AppColors.primaryBlue),
                title: const Text('Reemplazar por otro ejercicio', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(ctx);
                  _replaceExercise(index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_note_rounded, color: Colors.white),
                title: const Text('Editar series y repeticiones', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(ctx);
                  _showEditExerciseSetsModal(index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                title: const Text('Eliminar ejercicio', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(ctx);
                  _removeExercise(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = _routineName;
    final duration = _durationMinutes;
    final exerciseCount = _exercises.length;
    final distribution = _computeMuscleDistribution();

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
            onSelected: (value) {
              if (value == 'rename' || value == 'edit') {
                _showEditRoutineDialog();
              } else if (value == 'add') {
                ExercisePickerBottomSheet.show(context).then((ex) {
                  if (ex != null && mounted) _addExercise(ex);
                });
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'rename',
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined, color: Colors.white, size: 18),
                    SizedBox(width: 10),
                    Text('Cambiar Nombre / Tiempo', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'add',
                child: Row(
                  children: [
                    Icon(Icons.add_rounded, color: Colors.white, size: 18),
                    SizedBox(width: 10),
                    Text('Añadir Ejercicio', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 120),
            children: [
              // Title Header with Quick Edit Icon
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: AppTheme.fontAlbert,
                        fontWeight: FontWeight.w800,
                        fontSize: 28,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: Color(0xFF8E8E93), size: 22),
                    onPressed: _showEditRoutineDialog,
                  ),
                ],
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
                child: distribution.isEmpty
                    ? Center(
                        child: Text(
                          'Añade ejercicios para ver la distribución muscular',
                          style: TextStyle(
                            fontFamily: AppTheme.fontDM,
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 13,
                          ),
                        ),
                      )
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: distribution.map((dist) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: _buildMuscleCard(
                              imageAsset: dist.imageAsset,
                              name: dist.name,
                              percentage: dist.percentage,
                            ),
                          );
                        }).toList(),
                      ),
              ),

              const SizedBox(height: 32),

              // Exercises List Header: "$exerciseCount Ejercicios" + "+" button
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
                      onPressed: () async {
                        final exercise =
                            await ExercisePickerBottomSheet.show(context);
                        if (exercise != null && mounted) {
                          _addExercise(exercise);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Exercise List
              ..._exercises.asMap().entries.map((entry) {
                final index = entry.key;
                final exercise = entry.value;
                final thumbnail = _getExerciseThumbnail(exercise);
                final subtitle = _formatExerciseSubtitle(exercise);

                return InkWell(
                  onTap: () => _showEditExerciseSetsModal(index),
                  onLongPress: () => _showExerciseOptions(index),
                  borderRadius: BorderRadius.circular(18),
                  child: Padding(
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
                              child: SymmetryExtendedImage(
                                source: thumbnail,
                                fit: BoxFit.contain,
                                errorWidget: const Icon(
                                  Icons.fitness_center_rounded,
                                  color: Colors.black,
                                  size: 28,
                                ),
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

                        // Remove button
                        IconButton(
                          tooltip: 'Eliminar ejercicio',
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Color(0xFF8E8E93),
                            size: 20,
                          ),
                          onPressed: () => _removeExercise(index),
                        ),

                        // Replace / Swap icon on right (Directly opens exercise catalog)
                        IconButton(
                          tooltip: 'Reemplazar ejercicio',
                          icon: SvgPicture.asset(
                            AppAssets.iconReplaceArrows,
                            width: 22,
                            height: 22,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          onPressed: () => _replaceExercise(index),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 8),

              // Prominent "+ Añadir ejercicio" Card at the bottom of the list
              InkWell(
                onTap: () async {
                  final exercise = await ExercisePickerBottomSheet.show(context);
                  if (exercise != null && mounted) {
                    _addExercise(exercise);
                  }
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF141416),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF26262B), width: 1.0),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_rounded, color: AppColors.primaryBlue, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Añadir Ejercicio',
                        style: TextStyle(
                          fontFamily: AppTheme.fontAlbert,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
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
                    name: _routineName,
                    durationMinutes: _durationMinutes,
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
    final isSvg = imageAsset.endsWith('.svg');

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
              child: isSvg
                  ? Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SvgPicture.asset(
                        imageAsset,
                        fit: BoxFit.contain,
                      ),
                    )
                  : SymmetryExtendedImage(
                      source: imageAsset,
                      fit: BoxFit.cover,
                      errorWidget: const Icon(
                        Icons.accessibility_new_rounded,
                        color: AppColors.primaryBlue,
                        size: 28,
                      ),
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

class _MuscleDistributionData {
  final String name;
  final String percentage;
  final String imageAsset;

  const _MuscleDistributionData({
    required this.name,
    required this.percentage,
    required this.imageAsset,
  });
}
