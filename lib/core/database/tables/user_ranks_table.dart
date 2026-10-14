import 'package:drift/drift.dart';

@DataClassName('UserRankRow')
class UserRanksTable extends Table {
  TextColumn get muscleGroup => text()();
  TextColumn get currentRank => text()();
  IntColumn get tierLevel => integer()();
  RealColumn get estimated1Rm => real()();
  RealColumn get percentile => real()();
  DateTimeColumn get lastTrained => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {muscleGroup};
}
