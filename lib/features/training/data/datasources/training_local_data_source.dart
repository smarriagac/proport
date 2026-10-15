import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/di/injection.dart';
import '../models/workout_plan_model.dart';
import '../models/training_session_model.dart';
import '../models/exercise_model.dart';
import '../models/exercise_set_model.dart';

abstract class TrainingLocalDataSource {
  Future<List<WorkoutPlanModel>> getWorkoutPlans();
  Future<Map<int, String>> getExerciseNameMap();
  Future<List<ExerciseModel>> getExerciseCatalog();
  Future<String?> getExerciseThumbnail(int exerciseTemplateId);
  String? getCachedThumbnail(int exerciseTemplateId);
  String? getTemplateIdForSession(String sessionName);
  Future<void> saveCompletedSession(TrainingSessionModel session);
  Future<List<TrainingSessionModel>> getCompletedSessions();
  Future<List<TrainingSessionModel>> getTemplates();
  Future<void> saveTemplate(TrainingSessionModel session, [String? explicitId]);
  Future<void> deleteTemplate(String sessionId);
}

class TrainingLocalDataSourceImpl implements TrainingLocalDataSource {
  final AppDatabase db;
  List<WorkoutPlanModel>? _cachedPlans;
  Map<int, String>? _exerciseNameMap;
  List<ExerciseModel>? _cachedCatalog;
  final Map<int, String> _exerciseThumbnailMap = {};
  final Map<String, String> _templateSessionIds = {};

  TrainingLocalDataSourceImpl([AppDatabase? database])
      : db = database ?? getIt<AppDatabase>();

  static const Map<int, String> _builtinExerciseNames = {
    740: 'Push Up (Standard)',
    1901: 'Inverted Row',
    72329: 'Air Squat',
    94233: 'Bodyweight Good Morning',
    54600: 'Forearm Plank',
    1834: 'Pike Push Up',
    4254: 'Towel Door Inverted Row',
    4312: 'Bulgarian Split Squat',
    1896: 'Single Leg Romanian Deadlift',
    1933: 'Standing Calf Raise',
    1812: 'Incline Push Up',
    72337: 'Glute Bridge',
    3421: 'Bicycle Crunch',
    1: 'Sentadilla (Barra Alta)',
    2: 'Prensa a 45°',
    25: 'Curl Martillo Bilateral (Mancuerna)',
    26: 'Curl De Bíceps Inclinado (Mancuerna)',
    27: 'Extensión De Tríceps (Cuerda)',
    29: 'Extensión De Tríceps Katana (Cuerda)',
    1804: 'Curl Predicador (Máquina)',
  };

  @override
  Future<Map<int, String>> getExerciseNameMap() async {
    if (_exerciseNameMap != null) return _exerciseNameMap!;

    final map = Map<int, String>.from(_builtinExerciseNames);
    try {
      final jsonStr =
          await rootBundle.loadString(AppAssets.exerciseRankingMockJson);
      final list = jsonDecode(jsonStr) as List<dynamic>;
      for (final item in list) {
        if (item is Map<String, dynamic>) {
          final id = item['exerciseTemplateId'] as int?;
          final name = item['exerciseName'] as String?;
          if (id != null && name != null) {
            map[id] = name;
          }
        }
      }
    } catch (_) {
      // Fallback to builtin map if asset load encounters any issue
    }

    _exerciseNameMap = map;
    return map;
  }

