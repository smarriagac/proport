import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/workout_plans_table.dart';
import 'tables/training_sessions_table.dart';
import 'tables/exercise_entries_table.dart';
import 'tables/exercise_sets_table.dart';
import 'tables/user_ranks_table.dart';
import 'tables/weight_entries_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  WorkoutPlansTable,
  TrainingSessionsTable,
  ExerciseEntriesTable,
  ExerciseSetsTable,
  UserRanksTable,
  WeightEntriesTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  static QueryExecutor _openConnection() => driftDatabase(name: 'symmetry_app_db');

  @override
  int get schemaVersion => 1;
}
