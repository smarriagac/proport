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
  Future<void> saveCompletedSession(TrainingSessionModel session);
  Future<List<TrainingSessionModel>> getCompletedSessions();
}

class TrainingLocalDataSourceImpl implements TrainingLocalDataSource {
  final AppDatabase db;
  List<WorkoutPlanModel>? _cachedPlans;
  Map<int, String>? _exerciseNameMap;

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
  Future<List<ExerciseModel>> getExerciseCatalog() async {
    final names = await getExerciseNameMap();
    return names.entries.map((entry) {
      return ExerciseModel(
        exerciseTemplateId: entry.key,
        name: entry.value,
        muscleGroup: _inferMuscleGroup(entry.value),
      );
    }).toList();
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

  String _inferMuscleGroup(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('squat') ||
        lower.contains('sentadilla') ||
        lower.contains('prensa') ||
        lower.contains('quad')) {
      return 'Quads';
    } else if (lower.contains('deadlift') ||
        lower.contains('muerto') ||
        lower.contains('curl femoral') ||
        lower.contains('glute')) {
      return 'Hamstrings & Glutes';
    } else if (lower.contains('press') ||
        lower.contains('push') ||
        lower.contains('pecho') ||
        lower.contains('banco')) {
      return 'Chest';
    } else if (lower.contains('row') ||
        lower.contains('remo') ||
        lower.contains('jalon') ||
        lower.contains('espalda')) {
      return 'Back';
    } else if (lower.contains('curl') ||
        lower.contains('tricep') ||
        lower.contains('katana') ||
        lower.contains('bicep')) {
      return 'Arms';
    } else if (lower.contains('pike') ||
        lower.contains('deltoid') ||
        lower.contains('militar') ||
        lower.contains('hombro')) {
      return 'Shoulders';
    }
    return 'Core & Other';
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