  @override
  Future<List<WorkoutPlanModel>> getWorkoutPlans() async {
    if (_cachedPlans != null) return _cachedPlans!;

    // 1. Check if Drift database has stored plans
    final planRows = await db.select(db.workoutPlansTable).get();

    if (planRows.isEmpty) {
      // 2. Seed database from JSON assets on first load
      List<WorkoutPlanModel> plans;
      try {
        final jsonStr =
            await rootBundle.loadString(AppAssets.predefinedPlansExampleJson);
        final rawList = jsonDecode(jsonStr) as List<dynamic>;
        plans = rawList
            .map((item) =>
                WorkoutPlanModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } catch (e) {
        plans = _getFallbackPlans();
      }

      // Persist seeded plans, sessions, and exercises into Drift SQLite
      for (final plan in plans) {
        await db.into(db.workoutPlansTable).insert(
              WorkoutPlansTableCompanion.insert(
                id: plan.planId,
                name: plan.name,
                description: plan.description,
                ruleset: plan.ruleset,
                equipmentCategory: plan.equipmentCategory,
                level: plan.level,
                durationPerSession: plan.durationPerSession,
                isActive: const Value(false),
              ),
            );

        for (final session in plan.trainingSessions) {
          final sessionId = '${plan.planId}_day_${session.dayOfWeek}';
          await db.into(db.trainingSessionsTable).insert(
                TrainingSessionsTableCompanion.insert(
                  id: sessionId,
                  planId: plan.planId,
                  name: session.name,
                  description: session.description,
                  dayOfWeek: session.dayOfWeek,
                  isCompleted: Value(session.isCompleted),
                  completedAt: Value(session.completedAt),
                ),
              );

          for (var i = 0; i < session.exercises.length; i++) {
            final ex = session.exercises[i];
            final entryId = await db.into(db.exerciseEntriesTable).insert(
                  ExerciseEntriesTableCompanion.insert(
                    sessionId: sessionId,
                    exerciseTemplateId: ex.exerciseTemplateId,
                    exerciseName: ex.name,
                    muscleGroup: ex.muscleGroup.isNotEmpty
                        ? ex.muscleGroup
                        : _inferMuscleGroup(ex.name),
                    orderIndex: i,
                  ),
                );

            for (final s in ex.sets) {
              await db.into(db.exerciseSetsTable).insert(
                    ExerciseSetsTableCompanion.insert(
                      exerciseEntryId: entryId,
                      setNumber: s.setNumber,
                      weightKg: s.weightKg,
                      reps: s.reps,
                      isCompleted: Value(s.isCompleted),
                    ),
                  );
            }
          }
        }
      }

      _cachedPlans = plans;
      return plans;
    }

    // 3. Reconstruct workout plans from Drift SQLite relational queries
    final List<WorkoutPlanModel> reconstructedPlans = [];

    for (final p in planRows) {
      final sessionRows = await (db.select(db.trainingSessionsTable)
            ..where((t) => t.planId.equals(p.id)))
          .get();

      final List<TrainingSessionModel> sessions = [];

      for (final s in sessionRows) {
        final entryRows = await (db.select(db.exerciseEntriesTable)
              ..where((e) => e.sessionId.equals(s.id))
              ..orderBy([(e) => OrderingTerm.asc(e.orderIndex)]))
            .get();

        final List<ExerciseModel> exercises = [];

        for (final e in entryRows) {
          final setRows = await (db.select(db.exerciseSetsTable)
                ..where((st) => st.exerciseEntryId.equals(e.id))
                ..orderBy([(st) => OrderingTerm.asc(st.setNumber)]))
              .get();

          final sets = setRows
              .map((st) => ExerciseSetModel(
                    setNumber: st.setNumber,
                    reps: st.reps,
                    weightKg: st.weightKg,
                    isCompleted: st.isCompleted,
                  ))
              .toList();

          exercises.add(
            ExerciseModel(
              exerciseTemplateId: e.exerciseTemplateId,
              name: e.exerciseName,
              muscleGroup: e.muscleGroup,
              sets: sets,
            ),
          );
        }

        sessions.add(
          TrainingSessionModel(
            dayOfWeek: s.dayOfWeek,
            name: s.name,
            description: s.description,
            exercises: exercises,
            isCompleted: s.isCompleted,
            completedAt: s.completedAt,
          ),
        );
      }

      reconstructedPlans.add(
        WorkoutPlanModel(
          planId: p.id,
          name: p.name,
          description: p.description,
          ruleset: p.ruleset,
          equipmentCategory: p.equipmentCategory,
          level: p.level,
          durationPerSession: p.durationPerSession,
          trainingSessions: sessions,
        ),
      );
    }

    _cachedPlans = reconstructedPlans;
    return reconstructedPlans;
  }

  @override
  Future<String?> getExerciseThumbnail(int exerciseTemplateId) async {
    if (_cachedCatalog == null) {
      await getExerciseCatalog();
    }
    return _exerciseThumbnailMap[exerciseTemplateId];
  }

  @override
  String? getCachedThumbnail(int exerciseTemplateId) {
    return _exerciseThumbnailMap[exerciseTemplateId];
  }

  @override
  String? getTemplateIdForSession(String sessionName) {
    return _templateSessionIds[sessionName];
  }

  @override
  Future<List<ExerciseModel>> getExerciseCatalog() async {
    if (_cachedCatalog != null) return _cachedCatalog!;

    try {
      final jsonStr =
          await rootBundle.loadString(AppAssets.exerciseCatalogJson);
      final rawList = jsonDecode(jsonStr) as List<dynamic>;
      final List<ExerciseModel> catalog = [];

      for (final item in rawList) {
        if (item is Map<String, dynamic>) {
          final id = (item['id'] as num?)?.toInt() ?? 0;
          final name = (item['name'] as String?) ?? '';
          if (id == 0 || name.isEmpty) continue;

          final rawMuscle = item['focusMuscleGroup'] as String?;
          final muscleGroup = _mapMuscleGroup(rawMuscle);
          final thumb = item['thumbnailURL'] as String?;
          if (thumb != null && thumb.isNotEmpty) {
            _exerciseThumbnailMap[id] = thumb;
          }

          catalog.add(
            ExerciseModel(
              exerciseTemplateId: id,
              name: name,
              muscleGroup: muscleGroup,
              sets: const [],
            ),
          );
        }
      }

      if (_exerciseNameMap == null) {
        _exerciseNameMap = {for (final e in catalog) e.exerciseTemplateId: e.name};
      } else {
        for (final e in catalog) {
          _exerciseNameMap![e.exerciseTemplateId] = e.name;
        }
      }

      _cachedCatalog = catalog;
      return catalog;
    } catch (_) {
      final names = await getExerciseNameMap();
      final fallback = names.entries.map((entry) {
        return ExerciseModel(
          exerciseTemplateId: entry.key,
          name: entry.value,
          muscleGroup: _inferMuscleGroup(entry.value),
        );
      }).toList();
      _cachedCatalog = fallback;
      return fallback;
    }
  }

  @override
  Future<void> saveCompletedSession(TrainingSessionModel session) async {
    final sessionId = 'completed_${DateTime.now().millisecondsSinceEpoch}';

    await db.into(db.trainingSessionsTable).insert(
          TrainingSessionsTableCompanion.insert(
            id: sessionId,
            planId: 'completed_workouts',
            name: session.name,
            description: session.description,
            dayOfWeek: session.dayOfWeek,
            isCompleted: const Value(true),
            completedAt: Value(session.completedAt ?? DateTime.now()),
          ),
        );

    for (var i = 0; i < session.exercises.length; i++) {
      final ex = session.exercises[i];
      final entryId = await db.into(db.exerciseEntriesTable).insert(
            ExerciseEntriesTableCompanion.insert(
              sessionId: sessionId,
              exerciseTemplateId: ex.exerciseTemplateId,
              exerciseName: ex.name,
              muscleGroup: ex.muscleGroup.isNotEmpty
                  ? ex.muscleGroup
                  : _inferMuscleGroup(ex.name),
              orderIndex: i,
            ),
          );

      for (final s in ex.sets) {
        await db.into(db.exerciseSetsTable).insert(
              ExerciseSetsTableCompanion.insert(
                exerciseEntryId: entryId,
                setNumber: s.setNumber,
                weightKg: s.weightKg,
                reps: s.reps,
                isCompleted: Value(s.isCompleted),
              ),
            );
      }
    }
  }

  @override
  Future<List<TrainingSessionModel>> getCompletedSessions() async {
    final sessionRows = await (db.select(db.trainingSessionsTable)
          ..where((t) => t.isCompleted.equals(true))
          ..orderBy([(t) => OrderingTerm.desc(t.completedAt)]))
        .get();

    final List<TrainingSessionModel> result = [];

    for (final s in sessionRows) {
      final entryRows = await (db.select(db.exerciseEntriesTable)
            ..where((e) => e.sessionId.equals(s.id))
            ..orderBy([(e) => OrderingTerm.asc(e.orderIndex)]))
          .get();

      final List<ExerciseModel> exercises = [];

      for (final e in entryRows) {
        final setRows = await (db.select(db.exerciseSetsTable)
              ..where((st) => st.exerciseEntryId.equals(e.id))
              ..orderBy([(st) => OrderingTerm.asc(st.setNumber)]))
            .get();

        exercises.add(
          ExerciseModel(
            exerciseTemplateId: e.exerciseTemplateId,
            name: e.exerciseName,
            muscleGroup: e.muscleGroup,
            sets: setRows
                .map((st) => ExerciseSetModel(
                      setNumber: st.setNumber,
                      reps: st.reps,
                      weightKg: st.weightKg,
                      isCompleted: st.isCompleted,
                    ))
                .toList(),
          ),
        );
      }

      result.add(
        TrainingSessionModel(
          dayOfWeek: s.dayOfWeek,
          name: s.name,
          description: s.description,
          exercises: exercises,
          isCompleted: true,
          completedAt: s.completedAt,
        ),
      );
    }

    return result;
  }

  @override
  Future<List<TrainingSessionModel>> getTemplates() async {
    var templateRows = await (db.select(db.trainingSessionsTable)
          ..where((t) => t.planId.equals('library_templates')))
        .get();

    if (templateRows.isEmpty) {
      await _seedDefaultTemplates();
      templateRows = await (db.select(db.trainingSessionsTable)
            ..where((t) => t.planId.equals('library_templates')))
          .get();
    }

    final List<TrainingSessionModel> result = [];

    for (final s in templateRows) {
      _templateSessionIds[s.name] = s.id;
      _templateSessionIds[s.id] = s.id;

      final entryRows = await (db.select(db.exerciseEntriesTable)
            ..where((e) => e.sessionId.equals(s.id))
            ..orderBy([(e) => OrderingTerm.asc(e.orderIndex)]))
          .get();

      final List<ExerciseModel> exercises = [];

      for (final e in entryRows) {
        final setRows = await (db.select(db.exerciseSetsTable)
              ..where((st) => st.exerciseEntryId.equals(e.id))
              ..orderBy([(st) => OrderingTerm.asc(st.setNumber)]))
            .get();

        exercises.add(
          ExerciseModel(
            exerciseTemplateId: e.exerciseTemplateId,
            name: e.exerciseName,
            muscleGroup: e.muscleGroup,
            sets: setRows
                .map((st) => ExerciseSetModel(
                      setNumber: st.setNumber,
                      reps: st.reps,
                      weightKg: st.weightKg,
                      isCompleted: st.isCompleted,
                    ))
                .toList(),
          ),
        );
      }

      result.add(
        TrainingSessionModel(
          dayOfWeek: s.dayOfWeek,
          name: s.name,
          description: s.description,
          exercises: exercises,
          isCompleted: s.isCompleted,
          completedAt: s.completedAt,
        ),
      );
    }

    return result;
  }

  @override
  Future<void> saveTemplate(TrainingSessionModel session, [String? explicitId]) async {
    String sessionId;
    if (explicitId != null && explicitId.isNotEmpty) {
      sessionId = explicitId;
    } else if (_templateSessionIds.containsKey(session.name)) {
      sessionId = _templateSessionIds[session.name]!;
    } else {
      final existing = await (db.select(db.trainingSessionsTable)
            ..where((t) =>
                t.planId.equals('library_templates') & t.name.equals(session.name)))
          .get();
      if (existing.isNotEmpty) {
        sessionId = existing.first.id;
      } else {
        sessionId = 'template_${DateTime.now().millisecondsSinceEpoch}';
      }
    }

    _templateSessionIds[session.name] = sessionId;
    _templateSessionIds[sessionId] = sessionId;

    await db.into(db.trainingSessionsTable).insertOnConflictUpdate(
          TrainingSessionsTableCompanion(
            id: Value(sessionId),
            planId: const Value('library_templates'),
            name: Value(session.name),
            description: Value(session.description),
            dayOfWeek: Value(session.dayOfWeek),
            isCompleted: Value(session.isCompleted),
            completedAt: Value(session.completedAt),
          ),
        );

    final oldEntries = await (db.select(db.exerciseEntriesTable)
          ..where((e) => e.sessionId.equals(sessionId)))
        .get();
    final oldEntryIds = oldEntries.map((e) => e.id).toList();

    if (oldEntryIds.isNotEmpty) {
      await (db.delete(db.exerciseSetsTable)
            ..where((st) => st.exerciseEntryId.isIn(oldEntryIds)))
          .go();
    }

    await (db.delete(db.exerciseEntriesTable)
          ..where((e) => e.sessionId.equals(sessionId)))
        .go();

    for (var i = 0; i < session.exercises.length; i++) {
      final ex = session.exercises[i];
      final entryId = await db.into(db.exerciseEntriesTable).insert(
            ExerciseEntriesTableCompanion.insert(
              sessionId: sessionId,
              exerciseTemplateId: ex.exerciseTemplateId,
              exerciseName: ex.name,
              muscleGroup: (ex.muscleGroup.isNotEmpty &&
                      ex.muscleGroup != 'General' &&
                      ex.muscleGroup != 'Core & Other')
                  ? ex.muscleGroup
                  : _inferMuscleGroup(ex.name),
              orderIndex: i,
            ),
          );

      for (final s in ex.sets) {
        await db.into(db.exerciseSetsTable).insert(
              ExerciseSetsTableCompanion.insert(
                exerciseEntryId: entryId,
                setNumber: s.setNumber,
                weightKg: s.weightKg,
                reps: s.reps,
                isCompleted: Value(s.isCompleted),
              ),
            );
      }
    }
  }

  @override
  Future<void> deleteTemplate(String sessionId) async {
    final oldEntries = await (db.select(db.exerciseEntriesTable)
          ..where((e) => e.sessionId.equals(sessionId)))
        .get();
    final oldEntryIds = oldEntries.map((e) => e.id).toList();

    if (oldEntryIds.isNotEmpty) {
      await (db.delete(db.exerciseSetsTable)
            ..where((st) => st.exerciseEntryId.isIn(oldEntryIds)))
          .go();
    }

    await (db.delete(db.exerciseEntriesTable)
          ..where((e) => e.sessionId.equals(sessionId)))
        .go();

    await (db.delete(db.trainingSessionsTable)
          ..where((t) => t.id.equals(sessionId)))
        .go();

    _templateSessionIds.removeWhere((_, value) => value == sessionId);
  }

  String _mapMuscleGroup(String? rawGroup) {
    if (rawGroup == null) return 'General';
    switch (rawGroup.toLowerCase()) {
      case 'chest':
        return 'Pecho';
      case 'lats':
      case 'upper_back':
      case 'lower_back':
      case 'trapezius':
        return 'Espalda';
      case 'quadriceps':
      case 'hamstrings':
      case 'calves':
      case 'glutes':
      case 'abductors':
      case 'adductors':
        return 'Piernas';
      case 'shoulders':
        return 'Hombros';
      case 'biceps':
        return 'Bíceps';
      case 'triceps':
        return 'Tríceps';
      case 'abs':
        return 'Core';
      case 'cardio':
        return 'Cardio';
      case 'forearms':
        return 'Antebrazos';
      case 'neck':
        return 'Cuello';
      default:
        return rawGroup;
    }
  }

  Future<void> _seedDefaultTemplates() async {
    final templates = [
      const _SeedTemplate(
        id: 'template_domingo',
        name: 'Domingo',
        description: 'Domingo de Pierna',
        dayOfWeek: 7,
        exercises: [
          _SeedExercise(1, 'Sentadilla (Barra Alta)', 'Piernas', [
            _SeedSet(1, 80.0, 10),
            _SeedSet(2, 85.0, 10),
            _SeedSet(3, 90.0, 8),
            _SeedSet(4, 90.0, 8),
          ]),
          _SeedExercise(2, 'Prensa a 45°', 'Piernas', [
            _SeedSet(1, 120.0, 10),
            _SeedSet(2, 140.0, 10),
            _SeedSet(3, 160.0, 10),
          ]),
          _SeedExercise(4312, 'Bulgarian Split Squat', 'Piernas', [
            _SeedSet(1, 20.0, 12),
            _SeedSet(2, 20.0, 12),
            _SeedSet(3, 20.0, 12),
          ]),
          _SeedExercise(1933, 'Standing Calf Raise', 'Piernas', [
            _SeedSet(1, 50.0, 15),
            _SeedSet(2, 50.0, 15),
            _SeedSet(3, 50.0, 15),
            _SeedSet(4, 50.0, 15),
          ]),
        ],
      ),
      const _SeedTemplate(
        id: 'template_traccion',
        name: 'Sábado de Tracción 🦍',
        description: 'Tirón / Tracción',
        dayOfWeek: 6,
        exercises: [
          _SeedExercise(201, 'Jalón Al Pecho Agarre Prono (Máquina)', 'Espalda', [
            _SeedSet(1, 60.0, 10),
            _SeedSet(2, 65.0, 10),
            _SeedSet(3, 70.0, 8),
          ]),
          _SeedExercise(202, 'Remo Sentado En Polea', 'Espalda', [
            _SeedSet(1, 55.0, 10),
            _SeedSet(2, 60.0, 10),
            _SeedSet(3, 65.0, 10),
          ]),
          _SeedExercise(1901, 'Inverted Row', 'Espalda', [
            _SeedSet(1, 0.0, 12),
            _SeedSet(2, 0.0, 12),
            _SeedSet(3, 0.0, 12),
          ]),
          _SeedExercise(26, 'Curl De Bíceps Inclinado (Mancuerna)', 'Bíceps', [
            _SeedSet(1, 12.0, 10),
            _SeedSet(2, 14.0, 10),
            _SeedSet(3, 14.0, 10),
          ]),
        ],
      ),
      const _SeedTemplate(
        id: 'template_empuje',
        name: 'Sábado de Empuje 🫣',
        description: 'Empuje',
        dayOfWeek: 6,
        exercises: [
          _SeedExercise(102, 'Press De Banca Inclinado (Barra Recta)', 'Pecho', [
            _SeedSet(1, 60.0, 10),
            _SeedSet(2, 65.0, 10),
            _SeedSet(3, 70.0, 8),
          ]),
          _SeedExercise(104, 'Press De Hombros Sentado (Mancuerna)', 'Hombros', [
            _SeedSet(1, 20.0, 10),
            _SeedSet(2, 22.0, 10),
            _SeedSet(3, 24.0, 8),
          ]),
          _SeedExercise(105, 'Elevaciones Laterales (Mancuerna)', 'Hombros', [
            _SeedSet(1, 10.0, 12),
            _SeedSet(2, 12.0, 12),
            _SeedSet(3, 12.0, 12),
          ]),
          _SeedExercise(108, 'Fondos En Paralelas (Tríceps)', 'Tríceps', [
            _SeedSet(1, 0.0, 10),
            _SeedSet(2, 0.0, 10),
            _SeedSet(3, 0.0, 10),
          ]),
        ],
      ),
      const _SeedTemplate(
        id: 'template_pecho_triceps',
        name: 'Pecho, Triceps',
        description: 'Pecho y Tríceps',
        dayOfWeek: 1,
        exercises: [
          _SeedExercise(107, 'Press De Banca Plano (Mancuerna)', 'Pecho', [
            _SeedSet(1, 26.0, 10),
            _SeedSet(2, 28.0, 10),
            _SeedSet(3, 30.0, 8),
            _SeedSet(4, 30.0, 8),
          ]),
          _SeedExercise(103, 'Aperturas En Polea Alta (Cable)', 'Pecho', [
            _SeedSet(1, 15.0, 12),
            _SeedSet(2, 15.0, 12),
            _SeedSet(3, 15.0, 12),
          ]),
          _SeedExercise(27, 'Extensión De Tríceps (Cuerda)', 'Tríceps', [
            _SeedSet(1, 25.0, 12),
            _SeedSet(2, 25.0, 12),
            _SeedSet(3, 25.0, 12),
          ]),
          _SeedExercise(29, 'Extensión De Tríceps Katana (Cuerda)', 'Tríceps', [
            _SeedSet(1, 15.0, 12),
            _SeedSet(2, 20.0, 12),
            _SeedSet(3, 20.0, 10),
          ]),
        ],
      ),
      const _SeedTemplate(
        id: 'template_espalda_biceps',
        name: 'Espalda, Biceps',
        description: 'Espalda y Bíceps',
        dayOfWeek: 2,
        exercises: [
          _SeedExercise(203, 'Jalón Al Pecho Agarre Supino', 'Espalda', [
            _SeedSet(1, 65.0, 10),
            _SeedSet(2, 70.0, 10),
            _SeedSet(3, 75.0, 8),
            _SeedSet(4, 75.0, 8),
          ]),
          _SeedExercise(204, 'Remo Con Mancuerna', 'Espalda', [
            _SeedSet(1, 28.0, 10),
            _SeedSet(2, 30.0, 10),
            _SeedSet(3, 32.0, 8),
          ]),
          _SeedExercise(25, 'Curl Martillo Bilateral (Mancuerna)', 'Bíceps', [
            _SeedSet(1, 14.0, 12),
            _SeedSet(2, 16.0, 10),
            _SeedSet(3, 16.0, 10),
          ]),
          _SeedExercise(1804, 'Curl Predicador (Máquina)', 'Bíceps', [
            _SeedSet(1, 30.0, 10),
            _SeedSet(2, 35.0, 10),
            _SeedSet(3, 35.0, 10),
          ]),
        ],
      ),
      const _SeedTemplate(
        id: 'template_piernas_hombros',
        name: 'Piernas, Hombros',
        description: 'Piernas y Hombros',
        dayOfWeek: 3,
        exercises: [
          _SeedExercise(2, 'Prensa a 45°', 'Piernas', [
            _SeedSet(1, 140.0, 10),
            _SeedSet(2, 160.0, 10),
            _SeedSet(3, 180.0, 8),
            _SeedSet(4, 180.0, 8),
          ]),
          _SeedExercise(1896, 'Single Leg Romanian Deadlift', 'Piernas', [
            _SeedSet(1, 20.0, 10),
            _SeedSet(2, 24.0, 10),
            _SeedSet(3, 24.0, 10),
          ]),
          _SeedExercise(109, 'Press Militar De Pie (Barra)', 'Hombros', [
            _SeedSet(1, 40.0, 8),
            _SeedSet(2, 45.0, 8),
            _SeedSet(3, 45.0, 8),
          ]),
          _SeedExercise(105, 'Elevaciones Laterales (Mancuerna)', 'Hombros', [
            _SeedSet(1, 10.0, 12),
            _SeedSet(2, 12.0, 12),
            _SeedSet(3, 12.0, 12),
          ]),
        ],
      ),
    ];

    for (final t in templates) {
      await db.into(db.trainingSessionsTable).insert(
            TrainingSessionsTableCompanion.insert(
              id: t.id,
              planId: 'library_templates',
              name: t.name,
              description: t.description,
              dayOfWeek: t.dayOfWeek,
              isCompleted: const Value(false),
            ),
          );

      for (var i = 0; i < t.exercises.length; i++) {
        final ex = t.exercises[i];
        final entryId = await db.into(db.exerciseEntriesTable).insert(
              ExerciseEntriesTableCompanion.insert(
                sessionId: t.id,
                exerciseTemplateId: ex.id,
                exerciseName: ex.name,
                muscleGroup: ex.muscleGroup,
                orderIndex: i,
              ),
            );

        for (final s in ex.sets) {
          await db.into(db.exerciseSetsTable).insert(
                ExerciseSetsTableCompanion.insert(
                  exerciseEntryId: entryId,
                  setNumber: s.setNumber,
                  weightKg: s.weightKg,
                  reps: s.reps,
                  isCompleted: const Value(false),
                ),
              );
        }
      }
    }
  }

  String _inferMuscleGroup(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('squat') ||
        lower.contains('sentadilla') ||
        lower.contains('prensa') ||
        lower.contains('quad') ||
        lower.contains('pierna') ||
        lower.contains('femoral') ||
        lower.contains('isquio') ||
        lower.contains('glute') ||
        lower.contains('calf') ||
        lower.contains('gemelo') ||
        lower.contains('bulgarian') ||
        lower.contains('búlgara') ||
        lower.contains('zancada') ||
        lower.contains('deadlift') ||
        lower.contains('muerto')) {
      return 'Piernas';
    } else if (lower.contains('press') ||
        lower.contains('push') ||
        lower.contains('pecho') ||
        lower.contains('chest') ||
        lower.contains('banca') ||
        lower.contains('inclinado') ||
        lower.contains('apertura') ||
        lower.contains('cruce')) {
      return 'Pecho';
    } else if (lower.contains('row') ||
        lower.contains('remo') ||
        lower.contains('jalon') ||
        lower.contains('jalón') ||
        lower.contains('espalda') ||
        lower.contains('pull') ||
        lower.contains('lat') ||
        lower.contains('dominada') ||
        lower.contains('trapecio') ||
        lower.contains('dorsal')) {
      return 'Espalda';
    } else if (lower.contains('hombro') ||
        lower.contains('shoulder') ||
        lower.contains('militar') ||
        lower.contains('lateral') ||
        lower.contains('elevacion') ||
        lower.contains('elevación') ||
        lower.contains('deltoid') ||
        lower.contains('pájaro') ||
        lower.contains('pajaro') ||
        lower.contains('facepull')) {
      return 'Hombros';
    } else if (lower.contains('tricep') ||
        lower.contains('trícep') ||
        lower.contains('fondo') ||
        lower.contains('dip') ||
        lower.contains('katana') ||
        lower.contains('cuerda') ||
        lower.contains('pushdown') ||
        lower.contains('frances') ||
        lower.contains('francés')) {
      return 'Tríceps';
    } else if (lower.contains('curl') ||
        lower.contains('bicep') ||
        lower.contains('bícep') ||
        lower.contains('martillo') ||
        lower.contains('predicador')) {
      return 'Bíceps';
    } else if (lower.contains('plank') ||
        lower.contains('plancha') ||
        lower.contains('crunch') ||
        lower.contains('core') ||
        lower.contains('abs') ||
        lower.contains('abdomen') ||
        lower.contains('abdominal')) {
      return 'Core';
    } else if (lower.contains('cinta') ||
        lower.contains('correr') ||
        lower.contains('cardio') ||
        lower.contains('andar') ||
        lower.contains('treadmill')) {
      return 'Cardio';
    }
    return 'Espalda'; // Sensible default for pull/back movements if unmatched
  }

