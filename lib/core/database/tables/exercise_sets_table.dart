import 'package:drift/drift.dart';

@DataClassName('ExerciseSetRow')
class ExerciseSetsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exerciseEntryId => integer()();
  IntColumn get setNumber => integer()();
  RealColumn get weightKg => real()();
  IntColumn get reps => integer()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(true))();
  RealColumn get rpe => real().nullable()();
}
