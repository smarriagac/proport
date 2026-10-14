import 'package:drift/drift.dart';

@DataClassName('WeightEntryRow')
class WeightEntriesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get weightKg => real()();
  DateTimeColumn get recordedAt => dateTime()();
  TextColumn get note => text().nullable()();
}