  List<WorkoutPlanModel> _getFallbackPlans() {
    return const [
      WorkoutPlanModel(
        planId: 'v2:fullbody_beginner',
        name: 'Cuerpo Completo · 3 Días (Symmetry)',
        description:
            'Symmetry foundational 3-day full body hypertrophy & strength program.',
        ruleset: 'hypertrophy',
        equipmentCategory: 'gym',
        level: 'beginner',
        durationPerSession: 45,
        trainingSessions: [
          TrainingSessionModel(
            dayOfWeek: 1,
            name: 'Full Body A - Strength Focus',
            description:
                'Compound movements focusing on chest, quads, and back.',
            exercises: [
              ExerciseModel(
                  exerciseTemplateId: 1, name: 'Barbell High Bar Squat'),
              ExerciseModel(
                  exerciseTemplateId: 740, name: 'Push Up / Bench Press'),
              ExerciseModel(exerciseTemplateId: 1901, name: 'Inverted Row'),
            ],
          ),
          TrainingSessionModel(
            dayOfWeek: 3,
            name: 'Full Body B - Posterior & Shoulders',
            description: 'Focus on hamstrings, shoulders, and triceps.',
            exercises: [
              ExerciseModel(
                  exerciseTemplateId: 1834,
                  name: 'Pike Push Up / Overhead Press'),
              ExerciseModel(
                  exerciseTemplateId: 1896, name: 'Romanian Deadlift'),
              ExerciseModel(
                  exerciseTemplateId: 27, name: 'Triceps Extension'),
            ],
          ),
          TrainingSessionModel(
            dayOfWeek: 5,
            name: 'Full Body C - Hypertrophy Finish',
            description: 'Arms, chest, and core conditioning.',
            exercises: [
              ExerciseModel(
                  exerciseTemplateId: 4312, name: 'Bulgarian Split Squat'),
              ExerciseModel(exerciseTemplateId: 25, name: 'Hammer Curl'),
              ExerciseModel(exerciseTemplateId: 3421, name: 'Bicycle Crunch'),
            ],
          ),
        ],
      )
    ];
  }
}

class _SeedTemplate {
  final String id;
  final String name;
  final String description;
  final int dayOfWeek;
  final List<_SeedExercise> exercises;

  const _SeedTemplate({
    required this.id,
    required this.name,
    required this.description,
    required this.dayOfWeek,
    required this.exercises,
  });
}

class _SeedExercise {
  final int id;
  final String name;
  final String muscleGroup;
  final List<_SeedSet> sets;

  const _SeedExercise(this.id, this.name, this.muscleGroup, this.sets);
}

class _SeedSet {
  final int setNumber;
  final double weightKg;
  final int reps;

  const _SeedSet(this.setNumber, this.weightKg, this.reps);
}
