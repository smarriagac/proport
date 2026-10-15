import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/symmetry_extended_image.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_set.dart';
import '../../domain/repositories/training_repository.dart';

class ExercisePickerBottomSheet extends StatefulWidget {
  const ExercisePickerBottomSheet({super.key});

  static Future<Exercise?> show(BuildContext context) {
    return showModalBottomSheet<Exercise?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (context) => const ExercisePickerBottomSheet(),
    );
  }

  @override
  State<ExercisePickerBottomSheet> createState() =>
      _ExercisePickerBottomSheetState();
}

class _ExercisePickerBottomSheetState extends State<ExercisePickerBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Exercise> _allExercises = _fallbackExercises;
  bool _isLoading = false;
  String _selectedCategory = 'Todos';

  static const List<String> _categories = [
    'Todos',
    'Pecho',
    'Espalda',
    'Piernas',
    'Hombros',
    'Bíceps',
    'Tríceps',
    'Core',
    'Cardio',
  ];

  static const List<Exercise> _fallbackExercises = [
    Exercise(
      exerciseTemplateId: 102,
      name: 'Press De Banca Inclinado (Barra Recta)',
      muscleGroup: 'Pecho',
      thumbnailURL: AppAssets.gifInclineBenchPress,
    ),
    Exercise(
      exerciseTemplateId: 107,
      name: 'Press De Banca Plano (Mancuerna)',
      muscleGroup: 'Pecho',
      thumbnailURL: AppAssets.gifFlatBenchPress,
    ),
    Exercise(
      exerciseTemplateId: 103,
      name: 'Aperturas En Polea Alta (Cable)',
      muscleGroup: 'Pecho',
      thumbnailURL: AppAssets.gifLowCableCrossover,
    ),
    Exercise(
      exerciseTemplateId: 201,
      name: 'Jalón Al Pecho Agarre Prono (Máquina)',
      muscleGroup: 'Espalda',
      thumbnailURL: AppAssets.gifLatPulldownPronated,
    ),
    Exercise(
      exerciseTemplateId: 202,
      name: 'Remo Sentado En Polea',
      muscleGroup: 'Espalda',
      thumbnailURL: AppAssets.gifSeatedCableRow,
    ),
    Exercise(
      exerciseTemplateId: 1,
      name: 'Sentadilla (Barra Alta)',
      muscleGroup: 'Piernas',
    ),
    Exercise(
      exerciseTemplateId: 2,
      name: 'Prensa a 45°',
      muscleGroup: 'Piernas',
    ),
    Exercise(
      exerciseTemplateId: 4312,
      name: 'Bulgarian Split Squat',
      muscleGroup: 'Piernas',
    ),
    Exercise(
      exerciseTemplateId: 104,
      name: 'Press De Hombros Sentado (Mancuerna)',
      muscleGroup: 'Hombros',
      thumbnailURL: AppAssets.gifSeatedShoulderPress,
    ),
    Exercise(
      exerciseTemplateId: 105,
      name: 'Elevaciones Laterales (Mancuerna)',
      muscleGroup: 'Hombros',
      thumbnailURL: AppAssets.gifLateralRaises,
    ),
    Exercise(
      exerciseTemplateId: 25,
      name: 'Curl Martillo Bilateral (Mancuerna)',
      muscleGroup: 'Bíceps',
      thumbnailURL: AppAssets.gifBicepCurl,
    ),
    Exercise(
      exerciseTemplateId: 26,
      name: 'Curl De Bíceps Inclinado (Mancuerna)',
      muscleGroup: 'Bíceps',
      thumbnailURL: AppAssets.gifBicepCurl,
    ),
    Exercise(
      exerciseTemplateId: 27,
      name: 'Extensión De Tríceps (Cuerda)',
      muscleGroup: 'Tríceps',
      thumbnailURL: AppAssets.gifTricepsPushdown,
    ),
    Exercise(
      exerciseTemplateId: 108,
      name: 'Fondos En Paralelas (Tríceps)',
      muscleGroup: 'Tríceps',
      thumbnailURL: AppAssets.gifBenchDips,
    ),
    Exercise(
      exerciseTemplateId: 3421,
      name: 'Bicycle Crunch',
      muscleGroup: 'Core',
    ),
    Exercise(
      exerciseTemplateId: 101,
      name: 'Andar En Cinta De Correr',
      muscleGroup: 'Cardio',
      thumbnailURL: AppAssets.gifTreadmill,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadExercises();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _loadExercises() async {
    if (getIt.isRegistered<TrainingRepository>()) {
      try {
        final catalog = await getIt<TrainingRepository>().getExerciseCatalog();
        if (mounted) {
          setState(() {
            _allExercises = catalog.isNotEmpty ? catalog : _fallbackExercises;
            _isLoading = false;
          });
        }
      } catch (_) {
        if (mounted) {
          setState(() {
            _allExercises = _fallbackExercises;
            _isLoading = false;
          });
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _allExercises = _fallbackExercises;
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Exercise> get _filteredExercises {
    final query = _searchController.text.trim().toLowerCase();

    return _allExercises.where((exercise) {
      // 1. Muscle Category filter
      if (_selectedCategory != 'Todos') {
        final matchesCategory = _matchesCategory(exercise.muscleGroup, _selectedCategory);
        if (!matchesCategory) return false;
      }

      // 2. Query filter
      if (query.isNotEmpty) {
        final nameMatches = exercise.name.toLowerCase().contains(query);
        final muscleMatches = exercise.muscleGroup.toLowerCase().contains(query);
        if (!nameMatches && !muscleMatches) return false;
      }

      return true;
    }).toList();
  }

  bool _matchesCategory(String exerciseMuscle, String selectedCategory) {
    final m = exerciseMuscle.toLowerCase();
    final c = selectedCategory.toLowerCase();

    if (c == 'todos') return true;
    if (m == c) return true;

    if (c == 'pecho') {
      return m.contains('pecho') || m.contains('chest');
    } else if (c == 'espalda') {
      return m.contains('espalda') ||
          m.contains('back') ||
          m.contains('lat') ||
          m.contains('trap');
    } else if (c == 'piernas') {
      return m.contains('pierna') ||
          m.contains('quad') ||
          m.contains('femoral') ||
          m.contains('hamstring') ||
          m.contains('glute') ||
          m.contains('calv');
    } else if (c == 'hombros') {
      return m.contains('hombro') ||
          m.contains('shoulder') ||
          m.contains('deltoid');
    } else if (c == 'bíceps') {
      return m.contains('bicep') || m.contains('bícep');
    } else if (c == 'tríceps') {
      return m.contains('tricep') || m.contains('trícep');
    } else if (c == 'core') {
      return m.contains('core') || m.contains('abs') || m.contains('abdom');
    } else if (c == 'cardio') {
      return m.contains('cardio') || m.contains('cinta') || m.contains('correr');
    }

    return false;
  }

  void _selectExercise(Exercise exercise) {
    final withDefaultSets = exercise.copyWith(
      sets: const [
        ExerciseSet(setNumber: 1, reps: 10, weightKg: 20),
        ExerciseSet(setNumber: 2, reps: 10, weightKg: 20),
        ExerciseSet(setNumber: 3, reps: 10, weightKg: 20),
      ],
    );
    Navigator.of(context).pop(withDefaultSets);
  }

  String _resolveThumbnail(Exercise exercise) {
    if (exercise.thumbnailURL != null && exercise.thumbnailURL!.isNotEmpty) {
      return exercise.thumbnailURL!;
    }
    final lower = exercise.name.toLowerCase();
    if (lower.contains('cinta') || lower.contains('correr') || lower.contains('andar')) {
      return AppAssets.gifTreadmill;
    }
    if (lower.contains('inclinado')) return AppAssets.gifInclineBenchPress;
    if (lower.contains('plano') || lower.contains('banca')) {
      return AppAssets.gifFlatBenchPress;
    }
    if (lower.contains('fondo') || lower.contains('dip')) {
      return AppAssets.gifBenchDips;
    }
    if (lower.contains('tríceps') || lower.contains('triceps') || lower.contains('cuerda')) {
      return AppAssets.gifTricepsPushdown;
    }
    if (lower.contains('apertura') || lower.contains('polea') || lower.contains('cruce')) {
      return AppAssets.gifLowCableCrossover;
    }
    if (lower.contains('militar')) return AppAssets.gifStandingMilitaryPress;
    if (lower.contains('hombro')) return AppAssets.gifSeatedShoulderPress;
    if (lower.contains('lateral') || lower.contains('elevacion')) {
      return AppAssets.gifLateralRaises;
    }
    if (lower.contains('jalón') || lower.contains('jalon')) {
      return AppAssets.gifLatPulldownPronated;
    }
    if (lower.contains('remo')) return AppAssets.gifSeatedCableRow;
    if (lower.contains('curl') || lower.contains('bicep')) {
      return AppAssets.gifBicepCurl;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final exercises = _filteredExercises;

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: Color(0xFF09090A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: Color(0xFF26262B), width: 1.2),
          left: BorderSide(color: Color(0xFF26262B), width: 1.2),
          right: BorderSide(color: Color(0xFF26262B), width: 1.2),
        ),
      ),
      child: Column(
        children: [
          // Drag Handle
          const SizedBox(height: 12),
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
          const SizedBox(height: 12),

          // Header: Title & Close Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Añadir Ejercicio',
                  style: TextStyle(
                    fontFamily: AppTheme.fontAlbert,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded, color: Colors.white70, size: 24),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFF141416),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF26262B), width: 1.0),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  fontFamily: AppTheme.fontDM,
                  color: Colors.white,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF8E8E93),
                    size: 22,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded,
                              color: Color(0xFF8E8E93), size: 18),
                          onPressed: () => _searchController.clear(),
                        )
                      : null,
                  hintText: 'Buscar por nombre o músculo...',
                  hintStyle: const TextStyle(
                    fontFamily: AppTheme.fontDM,
                    color: Color(0xFF636366),
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Muscle Category Filter Chips
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = cat == _selectedCategory;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = cat;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF24242A)
                          : const Color(0xFF141416),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF26262B),
                        width: 1.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      cat,
                      style: TextStyle(
                        fontFamily: AppTheme.fontAlbert,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                        fontSize: 13,
                        color: isSelected ? Colors.white : const Color(0xFF8E8E93),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),

          // Exercise List
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryBlue,
                      strokeWidth: 2.5,
                    ),
                  )
                : exercises.isEmpty
                    ? Center(
                        child: Text(
                          'No se encontraron ejercicios',
                          style: TextStyle(
                            fontFamily: AppTheme.fontDM,
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 14,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(18, 6, 18, 24),
                        itemCount: exercises.length,
                        separatorBuilder: (_, __) =>
                            const Divider(color: Color(0xFF18181C), height: 16),
                        itemBuilder: (context, index) {
                          final exercise = exercises[index];
                          final thumb = _resolveThumbnail(exercise);

                          return InkWell(
                            onTap: () => _selectExercise(exercise),
                            borderRadius: BorderRadius.circular(14),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  // Squircle Thumbnail
                                  Container(
                                    width: 54,
                                    height: 54,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: thumb.isNotEmpty
                                        ? SymmetryExtendedImage(
                                            source: thumb,
                                            fit: BoxFit.contain,
                                            placeholder: const SizedBox(),
                                            errorWidget: const Icon(
                                              Icons.fitness_center_rounded,
                                              color: Colors.black87,
                                              size: 24,
                                            ),
                                          )
                                        : const Icon(
                                            Icons.fitness_center_rounded,
                                            color: Colors.black87,
                                            size: 24,
                                          ),
                                  ),
                                  const SizedBox(width: 14),

                                  // Name & Muscle Tag
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          exercise.name,
                                          style: const TextStyle(
                                            fontFamily: AppTheme.fontAlbert,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF1B1B1F),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                              color: const Color(0xFF26262B),
                                              width: 0.8,
                                            ),
                                          ),
                                          child: Text(
                                            exercise.muscleGroup,
                                            style: const TextStyle(
                                              fontFamily: AppTheme.fontDM,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF8E8E93),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Add '+' Button
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF19191D),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF2A2A30),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.add_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
