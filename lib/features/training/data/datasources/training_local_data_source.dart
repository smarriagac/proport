import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/workout_plan_model.dart';
import '../models/training_session_model.dart';
import '../models/exercise_model.dart';

abstract class TrainingLocalDataSource {
  Future<List<WorkoutPlanModel>> getWorkoutPlans();
  Future<Map<int, String>> getExerciseNameMap();
  Future<List<ExerciseModel>> getExerciseCatalog();
  Future<void> saveCompletedSession(TrainingSessionModel session);
  Future<List<TrainingSessionModel>> getCompletedSessions();
}

class TrainingLocalDataSourceImpl implements TrainingLocalDataSource {
  List<WorkoutPlanModel>? _cachedPlans;
  Map<int, String>? _exerciseNameMap;
  final List<TrainingSessionModel> _completedSessions = [];

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
      final jsonStr = await rootBundle.loadString(AppAssets.exerciseRankingMockJson);
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

    try {
      final jsonStr = await rootBundle.loadString(AppAssets.predefinedPlansExampleJson);
      final rawList = jsonDecode(jsonStr) as List<dynamic>;
      final plans = rawList
          .map((item) => WorkoutPlanModel.fromJson(item as Map<String, dynamic>))
          .toList();
      _cachedPlans = plans;
      return plans;
    } catch (e) {
      // Fallback default plan in case of json parse issues
      final fallback = [
        const WorkoutPlanModel(
          planId: 'v2:fullbody_beginner',
          name: 'Cuerpo Completo · 3 Días (Symmetry)',
          description: 'Symmetry foundational 3-day full body hypertrophy & strength program.',
          ruleset: 'hypertrophy',
          equipmentCategory: 'gym',
          level: 'beginner',
          durationPerSession: 45,
          trainingSessions: [
            TrainingSessionModel(
              dayOfWeek: 1,
              name: 'Full Body A - Strength Focus',
              description: 'Compound movements focusing on chest, quads, and back.',
              exercises: [
                ExerciseModel(exerciseTemplateId: 1, name: 'Barbell High Bar Squat'),
                ExerciseModel(exerciseTemplateId: 740, name: 'Push Up / Bench Press'),
                ExerciseModel(exerciseTemplateId: 1901, name: 'Inverted Row'),
              ],
            ),
            TrainingSessionModel(
              dayOfWeek: 3,
              name: 'Full Body B - Posterior & Shoulders',
              description: 'Focus on hamstrings, shoulders, and triceps.',
              exercises: [
                ExerciseModel(exerciseTemplateId: 1834, name: 'Pike Push Up / Overhead Press'),
                ExerciseModel(exerciseTemplateId: 1896, name: 'Romanian Deadlift'),
                ExerciseModel(exerciseTemplateId: 27, name: 'Triceps Extension'),
              ],
            ),
            TrainingSessionModel(
              dayOfWeek: 5,
              name: 'Full Body C - Hypertrophy Finish',
              description: 'Arms, chest, and core conditioning.',
              exercises: [
                ExerciseModel(exerciseTemplateId: 4312, name: 'Bulgarian Split Squat'),
                ExerciseModel(exerciseTemplateId: 25, name: 'Hammer Curl'),
                ExerciseModel(exerciseTemplateId: 3421, name: 'Bicycle Crunch'),
              ],
            ),
          ],
        )
      ];
      _cachedPlans = fallback;
      return fallback;
    }
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
    _completedSessions.add(session);
  }

  @override
  Future<List<TrainingSessionModel>> getCompletedSessions() async {
    return List.unmodifiable(_completedSessions);
  }

  String _inferMuscleGroup(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('squat') || lower.contains('sentadilla') || lower.contains('prensa') || lower.contains('quad')) {
      return 'Quads';
    } else if (lower.contains('deadlift') || lower.contains('muerto') || lower.contains('curl femoral') || lower.contains('glute')) {
      return 'Hamstrings & Glutes';
    } else if (lower.contains('press') || lower.contains('push') || lower.contains('pecho') || lower.contains('banco')) {
      return 'Chest';
    } else if (lower.contains('row') || lower.contains('remo') || lower.contains('jalon') || lower.contains('espalda')) {
      return 'Back';
    } else if (lower.contains('curl') || lower.contains('tricep') || lower.contains('katana') || lower.contains('bicep')) {
      return 'Arms';
    } else if (lower.contains('pike') || lower.contains('deltoid') || lower.contains('militar') || lower.contains('hombro')) {
      return 'Shoulders';
    }
    return 'Core & Other';
  }
}
