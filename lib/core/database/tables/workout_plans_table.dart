import 'package:drift/drift.dart';

@DataClassName('WorkoutPlanRow')
class WorkoutPlansTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get ruleset => text()();
  TextColumn get equipmentCategory => text()();
  TextColumn get level => text()();
  IntColumn get durationPerSession => integer()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
