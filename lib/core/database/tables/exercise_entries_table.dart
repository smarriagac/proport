import 'package:drift/drift.dart';

@DataClassName('ExerciseEntryRow')
class ExerciseEntriesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId => text()();
  IntColumn get exerciseTemplateId => integer()();
  TextColumn get exerciseName => text()();
  TextColumn get muscleGroup => text()();
  IntColumn get orderIndex => integer()();
}
