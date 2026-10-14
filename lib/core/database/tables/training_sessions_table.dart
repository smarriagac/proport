import 'package:drift/drift.dart';

@DataClassName('TrainingSessionRow')
class TrainingSessionsTable extends Table {
  TextColumn get id => text()();
  TextColumn get planId => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  IntColumn get dayOfWeek => integer()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
