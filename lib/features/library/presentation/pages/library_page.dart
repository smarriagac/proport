import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:proport/core/constants/app_constants.dart';
import 'package:proport/core/di/injection.dart';
import 'package:proport/core/theme/app_theme.dart';
import 'package:proport/features/training/domain/entities/exercise.dart';
import 'package:proport/features/training/domain/entities/exercise_set.dart';
import 'package:proport/features/training/domain/entities/training_session.dart';
import 'package:proport/features/training/domain/repositories/training_repository.dart';
import 'package:proport/features/training/presentation/widgets/exercise_picker_bottom_sheet.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  int _selectedChipIndex = 0; // 0: Tu plan inteligente, 1: Programas, 2: Plantillas, 3: Ejercicios
  List<_LibraryTemplateItem> _templateItems = [];

  static const List<_LibraryTemplateItem> _defaultTemplates = [
    _LibraryTemplateItem(
      title: 'Domingo',
      subtitle: 'Plantilla',
      imageAsset: 'assets/images/routines/routine_domingo.png',
      exerciseAssets: [
        'assets/images/exercises/9n2149Z.gif',
        'assets/images/exercises/my33uHU.gif',
        'assets/images/exercises/fUBheHs.gif',
        'assets/images/exercises/EIeI8Vf.gif',
      ],
      session: TrainingSession(
        templateId: 'template_domingo',
        dayOfWeek: 7,
        name: 'Domingo',
        description: 'Domingo de Pierna',
        exercises: [
          Exercise(
            exerciseTemplateId: 1,
            name: 'Sentadilla (Barra Alta)',
            muscleGroup: 'Piernas',
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 80),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 85),
              ExerciseSet(setNumber: 3, reps: 8, weightKg: 90),
              ExerciseSet(setNumber: 4, reps: 8, weightKg: 90),
            ],
          ),
          Exercise(
            exerciseTemplateId: 2,
            name: 'Prensa a 45°',
            muscleGroup: 'Piernas',
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 120),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 140),
              ExerciseSet(setNumber: 3, reps: 10, weightKg: 160),
            ],
          ),
          Exercise(
            exerciseTemplateId: 4312,
            name: 'Bulgarian Split Squat',
            muscleGroup: 'Piernas',
            sets: [
              ExerciseSet(setNumber: 1, reps: 12, weightKg: 20),
              ExerciseSet(setNumber: 2, reps: 12, weightKg: 20),
              ExerciseSet(setNumber: 3, reps: 12, weightKg: 20),
            ],
          ),
          Exercise(
            exerciseTemplateId: 1933,
            name: 'Standing Calf Raise',
            muscleGroup: 'Piernas',
            sets: [
              ExerciseSet(setNumber: 1, reps: 15, weightKg: 50),
              ExerciseSet(setNumber: 2, reps: 15, weightKg: 50),
              ExerciseSet(setNumber: 3, reps: 15, weightKg: 50),
              ExerciseSet(setNumber: 4, reps: 15, weightKg: 50),
            ],
          ),
        ],
      ),
    ),
    _LibraryTemplateItem(
      title: 'Sábado de Tracción 🦍',
      subtitle: 'Plantilla · 8 ejercicios',
      imageAsset: 'assets/images/routines/routine_traccion.png',
      exerciseAssets: [
        'assets/images/exercises/CmEr4pM.gif',
        'assets/images/exercises/fUBheHs.gif',
        'assets/images/exercises/4dUn2iv.gif',
        'assets/images/exercises/G61cXLk.gif',
      ],
      session: TrainingSession(
        templateId: 'template_traccion',
        dayOfWeek: 6,
        name: 'Sábado de Tracción 🦍',
        description: 'Tirón / Tracción',
        exercises: [
          Exercise(
            exerciseTemplateId: 201,
            name: 'Jalón Al Pecho Agarre Prono (Máquina)',
            muscleGroup: 'Espalda',
            thumbnailURL: AppAssets.gifLatPulldownPronated,
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 60),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 65),
              ExerciseSet(setNumber: 3, reps: 8, weightKg: 70),
            ],
          ),
          Exercise(
            exerciseTemplateId: 202,
            name: 'Remo Sentado En Polea',
            muscleGroup: 'Espalda',
            thumbnailURL: AppAssets.gifSeatedCableRow,
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 55),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 60),
              ExerciseSet(setNumber: 3, reps: 10, weightKg: 65),
            ],
          ),
          Exercise(
            exerciseTemplateId: 1901,
            name: 'Inverted Row',
            muscleGroup: 'Espalda',
            sets: [
              ExerciseSet(setNumber: 1, reps: 12, weightKg: 0),
              ExerciseSet(setNumber: 2, reps: 12, weightKg: 0),
              ExerciseSet(setNumber: 3, reps: 12, weightKg: 0),
            ],
          ),
          Exercise(
            exerciseTemplateId: 26,
            name: 'Curl De Bíceps Inclinado (Mancuerna)',
            muscleGroup: 'Bíceps',
            thumbnailURL: AppAssets.gifBicepCurl,
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 12),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 14),
              ExerciseSet(setNumber: 3, reps: 10, weightKg: 14),
            ],
          ),
        ],
      ),
    ),
    _LibraryTemplateItem(
      title: 'Sábado de Empuje 🫣',
      subtitle: 'Plantilla · 10 ejercicios',
      imageAsset: 'assets/images/routines/routine_empuje.png',
      exerciseAssets: [
        'assets/images/exercises/5v7KYld.gif',
        'assets/images/exercises/EIeI8Vf.gif',
        'assets/images/exercises/7saC5zz.gif',
        'assets/images/exercises/2IxROQ1.gif',
      ],
      session: TrainingSession(
        templateId: 'template_empuje',
        dayOfWeek: 6,
        name: 'Sábado de Empuje 🫣',
        description: 'Empuje',
        exercises: [
          Exercise(
            exerciseTemplateId: 102,
            name: 'Press De Banca Inclinado (Barra Recta)',
            muscleGroup: 'Pecho',
            thumbnailURL: AppAssets.gifInclineBenchPress,
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 60),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 65),
              ExerciseSet(setNumber: 3, reps: 8, weightKg: 70),
            ],
          ),
          Exercise(
            exerciseTemplateId: 104,
            name: 'Press De Hombros Sentado (Mancuerna)',
            muscleGroup: 'Hombros',
            thumbnailURL: AppAssets.gifSeatedShoulderPress,
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 20),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 22),
              ExerciseSet(setNumber: 3, reps: 8, weightKg: 24),
            ],
          ),
          Exercise(
            exerciseTemplateId: 105,
            name: 'Elevaciones Laterales (Mancuerna)',
            muscleGroup: 'Hombros',
            thumbnailURL: AppAssets.gifLateralRaises,
            sets: [
              ExerciseSet(setNumber: 1, reps: 12, weightKg: 10),
              ExerciseSet(setNumber: 2, reps: 12, weightKg: 12),
              ExerciseSet(setNumber: 3, reps: 12, weightKg: 12),
            ],
          ),
          Exercise(
            exerciseTemplateId: 108,
            name: 'Fondos En Paralelas (Tríceps)',
            muscleGroup: 'Tríceps',
            thumbnailURL: AppAssets.gifBenchDips,
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 0),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 0),
              ExerciseSet(setNumber: 3, reps: 10, weightKg: 0),
            ],
          ),
        ],
      ),
    ),
    _LibraryTemplateItem(
      title: 'Pecho, Triceps',
      subtitle: 'Plantilla · 8 ejercicios',
      imageAsset: 'assets/images/routines/routine_pecho_triceps.png',
      exerciseAssets: [
        'assets/images/exercises/EIeI8Vf.gif',
        'assets/images/exercises/5v7KYld.gif',
        'assets/images/exercises/7saC5zz.gif',
        'assets/images/exercises/2IxROQ1.gif',
      ],
      session: TrainingSession(
        templateId: 'template_pecho_triceps',
        dayOfWeek: 1,
        name: 'Pecho, Triceps',
        description: 'Pecho y Tríceps',
        exercises: [
          Exercise(
            exerciseTemplateId: 107,
            name: 'Press De Banca Plano (Mancuerna)',
            muscleGroup: 'Pecho',
            thumbnailURL: AppAssets.gifFlatBenchPress,
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 26),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 28),
              ExerciseSet(setNumber: 3, reps: 8, weightKg: 30),
              ExerciseSet(setNumber: 4, reps: 8, weightKg: 30),
            ],
          ),
          Exercise(
            exerciseTemplateId: 103,
            name: 'Aperturas En Polea Alta (Cable)',
            muscleGroup: 'Pecho',
            thumbnailURL: AppAssets.gifLowCableCrossover,
            sets: [
              ExerciseSet(setNumber: 1, reps: 12, weightKg: 15),
              ExerciseSet(setNumber: 2, reps: 12, weightKg: 15),
              ExerciseSet(setNumber: 3, reps: 12, weightKg: 15),
            ],
          ),
          Exercise(
            exerciseTemplateId: 27,
            name: 'Extensión De Tríceps (Cuerda)',
            muscleGroup: 'Tríceps',
            thumbnailURL: AppAssets.gifTricepsPushdown,
            sets: [
              ExerciseSet(setNumber: 1, reps: 12, weightKg: 25),
              ExerciseSet(setNumber: 2, reps: 12, weightKg: 25),
              ExerciseSet(setNumber: 3, reps: 12, weightKg: 25),
            ],
          ),
          Exercise(
            exerciseTemplateId: 29,
            name: 'Extensión De Tríceps Katana (Cuerda)',
            muscleGroup: 'Tríceps',
            sets: [
              ExerciseSet(setNumber: 1, reps: 12, weightKg: 15),
              ExerciseSet(setNumber: 2, reps: 12, weightKg: 20),
              ExerciseSet(setNumber: 3, reps: 10, weightKg: 20),
            ],
          ),
        ],
      ),
    ),
    _LibraryTemplateItem(
      title: 'Espalda, Biceps',
      subtitle: 'Plantilla · 7 ejercicios',
      imageAsset: 'assets/images/routines/routine_espalda_biceps.png',
      exerciseAssets: [
        'assets/images/exercises/CmEr4pM.gif',
        'assets/images/exercises/fUBheHs.gif',
        'assets/images/exercises/CmEr4pM.gif',
        'assets/images/exercises/4dUn2iv.gif',
      ],
      session: TrainingSession(
        templateId: 'template_espalda_biceps',
        dayOfWeek: 2,
        name: 'Espalda, Biceps',
        description: 'Espalda y Bíceps',
        exercises: [
          Exercise(
            exerciseTemplateId: 203,
            name: 'Jalón Al Pecho Agarre Supino',
            muscleGroup: 'Espalda',
            thumbnailURL: AppAssets.gifLatPulldownPronated,
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 65),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 70),
              ExerciseSet(setNumber: 3, reps: 8, weightKg: 75),
              ExerciseSet(setNumber: 4, reps: 8, weightKg: 75),
            ],
          ),
          Exercise(
            exerciseTemplateId: 204,
            name: 'Remo Con Mancuerna',
            muscleGroup: 'Espalda',
            thumbnailURL: AppAssets.gifSeatedCableRow,
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 28),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 30),
              ExerciseSet(setNumber: 3, reps: 8, weightKg: 32),
            ],
          ),
          Exercise(
            exerciseTemplateId: 25,
            name: 'Curl Martillo Bilateral (Mancuerna)',
            muscleGroup: 'Bíceps',
            thumbnailURL: AppAssets.gifBicepCurl,
            sets: [
              ExerciseSet(setNumber: 1, reps: 12, weightKg: 14),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 16),
              ExerciseSet(setNumber: 3, reps: 10, weightKg: 16),
            ],
          ),
          Exercise(
            exerciseTemplateId: 1804,
            name: 'Curl Predicador (Máquina)',
            muscleGroup: 'Bíceps',
            thumbnailURL: AppAssets.gifBicepCurl,
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 30),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 35),
              ExerciseSet(setNumber: 3, reps: 10, weightKg: 35),
            ],
          ),
        ],
      ),
    ),
    _LibraryTemplateItem(
      title: 'Piernas, Hombros',
      subtitle: 'Plantilla · 7 ejercicios',
      imageAsset: 'assets/images/routines/routine_piernas_hombros.png',
      exerciseAssets: [
        'assets/images/exercises/9n2149Z.gif',
        'assets/images/exercises/my33uHU.gif',
        'assets/images/exercises/znQUdHY.gif',
        'assets/images/exercises/DsgkuIt.gif',
      ],
      session: TrainingSession(
        templateId: 'template_piernas_hombros',
        dayOfWeek: 3,
        name: 'Piernas, Hombros',
        description: 'Piernas y Hombros',
        exercises: [
          Exercise(
            exerciseTemplateId: 2,
            name: 'Prensa a 45°',
            muscleGroup: 'Piernas',
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 140),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 160),
              ExerciseSet(setNumber: 3, reps: 8, weightKg: 180),
              ExerciseSet(setNumber: 4, reps: 8, weightKg: 180),
            ],
          ),
          Exercise(
            exerciseTemplateId: 1896,
            name: 'Single Leg Romanian Deadlift',
            muscleGroup: 'Piernas',
            sets: [
              ExerciseSet(setNumber: 1, reps: 10, weightKg: 20),
              ExerciseSet(setNumber: 2, reps: 10, weightKg: 24),
              ExerciseSet(setNumber: 3, reps: 10, weightKg: 24),
            ],
          ),
          Exercise(
            exerciseTemplateId: 109,
            name: 'Press Militar De Pie (Barra)',
            muscleGroup: 'Hombros',
            thumbnailURL: AppAssets.gifStandingMilitaryPress,
            sets: [
              ExerciseSet(setNumber: 1, reps: 8, weightKg: 40),
              ExerciseSet(setNumber: 2, reps: 8, weightKg: 45),
              ExerciseSet(setNumber: 3, reps: 8, weightKg: 45),
            ],
          ),
          Exercise(
            exerciseTemplateId: 105,
            name: 'Elevaciones Laterales (Mancuerna)',
            muscleGroup: 'Hombros',
            thumbnailURL: AppAssets.gifLateralRaises,
            sets: [
              ExerciseSet(setNumber: 1, reps: 12, weightKg: 10),
              ExerciseSet(setNumber: 2, reps: 12, weightKg: 12),
              ExerciseSet(setNumber: 3, reps: 12, weightKg: 12),
            ],
          ),
        ],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _templateItems = List.from(_defaultTemplates);
    _loadTemplatesFromDb();
  }

  Future<void> _loadTemplatesFromDb() async {
    if (!getIt.isRegistered<TrainingRepository>()) return;

    try {
      final dbSessions = await getIt<TrainingRepository>().getTemplates();
      if (!mounted || dbSessions.isEmpty) return;

      final updated = dbSessions.map((session) {
        final matchingDefault = _defaultTemplates.firstWhere(
          (d) => d.title == session.name || d.session?.templateId == session.templateId,
          orElse: () => _defaultTemplates.first,
        );

        final subtitle = session.exercises.isNotEmpty
            ? 'Plantilla · ${session.exercises.length} ejercicios'
            : 'Plantilla';

        return _LibraryTemplateItem(
          title: session.name,
          subtitle: subtitle,
          imageAsset: matchingDefault.imageAsset,
          exerciseAssets: matchingDefault.exerciseAssets,
          session: session,
        );
      }).toList();

      setState(() {
        _templateItems = updated;
      });
    } catch (_) {}
  }

  Future<void> _showCreateTemplateDialog() async {
    final nameController = TextEditingController(text: 'Mi Rutina');
    final selectedExercises = <Exercise>[];

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (sheetContext, setModalState) {
            final bottomInset = MediaQuery.of(sheetContext).viewInsets.bottom;

            return Container(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 24 + bottomInset),
              decoration: const BoxDecoration(
                color: Color(0xFF141416),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(
                  top: BorderSide(color: Color(0xFF26262B), width: 1.2),
                ),
              ),
              child: SingleChildScrollView(
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
                          'Crear plantilla',
                          style: TextStyle(
                            fontFamily: AppTheme.fontAlbert,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: Colors.white70),
                          onPressed: () => Navigator.pop(sheetContext),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Nombre',
                      style: TextStyle(
                        fontFamily: AppTheme.fontAlbert,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: nameController,
                      style: const TextStyle(
                        fontFamily: AppTheme.fontAlbert,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF1C1C20),
                        hintText: 'Ej. Pierna Intensa',
                        hintStyle: const TextStyle(color: Color(0xFF636366)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFF26262B)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFF26262B)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ejercicios (${selectedExercises.length})',
                          style: const TextStyle(
                            fontFamily: AppTheme.fontAlbert,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF8E8E93),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            final chosen =
                                await ExercisePickerBottomSheet.show(context);
                            if (chosen != null) {
                              setModalState(() {
                                selectedExercises.add(chosen);
                              });
                            }
                          },
                          icon: const Icon(Icons.add_rounded,
                              size: 18, color: AppColors.primaryBlue),
                          label: const Text(
                            'Añadir',
                            style: TextStyle(
                              fontFamily: AppTheme.fontAlbert,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (selectedExercises.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      ...selectedExercises.asMap().entries.map((entry) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B1B1F),
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: const Color(0xFF26262B)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  entry.value.name,
                                  style: const TextStyle(
                                    fontFamily: AppTheme.fontAlbert,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Color(0xFF8E8E93),
                                  size: 18,
                                ),
                                onPressed: () {
                                  setModalState(() {
                                    selectedExercises.removeAt(entry.key);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                    const SizedBox(height: 20),
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
                        onPressed: () async {
                          final templateName =
                              nameController.text.trim().isNotEmpty
                                  ? nameController.text.trim()
                                  : 'Nueva Plantilla';
                          final newSession = TrainingSession(
                            templateId:
                                'template_${DateTime.now().millisecondsSinceEpoch}',
                            dayOfWeek: 1,
                            name: templateName,
                            description: 'Plantilla personalizada',
                            exercises: selectedExercises,
                          );
                          if (getIt.isRegistered<TrainingRepository>()) {
                            await getIt<TrainingRepository>()
                                .saveTemplate(newSession);
                          }
                          if (sheetContext.mounted) {
                            Navigator.pop(sheetContext);
                          }
                          await _loadTemplatesFromDb();
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Plantilla "$templateName" guardada'),
                                backgroundColor: const Color(0xFF1B1B1E),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Guardar plantilla',
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
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 16,
        leadingWidth: 54,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Center(
            child: CircleAvatar(
              radius: 19,
              backgroundColor: Color(0xFF222226),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ),
        title: const Text(
          'Mi biblioteca',
          style: TextStyle(
            fontFamily: AppTheme.fontAlbert,
            fontWeight: FontWeight.w800,
            fontSize: 24,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          IconButton(
            onPressed: _showCreateTemplateDialog,
            icon: const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 1. Horizontal Category Chips Row
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12),
              child: _buildCategoryChips(),
            ),
          ),

          // 2. Workout Templates List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final template = _templateItems[index];
                return _buildTemplateTile(template);
              },
              childCount: _templateItems.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // 3. Bottom Action Cards
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildBottomActionCard(
                    title: 'Crear plantilla',
                    subtitle: 'Diseña tu rutina personalizada desde cero',
                    svgAsset: AppAssets.libraryCreateProgram,
                    onTap: _showCreateTemplateDialog,
                  ),
                  const SizedBox(height: 12),
                  _buildBottomActionCard(
                    title: 'Explorar programas',
                    subtitle: 'Elige de entre 80+ programas distintos',
                    svgAsset: AppAssets.libraryExplorePrograms,
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Chip 0: Tu plan inteligente (gradient sheen border)
          InkWell(
            onTap: () => setState(() => _selectedChipIndex = 0),
            borderRadius: BorderRadius.circular(22),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF161618),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: _selectedChipIndex == 0
                      ? const Color(0xFF8B5CF6)
                      : const Color(0x668B5CF6),
                  width: 1.2,
                ),
                boxShadow: _selectedChipIndex == 0
                    ? const [
                        BoxShadow(
                          color: Color(0x4D8B5CF6),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: const Text(
                'Tu plan inteligente',
                style: TextStyle(
                  fontFamily: AppTheme.fontAlbert,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Chip 1: Programas
          _buildPillChip(
            title: 'Programas',
            isSelected: _selectedChipIndex == 1,
            onTap: () => setState(() => _selectedChipIndex = 1),
          ),
          const SizedBox(width: 8),

          // Chip 2: Plantillas
          _buildPillChip(
            title: 'Plantillas',
            isSelected: _selectedChipIndex == 2,
            onTap: () => setState(() => _selectedChipIndex = 2),
          ),
          const SizedBox(width: 8),

          // Chip 3: Ejercicios
          _buildPillChip(
            title: 'Ejercicios',
            isSelected: _selectedChipIndex == 3,
            onTap: () => setState(() => _selectedChipIndex = 3),
          ),
        ],
      ),
    );
  }

  Widget _buildPillChip({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color:
              isSelected ? const Color(0xFF2A2A2E) : const Color(0xFF161618),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF38383E) : const Color(0xFF222225),
            width: 1.0,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: AppTheme.fontAlbert,
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: isSelected ? Colors.white : const Color(0xFF9E9EA7),
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateTile(_LibraryTemplateItem item) {
    return InkWell(
      onTap: () async {
        final session = item.session ??
            TrainingSession(
              templateId: 'template_${item.title.toLowerCase().replaceAll(RegExp(r'\s+'), '_')}',
              dayOfWeek: 1,
              name: item.title,
              description: item.subtitle,
              exercises: const [],
            );
        await context.push('/training/session-preview', extra: session);
        await _loadTemplatesFromDb();
      },
      splashColor: Colors.transparent,
      highlightColor: const Color(0xFF1A1A1D),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // 2x2 White Card with Original Downloaded Exercise Drawings
            _buildSketchGridCard(item),
            const SizedBox(width: 16),

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontAlbert,
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                      color: Colors.white,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.iconList,
                        width: 13,
                        height: 13,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF8E8E93),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        item.subtitle,
                        style: const TextStyle(
                          fontFamily: AppTheme.fontDM,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSketchGridCard(_LibraryTemplateItem item) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        item.imageAsset,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildFallbackGrid(item.exerciseAssets),
      ),
    );
  }

  Widget _buildFallbackGrid(List<String> assets) {
    final first = assets.isNotEmpty ? assets[0] : '';
    final second = assets.length > 1 ? assets[1] : '';
    final third = assets.length > 2 ? assets[2] : '';
    final fourth = assets.length > 3 ? assets[3] : '';

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildCellImage(first)),
                Expanded(child: _buildCellImage(second)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildCellImage(third)),
                Expanded(child: _buildCellImage(fourth)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCellImage(String path) {
    if (path.isEmpty) return const SizedBox();
    return Image.asset(
      path,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const SizedBox(),
    );
  }

  Widget _buildBottomActionCard({
    required String title,
    required String subtitle,
    required String svgAsset,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 74,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF141416),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF222225),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            // Dark icon container
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF1B1B1E),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFF2A2A2E),
                  width: 0.8,
                ),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                svgAsset,
                width: 26,
                height: 26,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Texts
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontAlbert,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
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
      ),
    );
  }
}

class _LibraryTemplateItem {
  final String title;
  final String subtitle;
  final String imageAsset;
  final List<String> exerciseAssets;
  final TrainingSession? session;

  const _LibraryTemplateItem({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.exerciseAssets,
    this.session,
  });
}
