// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WorkoutPlansTableTable extends WorkoutPlansTable
    with TableInfo<$WorkoutPlansTableTable, WorkoutPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutPlansTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rulesetMeta = const VerificationMeta(
    'ruleset',
  );
  @override
  late final GeneratedColumn<String> ruleset = GeneratedColumn<String>(
    'ruleset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipmentCategoryMeta = const VerificationMeta(
    'equipmentCategory',
  );
  @override
  late final GeneratedColumn<String> equipmentCategory =
      GeneratedColumn<String>(
        'equipment_category',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationPerSessionMeta =
      const VerificationMeta('durationPerSession');
  @override
  late final GeneratedColumn<int> durationPerSession = GeneratedColumn<int>(
    'duration_per_session',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    ruleset,
    equipmentCategory,
    level,
    durationPerSession,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_plans_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutPlanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('ruleset')) {
      context.handle(
        _rulesetMeta,
        ruleset.isAcceptableOrUnknown(data['ruleset']!, _rulesetMeta),
      );
    } else if (isInserting) {
      context.missing(_rulesetMeta);
    }
    if (data.containsKey('equipment_category')) {
      context.handle(
        _equipmentCategoryMeta,
        equipmentCategory.isAcceptableOrUnknown(
          data['equipment_category']!,
          _equipmentCategoryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_equipmentCategoryMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('duration_per_session')) {
      context.handle(
        _durationPerSessionMeta,
        durationPerSession.isAcceptableOrUnknown(
          data['duration_per_session']!,
          _durationPerSessionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationPerSessionMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutPlanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      ruleset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ruleset'],
      )!,
      equipmentCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment_category'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      )!,
      durationPerSession: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_per_session'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $WorkoutPlansTableTable createAlias(String alias) {
    return $WorkoutPlansTableTable(attachedDatabase, alias);
  }
}

class WorkoutPlanRow extends DataClass implements Insertable<WorkoutPlanRow> {
  final String id;
  final String name;
  final String description;
  final String ruleset;
  final String equipmentCategory;
  final String level;
  final int durationPerSession;
  final bool isActive;
  const WorkoutPlanRow({
    required this.id,
    required this.name,
    required this.description,
    required this.ruleset,
    required this.equipmentCategory,
    required this.level,
    required this.durationPerSession,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['ruleset'] = Variable<String>(ruleset);
    map['equipment_category'] = Variable<String>(equipmentCategory);
    map['level'] = Variable<String>(level);
    map['duration_per_session'] = Variable<int>(durationPerSession);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  WorkoutPlansTableCompanion toCompanion(bool nullToAbsent) {
    return WorkoutPlansTableCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      ruleset: Value(ruleset),
      equipmentCategory: Value(equipmentCategory),
      level: Value(level),
      durationPerSession: Value(durationPerSession),
      isActive: Value(isActive),
    );
  }

  factory WorkoutPlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutPlanRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      ruleset: serializer.fromJson<String>(json['ruleset']),
      equipmentCategory: serializer.fromJson<String>(json['equipmentCategory']),
      level: serializer.fromJson<String>(json['level']),
      durationPerSession: serializer.fromJson<int>(json['durationPerSession']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'ruleset': serializer.toJson<String>(ruleset),
      'equipmentCategory': serializer.toJson<String>(equipmentCategory),
      'level': serializer.toJson<String>(level),
      'durationPerSession': serializer.toJson<int>(durationPerSession),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  WorkoutPlanRow copyWith({
    String? id,
    String? name,
    String? description,
    String? ruleset,
    String? equipmentCategory,
    String? level,
    int? durationPerSession,
    bool? isActive,
  }) => WorkoutPlanRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    ruleset: ruleset ?? this.ruleset,
    equipmentCategory: equipmentCategory ?? this.equipmentCategory,
    level: level ?? this.level,
    durationPerSession: durationPerSession ?? this.durationPerSession,
    isActive: isActive ?? this.isActive,
  );
  WorkoutPlanRow copyWithCompanion(WorkoutPlansTableCompanion data) {
    return WorkoutPlanRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      ruleset: data.ruleset.present ? data.ruleset.value : this.ruleset,
      equipmentCategory: data.equipmentCategory.present
          ? data.equipmentCategory.value
          : this.equipmentCategory,
      level: data.level.present ? data.level.value : this.level,
      durationPerSession: data.durationPerSession.present
          ? data.durationPerSession.value
          : this.durationPerSession,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutPlanRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('ruleset: $ruleset, ')
          ..write('equipmentCategory: $equipmentCategory, ')
          ..write('level: $level, ')
          ..write('durationPerSession: $durationPerSession, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    ruleset,
    equipmentCategory,
    level,
    durationPerSession,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutPlanRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.ruleset == this.ruleset &&
          other.equipmentCategory == this.equipmentCategory &&
          other.level == this.level &&
          other.durationPerSession == this.durationPerSession &&
          other.isActive == this.isActive);
}

class WorkoutPlansTableCompanion extends UpdateCompanion<WorkoutPlanRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> ruleset;
  final Value<String> equipmentCategory;
  final Value<String> level;
  final Value<int> durationPerSession;
  final Value<bool> isActive;
  final Value<int> rowid;
  const WorkoutPlansTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.ruleset = const Value.absent(),
    this.equipmentCategory = const Value.absent(),
    this.level = const Value.absent(),
    this.durationPerSession = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutPlansTableCompanion.insert({
    required String id,
    required String name,
    required String description,
    required String ruleset,
    required String equipmentCategory,
    required String level,
    required int durationPerSession,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       description = Value(description),
       ruleset = Value(ruleset),
       equipmentCategory = Value(equipmentCategory),
       level = Value(level),
       durationPerSession = Value(durationPerSession);
  static Insertable<WorkoutPlanRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? ruleset,
    Expression<String>? equipmentCategory,
    Expression<String>? level,
    Expression<int>? durationPerSession,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (ruleset != null) 'ruleset': ruleset,
      if (equipmentCategory != null) 'equipment_category': equipmentCategory,
      if (level != null) 'level': level,
      if (durationPerSession != null)
        'duration_per_session': durationPerSession,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutPlansTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? ruleset,
    Value<String>? equipmentCategory,
    Value<String>? level,
    Value<int>? durationPerSession,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return WorkoutPlansTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      ruleset: ruleset ?? this.ruleset,
      equipmentCategory: equipmentCategory ?? this.equipmentCategory,
      level: level ?? this.level,
      durationPerSession: durationPerSession ?? this.durationPerSession,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (ruleset.present) {
      map['ruleset'] = Variable<String>(ruleset.value);
    }
    if (equipmentCategory.present) {
      map['equipment_category'] = Variable<String>(equipmentCategory.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (durationPerSession.present) {
      map['duration_per_session'] = Variable<int>(durationPerSession.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutPlansTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('ruleset: $ruleset, ')
          ..write('equipmentCategory: $equipmentCategory, ')
          ..write('level: $level, ')
          ..write('durationPerSession: $durationPerSession, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrainingSessionsTableTable extends TrainingSessionsTable
    with TableInfo<$TrainingSessionsTableTable, TrainingSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrainingSessionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayOfWeekMeta = const VerificationMeta(
    'dayOfWeek',
  );
  @override
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
    'day_of_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planId,
    name,
    description,
    dayOfWeek,
    isCompleted,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'training_sessions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrainingSessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
        _dayOfWeekMeta,
        dayOfWeek.isAcceptableOrUnknown(data['day_of_week']!, _dayOfWeekMeta),
      );
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrainingSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrainingSessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      dayOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_week'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $TrainingSessionsTableTable createAlias(String alias) {
    return $TrainingSessionsTableTable(attachedDatabase, alias);
  }
}

class TrainingSessionRow extends DataClass
    implements Insertable<TrainingSessionRow> {
  final String id;
  final String planId;
  final String name;
  final String description;
  final int dayOfWeek;
  final bool isCompleted;
  final DateTime? completedAt;
  const TrainingSessionRow({
    required this.id,
    required this.planId,
    required this.name,
    required this.description,
    required this.dayOfWeek,
    required this.isCompleted,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['day_of_week'] = Variable<int>(dayOfWeek);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  TrainingSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return TrainingSessionsTableCompanion(
      id: Value(id),
      planId: Value(planId),
      name: Value(name),
      description: Value(description),
      dayOfWeek: Value(dayOfWeek),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory TrainingSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrainingSessionRow(
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      dayOfWeek: serializer.fromJson<int>(json['dayOfWeek']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'dayOfWeek': serializer.toJson<int>(dayOfWeek),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  TrainingSessionRow copyWith({
    String? id,
    String? planId,
    String? name,
    String? description,
    int? dayOfWeek,
    bool? isCompleted,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => TrainingSessionRow(
    id: id ?? this.id,
    planId: planId ?? this.planId,
    name: name ?? this.name,
    description: description ?? this.description,
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  TrainingSessionRow copyWithCompanion(TrainingSessionsTableCompanion data) {
    return TrainingSessionRow(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrainingSessionRow(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    planId,
    name,
    description,
    dayOfWeek,
    isCompleted,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrainingSessionRow &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.name == this.name &&
          other.description == this.description &&
          other.dayOfWeek == this.dayOfWeek &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt);
}

class TrainingSessionsTableCompanion
    extends UpdateCompanion<TrainingSessionRow> {
  final Value<String> id;
  final Value<String> planId;
  final Value<String> name;
  final Value<String> description;
  final Value<int> dayOfWeek;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const TrainingSessionsTableCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrainingSessionsTableCompanion.insert({
    required String id,
    required String planId,
    required String name,
    required String description,
    required int dayOfWeek,
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       planId = Value(planId),
       name = Value(name),
       description = Value(description),
       dayOfWeek = Value(dayOfWeek);
  static Insertable<TrainingSessionRow> custom({
    Expression<String>? id,
    Expression<String>? planId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? dayOfWeek,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrainingSessionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? planId,
    Value<String>? name,
    Value<String>? description,
    Value<int>? dayOfWeek,
    Value<bool>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return TrainingSessionsTableCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      name: name ?? this.name,
      description: description ?? this.description,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainingSessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseEntriesTableTable extends ExerciseEntriesTable
    with TableInfo<$ExerciseEntriesTableTable, ExerciseEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseTemplateIdMeta =
      const VerificationMeta('exerciseTemplateId');
  @override
  late final GeneratedColumn<int> exerciseTemplateId = GeneratedColumn<int>(
    'exercise_template_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseNameMeta = const VerificationMeta(
    'exerciseName',
  );
  @override
  late final GeneratedColumn<String> exerciseName = GeneratedColumn<String>(
    'exercise_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _muscleGroupMeta = const VerificationMeta(
    'muscleGroup',
  );
  @override
  late final GeneratedColumn<String> muscleGroup = GeneratedColumn<String>(
    'muscle_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    exerciseTemplateId,
    exerciseName,
    muscleGroup,
    orderIndex,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_entries_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('exercise_template_id')) {
      context.handle(
        _exerciseTemplateIdMeta,
        exerciseTemplateId.isAcceptableOrUnknown(
          data['exercise_template_id']!,
          _exerciseTemplateIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseTemplateIdMeta);
    }
    if (data.containsKey('exercise_name')) {
      context.handle(
        _exerciseNameMeta,
        exerciseName.isAcceptableOrUnknown(
          data['exercise_name']!,
          _exerciseNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseNameMeta);
    }
    if (data.containsKey('muscle_group')) {
      context.handle(
        _muscleGroupMeta,
        muscleGroup.isAcceptableOrUnknown(
          data['muscle_group']!,
          _muscleGroupMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_muscleGroupMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      exerciseTemplateId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_template_id'],
      )!,
      exerciseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_name'],
      )!,
      muscleGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_group'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
    );
  }

  @override
  $ExerciseEntriesTableTable createAlias(String alias) {
    return $ExerciseEntriesTableTable(attachedDatabase, alias);
  }
}

class ExerciseEntryRow extends DataClass
    implements Insertable<ExerciseEntryRow> {
  final int id;
  final String sessionId;
  final int exerciseTemplateId;
  final String exerciseName;
  final String muscleGroup;
  final int orderIndex;
  const ExerciseEntryRow({
    required this.id,
    required this.sessionId,
    required this.exerciseTemplateId,
    required this.exerciseName,
    required this.muscleGroup,
    required this.orderIndex,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['exercise_template_id'] = Variable<int>(exerciseTemplateId);
    map['exercise_name'] = Variable<String>(exerciseName);
    map['muscle_group'] = Variable<String>(muscleGroup);
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  ExerciseEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return ExerciseEntriesTableCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      exerciseTemplateId: Value(exerciseTemplateId),
      exerciseName: Value(exerciseName),
      muscleGroup: Value(muscleGroup),
      orderIndex: Value(orderIndex),
    );
  }

  factory ExerciseEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseEntryRow(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      exerciseTemplateId: serializer.fromJson<int>(json['exerciseTemplateId']),
      exerciseName: serializer.fromJson<String>(json['exerciseName']),
      muscleGroup: serializer.fromJson<String>(json['muscleGroup']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'exerciseTemplateId': serializer.toJson<int>(exerciseTemplateId),
      'exerciseName': serializer.toJson<String>(exerciseName),
      'muscleGroup': serializer.toJson<String>(muscleGroup),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  ExerciseEntryRow copyWith({
    int? id,
    String? sessionId,
    int? exerciseTemplateId,
    String? exerciseName,
    String? muscleGroup,
    int? orderIndex,
  }) => ExerciseEntryRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    exerciseTemplateId: exerciseTemplateId ?? this.exerciseTemplateId,
    exerciseName: exerciseName ?? this.exerciseName,
    muscleGroup: muscleGroup ?? this.muscleGroup,
    orderIndex: orderIndex ?? this.orderIndex,
  );
  ExerciseEntryRow copyWithCompanion(ExerciseEntriesTableCompanion data) {
    return ExerciseEntryRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      exerciseTemplateId: data.exerciseTemplateId.present
          ? data.exerciseTemplateId.value
          : this.exerciseTemplateId,
      exerciseName: data.exerciseName.present
          ? data.exerciseName.value
          : this.exerciseName,
      muscleGroup: data.muscleGroup.present
          ? data.muscleGroup.value
          : this.muscleGroup,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseEntryRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseTemplateId: $exerciseTemplateId, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    exerciseTemplateId,
    exerciseName,
    muscleGroup,
    orderIndex,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseEntryRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.exerciseTemplateId == this.exerciseTemplateId &&
          other.exerciseName == this.exerciseName &&
          other.muscleGroup == this.muscleGroup &&
          other.orderIndex == this.orderIndex);
}

class ExerciseEntriesTableCompanion extends UpdateCompanion<ExerciseEntryRow> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<int> exerciseTemplateId;
  final Value<String> exerciseName;
  final Value<String> muscleGroup;
  final Value<int> orderIndex;
  const ExerciseEntriesTableCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.exerciseTemplateId = const Value.absent(),
    this.exerciseName = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.orderIndex = const Value.absent(),
  });
  ExerciseEntriesTableCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required int exerciseTemplateId,
    required String exerciseName,
    required String muscleGroup,
    required int orderIndex,
  }) : sessionId = Value(sessionId),
       exerciseTemplateId = Value(exerciseTemplateId),
       exerciseName = Value(exerciseName),
       muscleGroup = Value(muscleGroup),
       orderIndex = Value(orderIndex);
  static Insertable<ExerciseEntryRow> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<int>? exerciseTemplateId,
    Expression<String>? exerciseName,
    Expression<String>? muscleGroup,
    Expression<int>? orderIndex,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (exerciseTemplateId != null)
        'exercise_template_id': exerciseTemplateId,
      if (exerciseName != null) 'exercise_name': exerciseName,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (orderIndex != null) 'order_index': orderIndex,
    });
  }

  ExerciseEntriesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<int>? exerciseTemplateId,
    Value<String>? exerciseName,
    Value<String>? muscleGroup,
    Value<int>? orderIndex,
  }) {
    return ExerciseEntriesTableCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseTemplateId: exerciseTemplateId ?? this.exerciseTemplateId,
      exerciseName: exerciseName ?? this.exerciseName,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (exerciseTemplateId.present) {
      map['exercise_template_id'] = Variable<int>(exerciseTemplateId.value);
    }
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>(muscleGroup.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseEntriesTableCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseTemplateId: $exerciseTemplateId, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }
}

class $ExerciseSetsTableTable extends ExerciseSetsTable
    with TableInfo<$ExerciseSetsTableTable, ExerciseSetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseSetsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseEntryIdMeta = const VerificationMeta(
    'exerciseEntryId',
  );
  @override
  late final GeneratedColumn<int> exerciseEntryId = GeneratedColumn<int>(
    'exercise_entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setNumberMeta = const VerificationMeta(
    'setNumber',
  );
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
    'set_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  @override
  late final GeneratedColumn<double> rpe = GeneratedColumn<double>(
    'rpe',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseEntryId,
    setNumber,
    weightKg,
    reps,
    isCompleted,
    rpe,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_sets_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseSetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_entry_id')) {
      context.handle(
        _exerciseEntryIdMeta,
        exerciseEntryId.isAcceptableOrUnknown(
          data['exercise_entry_id']!,
          _exerciseEntryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseEntryIdMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(
        _setNumberMeta,
        setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('rpe')) {
      context.handle(
        _rpeMeta,
        rpe.isAcceptableOrUnknown(data['rpe']!, _rpeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseSetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseSetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_entry_id'],
      )!,
      setNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_number'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      rpe: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rpe'],
      ),
    );
  }

  @override
  $ExerciseSetsTableTable createAlias(String alias) {
    return $ExerciseSetsTableTable(attachedDatabase, alias);
  }
}

class ExerciseSetRow extends DataClass implements Insertable<ExerciseSetRow> {
  final int id;
  final int exerciseEntryId;
  final int setNumber;
  final double weightKg;
  final int reps;
  final bool isCompleted;
  final double? rpe;
  const ExerciseSetRow({
    required this.id,
    required this.exerciseEntryId,
    required this.setNumber,
    required this.weightKg,
    required this.reps,
    required this.isCompleted,
    this.rpe,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_entry_id'] = Variable<int>(exerciseEntryId);
    map['set_number'] = Variable<int>(setNumber);
    map['weight_kg'] = Variable<double>(weightKg);
    map['reps'] = Variable<int>(reps);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || rpe != null) {
      map['rpe'] = Variable<double>(rpe);
    }
    return map;
  }

  ExerciseSetsTableCompanion toCompanion(bool nullToAbsent) {
    return ExerciseSetsTableCompanion(
      id: Value(id),
      exerciseEntryId: Value(exerciseEntryId),
      setNumber: Value(setNumber),
      weightKg: Value(weightKg),
      reps: Value(reps),
      isCompleted: Value(isCompleted),
      rpe: rpe == null && nullToAbsent ? const Value.absent() : Value(rpe),
    );
  }

  factory ExerciseSetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseSetRow(
      id: serializer.fromJson<int>(json['id']),
      exerciseEntryId: serializer.fromJson<int>(json['exerciseEntryId']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      reps: serializer.fromJson<int>(json['reps']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      rpe: serializer.fromJson<double?>(json['rpe']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseEntryId': serializer.toJson<int>(exerciseEntryId),
      'setNumber': serializer.toJson<int>(setNumber),
      'weightKg': serializer.toJson<double>(weightKg),
      'reps': serializer.toJson<int>(reps),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'rpe': serializer.toJson<double?>(rpe),
    };
  }

  ExerciseSetRow copyWith({
    int? id,
    int? exerciseEntryId,
    int? setNumber,
    double? weightKg,
    int? reps,
    bool? isCompleted,
    Value<double?> rpe = const Value.absent(),
  }) => ExerciseSetRow(
    id: id ?? this.id,
    exerciseEntryId: exerciseEntryId ?? this.exerciseEntryId,
    setNumber: setNumber ?? this.setNumber,
    weightKg: weightKg ?? this.weightKg,
    reps: reps ?? this.reps,
    isCompleted: isCompleted ?? this.isCompleted,
    rpe: rpe.present ? rpe.value : this.rpe,
  );
  ExerciseSetRow copyWithCompanion(ExerciseSetsTableCompanion data) {
    return ExerciseSetRow(
      id: data.id.present ? data.id.value : this.id,
      exerciseEntryId: data.exerciseEntryId.present
          ? data.exerciseEntryId.value
          : this.exerciseEntryId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      reps: data.reps.present ? data.reps.value : this.reps,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      rpe: data.rpe.present ? data.rpe.value : this.rpe,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetRow(')
          ..write('id: $id, ')
          ..write('exerciseEntryId: $exerciseEntryId, ')
          ..write('setNumber: $setNumber, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rpe: $rpe')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    exerciseEntryId,
    setNumber,
    weightKg,
    reps,
    isCompleted,
    rpe,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseSetRow &&
          other.id == this.id &&
          other.exerciseEntryId == this.exerciseEntryId &&
          other.setNumber == this.setNumber &&
          other.weightKg == this.weightKg &&
          other.reps == this.reps &&
          other.isCompleted == this.isCompleted &&
          other.rpe == this.rpe);
}

class ExerciseSetsTableCompanion extends UpdateCompanion<ExerciseSetRow> {
  final Value<int> id;
  final Value<int> exerciseEntryId;
  final Value<int> setNumber;
  final Value<double> weightKg;
  final Value<int> reps;
  final Value<bool> isCompleted;
  final Value<double?> rpe;
  const ExerciseSetsTableCompanion({
    this.id = const Value.absent(),
    this.exerciseEntryId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.reps = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rpe = const Value.absent(),
  });
  ExerciseSetsTableCompanion.insert({
    this.id = const Value.absent(),
    required int exerciseEntryId,
    required int setNumber,
    required double weightKg,
    required int reps,
    this.isCompleted = const Value.absent(),
    this.rpe = const Value.absent(),
  }) : exerciseEntryId = Value(exerciseEntryId),
       setNumber = Value(setNumber),
       weightKg = Value(weightKg),
       reps = Value(reps);
  static Insertable<ExerciseSetRow> custom({
    Expression<int>? id,
    Expression<int>? exerciseEntryId,
    Expression<int>? setNumber,
    Expression<double>? weightKg,
    Expression<int>? reps,
    Expression<bool>? isCompleted,
    Expression<double>? rpe,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseEntryId != null) 'exercise_entry_id': exerciseEntryId,
      if (setNumber != null) 'set_number': setNumber,
      if (weightKg != null) 'weight_kg': weightKg,
      if (reps != null) 'reps': reps,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rpe != null) 'rpe': rpe,
    });
  }

  ExerciseSetsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? exerciseEntryId,
    Value<int>? setNumber,
    Value<double>? weightKg,
    Value<int>? reps,
    Value<bool>? isCompleted,
    Value<double?>? rpe,
  }) {
    return ExerciseSetsTableCompanion(
      id: id ?? this.id,
      exerciseEntryId: exerciseEntryId ?? this.exerciseEntryId,
      setNumber: setNumber ?? this.setNumber,
      weightKg: weightKg ?? this.weightKg,
      reps: reps ?? this.reps,
      isCompleted: isCompleted ?? this.isCompleted,
      rpe: rpe ?? this.rpe,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseEntryId.present) {
      map['exercise_entry_id'] = Variable<int>(exerciseEntryId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rpe.present) {
      map['rpe'] = Variable<double>(rpe.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetsTableCompanion(')
          ..write('id: $id, ')
          ..write('exerciseEntryId: $exerciseEntryId, ')
          ..write('setNumber: $setNumber, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rpe: $rpe')
          ..write(')'))
        .toString();
  }
}

class $UserRanksTableTable extends UserRanksTable
    with TableInfo<$UserRanksTableTable, UserRankRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserRanksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _muscleGroupMeta = const VerificationMeta(
    'muscleGroup',
  );
  @override
  late final GeneratedColumn<String> muscleGroup = GeneratedColumn<String>(
    'muscle_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentRankMeta = const VerificationMeta(
    'currentRank',
  );
  @override
  late final GeneratedColumn<String> currentRank = GeneratedColumn<String>(
    'current_rank',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tierLevelMeta = const VerificationMeta(
    'tierLevel',
  );
  @override
  late final GeneratedColumn<int> tierLevel = GeneratedColumn<int>(
    'tier_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimated1RmMeta = const VerificationMeta(
    'estimated1Rm',
  );
  @override
  late final GeneratedColumn<double> estimated1Rm = GeneratedColumn<double>(
    'estimated1_rm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _percentileMeta = const VerificationMeta(
    'percentile',
  );
  @override
  late final GeneratedColumn<double> percentile = GeneratedColumn<double>(
    'percentile',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastTrainedMeta = const VerificationMeta(
    'lastTrained',
  );
  @override
  late final GeneratedColumn<DateTime> lastTrained = GeneratedColumn<DateTime>(
    'last_trained',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    muscleGroup,
    currentRank,
    tierLevel,
    estimated1Rm,
    percentile,
    lastTrained,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_ranks_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRankRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('muscle_group')) {
      context.handle(
        _muscleGroupMeta,
        muscleGroup.isAcceptableOrUnknown(
          data['muscle_group']!,
          _muscleGroupMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_muscleGroupMeta);
    }
    if (data.containsKey('current_rank')) {
      context.handle(
        _currentRankMeta,
        currentRank.isAcceptableOrUnknown(
          data['current_rank']!,
          _currentRankMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentRankMeta);
    }
    if (data.containsKey('tier_level')) {
      context.handle(
        _tierLevelMeta,
        tierLevel.isAcceptableOrUnknown(data['tier_level']!, _tierLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_tierLevelMeta);
    }
    if (data.containsKey('estimated1_rm')) {
      context.handle(
        _estimated1RmMeta,
        estimated1Rm.isAcceptableOrUnknown(
          data['estimated1_rm']!,
          _estimated1RmMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimated1RmMeta);
    }
    if (data.containsKey('percentile')) {
      context.handle(
        _percentileMeta,
        percentile.isAcceptableOrUnknown(data['percentile']!, _percentileMeta),
      );
    } else if (isInserting) {
      context.missing(_percentileMeta);
    }
    if (data.containsKey('last_trained')) {
      context.handle(
        _lastTrainedMeta,
        lastTrained.isAcceptableOrUnknown(
          data['last_trained']!,
          _lastTrainedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {muscleGroup};
  @override
  UserRankRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRankRow(
      muscleGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_group'],
      )!,
      currentRank: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_rank'],
      )!,
      tierLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tier_level'],
      )!,
      estimated1Rm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated1_rm'],
      )!,
      percentile: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}percentile'],
      )!,
      lastTrained: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_trained'],
      ),
    );
  }

  @override
  $UserRanksTableTable createAlias(String alias) {
    return $UserRanksTableTable(attachedDatabase, alias);
  }
}

class UserRankRow extends DataClass implements Insertable<UserRankRow> {
  final String muscleGroup;
  final String currentRank;
  final int tierLevel;
  final double estimated1Rm;
  final double percentile;
  final DateTime? lastTrained;
  const UserRankRow({
    required this.muscleGroup,
    required this.currentRank,
    required this.tierLevel,
    required this.estimated1Rm,
    required this.percentile,
    this.lastTrained,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['muscle_group'] = Variable<String>(muscleGroup);
    map['current_rank'] = Variable<String>(currentRank);
    map['tier_level'] = Variable<int>(tierLevel);
    map['estimated1_rm'] = Variable<double>(estimated1Rm);
    map['percentile'] = Variable<double>(percentile);
    if (!nullToAbsent || lastTrained != null) {
      map['last_trained'] = Variable<DateTime>(lastTrained);
    }
    return map;
  }

  UserRanksTableCompanion toCompanion(bool nullToAbsent) {
    return UserRanksTableCompanion(
      muscleGroup: Value(muscleGroup),
      currentRank: Value(currentRank),
      tierLevel: Value(tierLevel),
      estimated1Rm: Value(estimated1Rm),
      percentile: Value(percentile),
      lastTrained: lastTrained == null && nullToAbsent
          ? const Value.absent()
          : Value(lastTrained),
    );
  }

  factory UserRankRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRankRow(
      muscleGroup: serializer.fromJson<String>(json['muscleGroup']),
      currentRank: serializer.fromJson<String>(json['currentRank']),
      tierLevel: serializer.fromJson<int>(json['tierLevel']),
      estimated1Rm: serializer.fromJson<double>(json['estimated1Rm']),
      percentile: serializer.fromJson<double>(json['percentile']),
      lastTrained: serializer.fromJson<DateTime?>(json['lastTrained']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'muscleGroup': serializer.toJson<String>(muscleGroup),
      'currentRank': serializer.toJson<String>(currentRank),
      'tierLevel': serializer.toJson<int>(tierLevel),
      'estimated1Rm': serializer.toJson<double>(estimated1Rm),
      'percentile': serializer.toJson<double>(percentile),
      'lastTrained': serializer.toJson<DateTime?>(lastTrained),
    };
  }

  UserRankRow copyWith({
    String? muscleGroup,
    String? currentRank,
    int? tierLevel,
    double? estimated1Rm,
    double? percentile,
    Value<DateTime?> lastTrained = const Value.absent(),
  }) => UserRankRow(
    muscleGroup: muscleGroup ?? this.muscleGroup,
    currentRank: currentRank ?? this.currentRank,
    tierLevel: tierLevel ?? this.tierLevel,
    estimated1Rm: estimated1Rm ?? this.estimated1Rm,
    percentile: percentile ?? this.percentile,
    lastTrained: lastTrained.present ? lastTrained.value : this.lastTrained,
  );
  UserRankRow copyWithCompanion(UserRanksTableCompanion data) {
    return UserRankRow(
      muscleGroup: data.muscleGroup.present
          ? data.muscleGroup.value
          : this.muscleGroup,
      currentRank: data.currentRank.present
          ? data.currentRank.value
          : this.currentRank,
      tierLevel: data.tierLevel.present ? data.tierLevel.value : this.tierLevel,
      estimated1Rm: data.estimated1Rm.present
          ? data.estimated1Rm.value
          : this.estimated1Rm,
      percentile: data.percentile.present
          ? data.percentile.value
          : this.percentile,
      lastTrained: data.lastTrained.present
          ? data.lastTrained.value
          : this.lastTrained,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRankRow(')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('currentRank: $currentRank, ')
          ..write('tierLevel: $tierLevel, ')
          ..write('estimated1Rm: $estimated1Rm, ')
          ..write('percentile: $percentile, ')
          ..write('lastTrained: $lastTrained')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    muscleGroup,
    currentRank,
    tierLevel,
    estimated1Rm,
    percentile,
    lastTrained,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRankRow &&
          other.muscleGroup == this.muscleGroup &&
          other.currentRank == this.currentRank &&
          other.tierLevel == this.tierLevel &&
          other.estimated1Rm == this.estimated1Rm &&
          other.percentile == this.percentile &&
          other.lastTrained == this.lastTrained);
}

class UserRanksTableCompanion extends UpdateCompanion<UserRankRow> {
  final Value<String> muscleGroup;
  final Value<String> currentRank;
  final Value<int> tierLevel;
  final Value<double> estimated1Rm;
  final Value<double> percentile;
  final Value<DateTime?> lastTrained;
  final Value<int> rowid;
  const UserRanksTableCompanion({
    this.muscleGroup = const Value.absent(),
    this.currentRank = const Value.absent(),
    this.tierLevel = const Value.absent(),
    this.estimated1Rm = const Value.absent(),
    this.percentile = const Value.absent(),
    this.lastTrained = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserRanksTableCompanion.insert({
    required String muscleGroup,
    required String currentRank,
    required int tierLevel,
    required double estimated1Rm,
    required double percentile,
    this.lastTrained = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : muscleGroup = Value(muscleGroup),
       currentRank = Value(currentRank),
       tierLevel = Value(tierLevel),
       estimated1Rm = Value(estimated1Rm),
       percentile = Value(percentile);
  static Insertable<UserRankRow> custom({
    Expression<String>? muscleGroup,
    Expression<String>? currentRank,
    Expression<int>? tierLevel,
    Expression<double>? estimated1Rm,
    Expression<double>? percentile,
    Expression<DateTime>? lastTrained,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (currentRank != null) 'current_rank': currentRank,
      if (tierLevel != null) 'tier_level': tierLevel,
      if (estimated1Rm != null) 'estimated1_rm': estimated1Rm,
      if (percentile != null) 'percentile': percentile,
      if (lastTrained != null) 'last_trained': lastTrained,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserRanksTableCompanion copyWith({
    Value<String>? muscleGroup,
    Value<String>? currentRank,
    Value<int>? tierLevel,
    Value<double>? estimated1Rm,
    Value<double>? percentile,
    Value<DateTime?>? lastTrained,
    Value<int>? rowid,
  }) {
    return UserRanksTableCompanion(
      muscleGroup: muscleGroup ?? this.muscleGroup,
      currentRank: currentRank ?? this.currentRank,
      tierLevel: tierLevel ?? this.tierLevel,
      estimated1Rm: estimated1Rm ?? this.estimated1Rm,
      percentile: percentile ?? this.percentile,
      lastTrained: lastTrained ?? this.lastTrained,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>(muscleGroup.value);
    }
    if (currentRank.present) {
      map['current_rank'] = Variable<String>(currentRank.value);
    }
    if (tierLevel.present) {
      map['tier_level'] = Variable<int>(tierLevel.value);
    }
    if (estimated1Rm.present) {
      map['estimated1_rm'] = Variable<double>(estimated1Rm.value);
    }
    if (percentile.present) {
      map['percentile'] = Variable<double>(percentile.value);
    }
    if (lastTrained.present) {
      map['last_trained'] = Variable<DateTime>(lastTrained.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserRanksTableCompanion(')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('currentRank: $currentRank, ')
          ..write('tierLevel: $tierLevel, ')
          ..write('estimated1Rm: $estimated1Rm, ')
          ..write('percentile: $percentile, ')
          ..write('lastTrained: $lastTrained, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeightEntriesTableTable extends WeightEntriesTable
    with TableInfo<$WeightEntriesTableTable, WeightEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, weightKg, recordedAt, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_entries_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeightEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $WeightEntriesTableTable createAlias(String alias) {
    return $WeightEntriesTableTable(attachedDatabase, alias);
  }
}

class WeightEntryRow extends DataClass implements Insertable<WeightEntryRow> {
  final int id;
  final double weightKg;
  final DateTime recordedAt;
  final String? note;
  const WeightEntryRow({
    required this.id,
    required this.weightKg,
    required this.recordedAt,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['weight_kg'] = Variable<double>(weightKg);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  WeightEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return WeightEntriesTableCompanion(
      id: Value(id),
      weightKg: Value(weightKg),
      recordedAt: Value(recordedAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory WeightEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightEntryRow(
      id: serializer.fromJson<int>(json['id']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'weightKg': serializer.toJson<double>(weightKg),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'note': serializer.toJson<String?>(note),
    };
  }

  WeightEntryRow copyWith({
    int? id,
    double? weightKg,
    DateTime? recordedAt,
    Value<String?> note = const Value.absent(),
  }) => WeightEntryRow(
    id: id ?? this.id,
    weightKg: weightKg ?? this.weightKg,
    recordedAt: recordedAt ?? this.recordedAt,
    note: note.present ? note.value : this.note,
  );
  WeightEntryRow copyWithCompanion(WeightEntriesTableCompanion data) {
    return WeightEntryRow(
      id: data.id.present ? data.id.value : this.id,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntryRow(')
          ..write('id: $id, ')
          ..write('weightKg: $weightKg, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, weightKg, recordedAt, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightEntryRow &&
          other.id == this.id &&
          other.weightKg == this.weightKg &&
          other.recordedAt == this.recordedAt &&
          other.note == this.note);
}

class WeightEntriesTableCompanion extends UpdateCompanion<WeightEntryRow> {
  final Value<int> id;
  final Value<double> weightKg;
  final Value<DateTime> recordedAt;
  final Value<String?> note;
  const WeightEntriesTableCompanion({
    this.id = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.note = const Value.absent(),
  });
  WeightEntriesTableCompanion.insert({
    this.id = const Value.absent(),
    required double weightKg,
    required DateTime recordedAt,
    this.note = const Value.absent(),
  }) : weightKg = Value(weightKg),
       recordedAt = Value(recordedAt);
  static Insertable<WeightEntryRow> custom({
    Expression<int>? id,
    Expression<double>? weightKg,
    Expression<DateTime>? recordedAt,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weightKg != null) 'weight_kg': weightKg,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (note != null) 'note': note,
    });
  }

  WeightEntriesTableCompanion copyWith({
    Value<int>? id,
    Value<double>? weightKg,
    Value<DateTime>? recordedAt,
    Value<String?>? note,
  }) {
    return WeightEntriesTableCompanion(
      id: id ?? this.id,
      weightKg: weightKg ?? this.weightKg,
      recordedAt: recordedAt ?? this.recordedAt,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntriesTableCompanion(')
          ..write('id: $id, ')
          ..write('weightKg: $weightKg, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WorkoutPlansTableTable workoutPlansTable =
      $WorkoutPlansTableTable(this);
  late final $TrainingSessionsTableTable trainingSessionsTable =
      $TrainingSessionsTableTable(this);
  late final $ExerciseEntriesTableTable exerciseEntriesTable =
      $ExerciseEntriesTableTable(this);
  late final $ExerciseSetsTableTable exerciseSetsTable =
      $ExerciseSetsTableTable(this);
  late final $UserRanksTableTable userRanksTable = $UserRanksTableTable(this);
  late final $WeightEntriesTableTable weightEntriesTable =
      $WeightEntriesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    workoutPlansTable,
    trainingSessionsTable,
    exerciseEntriesTable,
    exerciseSetsTable,
    userRanksTable,
    weightEntriesTable,
  ];
}

typedef $$WorkoutPlansTableTableCreateCompanionBuilder =
    WorkoutPlansTableCompanion Function({
      required String id,
      required String name,
      required String description,
      required String ruleset,
      required String equipmentCategory,
      required String level,
      required int durationPerSession,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$WorkoutPlansTableTableUpdateCompanionBuilder =
    WorkoutPlansTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<String> ruleset,
      Value<String> equipmentCategory,
      Value<String> level,
      Value<int> durationPerSession,
      Value<bool> isActive,
      Value<int> rowid,
    });

class $$WorkoutPlansTableTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutPlansTableTable> {
  $$WorkoutPlansTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleset => $composableBuilder(
    column: $table.ruleset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipmentCategory => $composableBuilder(
    column: $table.equipmentCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationPerSession => $composableBuilder(
    column: $table.durationPerSession,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutPlansTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutPlansTableTable> {
  $$WorkoutPlansTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleset => $composableBuilder(
    column: $table.ruleset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipmentCategory => $composableBuilder(
    column: $table.equipmentCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationPerSession => $composableBuilder(
    column: $table.durationPerSession,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutPlansTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutPlansTableTable> {
  $$WorkoutPlansTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ruleset =>
      $composableBuilder(column: $table.ruleset, builder: (column) => column);

  GeneratedColumn<String> get equipmentCategory => $composableBuilder(
    column: $table.equipmentCategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get durationPerSession => $composableBuilder(
    column: $table.durationPerSession,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$WorkoutPlansTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutPlansTableTable,
          WorkoutPlanRow,
          $$WorkoutPlansTableTableFilterComposer,
          $$WorkoutPlansTableTableOrderingComposer,
          $$WorkoutPlansTableTableAnnotationComposer,
          $$WorkoutPlansTableTableCreateCompanionBuilder,
          $$WorkoutPlansTableTableUpdateCompanionBuilder,
          (
            WorkoutPlanRow,
            BaseReferences<
              _$AppDatabase,
              $WorkoutPlansTableTable,
              WorkoutPlanRow
            >,
          ),
          WorkoutPlanRow,
          PrefetchHooks Function()
        > {
  $$WorkoutPlansTableTableTableManager(
    _$AppDatabase db,
    $WorkoutPlansTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutPlansTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutPlansTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutPlansTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> ruleset = const Value.absent(),
                Value<String> equipmentCategory = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<int> durationPerSession = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutPlansTableCompanion(
                id: id,
                name: name,
                description: description,
                ruleset: ruleset,
                equipmentCategory: equipmentCategory,
                level: level,
                durationPerSession: durationPerSession,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String description,
                required String ruleset,
                required String equipmentCategory,
                required String level,
                required int durationPerSession,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutPlansTableCompanion.insert(
                id: id,
                name: name,
                description: description,
                ruleset: ruleset,
                equipmentCategory: equipmentCategory,
                level: level,
                durationPerSession: durationPerSession,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorkoutPlansTableTable, WorkoutPlanRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $WorkoutPlansTableTable,
                    WorkoutPlanRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutPlansTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutPlansTableTable,
      WorkoutPlanRow,
      $$WorkoutPlansTableTableFilterComposer,
      $$WorkoutPlansTableTableOrderingComposer,
      $$WorkoutPlansTableTableAnnotationComposer,
      $$WorkoutPlansTableTableCreateCompanionBuilder,
      $$WorkoutPlansTableTableUpdateCompanionBuilder,
      (
        WorkoutPlanRow,
        BaseReferences<_$AppDatabase, $WorkoutPlansTableTable, WorkoutPlanRow>,
      ),
      WorkoutPlanRow,
      PrefetchHooks Function()
    >;
typedef $$TrainingSessionsTableTableCreateCompanionBuilder =
    TrainingSessionsTableCompanion Function({
      required String id,
      required String planId,
      required String name,
      required String description,
      required int dayOfWeek,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });
typedef $$TrainingSessionsTableTableUpdateCompanionBuilder =
    TrainingSessionsTableCompanion Function({
      Value<String> id,
      Value<String> planId,
      Value<String> name,
      Value<String> description,
      Value<int> dayOfWeek,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });

class $$TrainingSessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TrainingSessionsTableTable> {
  $$TrainingSessionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TrainingSessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TrainingSessionsTableTable> {
  $$TrainingSessionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfWeek => $composableBuilder(
    column: $table.dayOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrainingSessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrainingSessionsTableTable> {
  $$TrainingSessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$TrainingSessionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrainingSessionsTableTable,
          TrainingSessionRow,
          $$TrainingSessionsTableTableFilterComposer,
          $$TrainingSessionsTableTableOrderingComposer,
          $$TrainingSessionsTableTableAnnotationComposer,
          $$TrainingSessionsTableTableCreateCompanionBuilder,
          $$TrainingSessionsTableTableUpdateCompanionBuilder,
          (
            TrainingSessionRow,
            BaseReferences<
              _$AppDatabase,
              $TrainingSessionsTableTable,
              TrainingSessionRow
            >,
          ),
          TrainingSessionRow,
          PrefetchHooks Function()
        > {
  $$TrainingSessionsTableTableTableManager(
    _$AppDatabase db,
    $TrainingSessionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrainingSessionsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TrainingSessionsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TrainingSessionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> dayOfWeek = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrainingSessionsTableCompanion(
                id: id,
                planId: planId,
                name: name,
                description: description,
                dayOfWeek: dayOfWeek,
                isCompleted: isCompleted,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String planId,
                required String name,
                required String description,
                required int dayOfWeek,
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrainingSessionsTableCompanion.insert(
                id: id,
                planId: planId,
                name: name,
                description: description,
                dayOfWeek: dayOfWeek,
                isCompleted: isCompleted,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TrainingSessionsTableTable, TrainingSessionRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $TrainingSessionsTableTable,
                    TrainingSessionRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TrainingSessionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrainingSessionsTableTable,
      TrainingSessionRow,
      $$TrainingSessionsTableTableFilterComposer,
      $$TrainingSessionsTableTableOrderingComposer,
      $$TrainingSessionsTableTableAnnotationComposer,
      $$TrainingSessionsTableTableCreateCompanionBuilder,
      $$TrainingSessionsTableTableUpdateCompanionBuilder,
      (
        TrainingSessionRow,
        BaseReferences<
          _$AppDatabase,
          $TrainingSessionsTableTable,
          TrainingSessionRow
        >,
      ),
      TrainingSessionRow,
      PrefetchHooks Function()
    >;
typedef $$ExerciseEntriesTableTableCreateCompanionBuilder =
    ExerciseEntriesTableCompanion Function({
      Value<int> id,
      required String sessionId,
      required int exerciseTemplateId,
      required String exerciseName,
      required String muscleGroup,
      required int orderIndex,
    });
typedef $$ExerciseEntriesTableTableUpdateCompanionBuilder =
    ExerciseEntriesTableCompanion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<int> exerciseTemplateId,
      Value<String> exerciseName,
      Value<String> muscleGroup,
      Value<int> orderIndex,
    });

class $$ExerciseEntriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseEntriesTableTable> {
  $$ExerciseEntriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exerciseTemplateId => $composableBuilder(
    column: $table.exerciseTemplateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExerciseEntriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseEntriesTableTable> {
  $$ExerciseEntriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exerciseTemplateId => $composableBuilder(
    column: $table.exerciseTemplateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseEntriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseEntriesTableTable> {
  $$ExerciseEntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<int> get exerciseTemplateId => $composableBuilder(
    column: $table.exerciseTemplateId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );
}

class $$ExerciseEntriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseEntriesTableTable,
          ExerciseEntryRow,
          $$ExerciseEntriesTableTableFilterComposer,
          $$ExerciseEntriesTableTableOrderingComposer,
          $$ExerciseEntriesTableTableAnnotationComposer,
          $$ExerciseEntriesTableTableCreateCompanionBuilder,
          $$ExerciseEntriesTableTableUpdateCompanionBuilder,
          (
            ExerciseEntryRow,
            BaseReferences<
              _$AppDatabase,
              $ExerciseEntriesTableTable,
              ExerciseEntryRow
            >,
          ),
          ExerciseEntryRow,
          PrefetchHooks Function()
        > {
  $$ExerciseEntriesTableTableTableManager(
    _$AppDatabase db,
    $ExerciseEntriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseEntriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseEntriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ExerciseEntriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<int> exerciseTemplateId = const Value.absent(),
                Value<String> exerciseName = const Value.absent(),
                Value<String> muscleGroup = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
              }) => ExerciseEntriesTableCompanion(
                id: id,
                sessionId: sessionId,
                exerciseTemplateId: exerciseTemplateId,
                exerciseName: exerciseName,
                muscleGroup: muscleGroup,
                orderIndex: orderIndex,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                required int exerciseTemplateId,
                required String exerciseName,
                required String muscleGroup,
                required int orderIndex,
              }) => ExerciseEntriesTableCompanion.insert(
                id: id,
                sessionId: sessionId,
                exerciseTemplateId: exerciseTemplateId,
                exerciseName: exerciseName,
                muscleGroup: muscleGroup,
                orderIndex: orderIndex,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExerciseEntriesTableTable, ExerciseEntryRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ExerciseEntriesTableTable,
                    ExerciseEntryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExerciseEntriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseEntriesTableTable,
      ExerciseEntryRow,
      $$ExerciseEntriesTableTableFilterComposer,
      $$ExerciseEntriesTableTableOrderingComposer,
      $$ExerciseEntriesTableTableAnnotationComposer,
      $$ExerciseEntriesTableTableCreateCompanionBuilder,
      $$ExerciseEntriesTableTableUpdateCompanionBuilder,
      (
        ExerciseEntryRow,
        BaseReferences<
          _$AppDatabase,
          $ExerciseEntriesTableTable,
          ExerciseEntryRow
        >,
      ),
      ExerciseEntryRow,
      PrefetchHooks Function()
    >;
typedef $$ExerciseSetsTableTableCreateCompanionBuilder =
    ExerciseSetsTableCompanion Function({
      Value<int> id,
      required int exerciseEntryId,
      required int setNumber,
      required double weightKg,
      required int reps,
      Value<bool> isCompleted,
      Value<double?> rpe,
    });
typedef $$ExerciseSetsTableTableUpdateCompanionBuilder =
    ExerciseSetsTableCompanion Function({
      Value<int> id,
      Value<int> exerciseEntryId,
      Value<int> setNumber,
      Value<double> weightKg,
      Value<int> reps,
      Value<bool> isCompleted,
      Value<double?> rpe,
    });

class $$ExerciseSetsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseSetsTableTable> {
  $$ExerciseSetsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exerciseEntryId => $composableBuilder(
    column: $table.exerciseEntryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExerciseSetsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseSetsTableTable> {
  $$ExerciseSetsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exerciseEntryId => $composableBuilder(
    column: $table.exerciseEntryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseSetsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseSetsTableTable> {
  $$ExerciseSetsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get exerciseEntryId => $composableBuilder(
    column: $table.exerciseEntryId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rpe =>
      $composableBuilder(column: $table.rpe, builder: (column) => column);
}

class $$ExerciseSetsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseSetsTableTable,
          ExerciseSetRow,
          $$ExerciseSetsTableTableFilterComposer,
          $$ExerciseSetsTableTableOrderingComposer,
          $$ExerciseSetsTableTableAnnotationComposer,
          $$ExerciseSetsTableTableCreateCompanionBuilder,
          $$ExerciseSetsTableTableUpdateCompanionBuilder,
          (
            ExerciseSetRow,
            BaseReferences<
              _$AppDatabase,
              $ExerciseSetsTableTable,
              ExerciseSetRow
            >,
          ),
          ExerciseSetRow,
          PrefetchHooks Function()
        > {
  $$ExerciseSetsTableTableTableManager(
    _$AppDatabase db,
    $ExerciseSetsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseSetsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseSetsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseSetsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> exerciseEntryId = const Value.absent(),
                Value<int> setNumber = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<double?> rpe = const Value.absent(),
              }) => ExerciseSetsTableCompanion(
                id: id,
                exerciseEntryId: exerciseEntryId,
                setNumber: setNumber,
                weightKg: weightKg,
                reps: reps,
                isCompleted: isCompleted,
                rpe: rpe,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int exerciseEntryId,
                required int setNumber,
                required double weightKg,
                required int reps,
                Value<bool> isCompleted = const Value.absent(),
                Value<double?> rpe = const Value.absent(),
              }) => ExerciseSetsTableCompanion.insert(
                id: id,
                exerciseEntryId: exerciseEntryId,
                setNumber: setNumber,
                weightKg: weightKg,
                reps: reps,
                isCompleted: isCompleted,
                rpe: rpe,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExerciseSetsTableTable, ExerciseSetRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ExerciseSetsTableTable,
                    ExerciseSetRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExerciseSetsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseSetsTableTable,
      ExerciseSetRow,
      $$ExerciseSetsTableTableFilterComposer,
      $$ExerciseSetsTableTableOrderingComposer,
      $$ExerciseSetsTableTableAnnotationComposer,
      $$ExerciseSetsTableTableCreateCompanionBuilder,
      $$ExerciseSetsTableTableUpdateCompanionBuilder,
      (
        ExerciseSetRow,
        BaseReferences<_$AppDatabase, $ExerciseSetsTableTable, ExerciseSetRow>,
      ),
      ExerciseSetRow,
      PrefetchHooks Function()
    >;
typedef $$UserRanksTableTableCreateCompanionBuilder =
    UserRanksTableCompanion Function({
      required String muscleGroup,
      required String currentRank,
      required int tierLevel,
      required double estimated1Rm,
      required double percentile,
      Value<DateTime?> lastTrained,
      Value<int> rowid,
    });
typedef $$UserRanksTableTableUpdateCompanionBuilder =
    UserRanksTableCompanion Function({
      Value<String> muscleGroup,
      Value<String> currentRank,
      Value<int> tierLevel,
      Value<double> estimated1Rm,
      Value<double> percentile,
      Value<DateTime?> lastTrained,
      Value<int> rowid,
    });

class $$UserRanksTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserRanksTableTable> {
  $$UserRanksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentRank => $composableBuilder(
    column: $table.currentRank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tierLevel => $composableBuilder(
    column: $table.tierLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimated1Rm => $composableBuilder(
    column: $table.estimated1Rm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get percentile => $composableBuilder(
    column: $table.percentile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastTrained => $composableBuilder(
    column: $table.lastTrained,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserRanksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserRanksTableTable> {
  $$UserRanksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentRank => $composableBuilder(
    column: $table.currentRank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tierLevel => $composableBuilder(
    column: $table.tierLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimated1Rm => $composableBuilder(
    column: $table.estimated1Rm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get percentile => $composableBuilder(
    column: $table.percentile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastTrained => $composableBuilder(
    column: $table.lastTrained,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserRanksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserRanksTableTable> {
  $$UserRanksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentRank => $composableBuilder(
    column: $table.currentRank,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tierLevel =>
      $composableBuilder(column: $table.tierLevel, builder: (column) => column);

  GeneratedColumn<double> get estimated1Rm => $composableBuilder(
    column: $table.estimated1Rm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get percentile => $composableBuilder(
    column: $table.percentile,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastTrained => $composableBuilder(
    column: $table.lastTrained,
    builder: (column) => column,
  );
}

class $$UserRanksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserRanksTableTable,
          UserRankRow,
          $$UserRanksTableTableFilterComposer,
          $$UserRanksTableTableOrderingComposer,
          $$UserRanksTableTableAnnotationComposer,
          $$UserRanksTableTableCreateCompanionBuilder,
          $$UserRanksTableTableUpdateCompanionBuilder,
          (
            UserRankRow,
            BaseReferences<_$AppDatabase, $UserRanksTableTable, UserRankRow>,
          ),
          UserRankRow,
          PrefetchHooks Function()
        > {
  $$UserRanksTableTableTableManager(
    _$AppDatabase db,
    $UserRanksTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserRanksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserRanksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserRanksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> muscleGroup = const Value.absent(),
                Value<String> currentRank = const Value.absent(),
                Value<int> tierLevel = const Value.absent(),
                Value<double> estimated1Rm = const Value.absent(),
                Value<double> percentile = const Value.absent(),
                Value<DateTime?> lastTrained = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserRanksTableCompanion(
                muscleGroup: muscleGroup,
                currentRank: currentRank,
                tierLevel: tierLevel,
                estimated1Rm: estimated1Rm,
                percentile: percentile,
                lastTrained: lastTrained,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String muscleGroup,
                required String currentRank,
                required int tierLevel,
                required double estimated1Rm,
                required double percentile,
                Value<DateTime?> lastTrained = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserRanksTableCompanion.insert(
                muscleGroup: muscleGroup,
                currentRank: currentRank,
                tierLevel: tierLevel,
                estimated1Rm: estimated1Rm,
                percentile: percentile,
                lastTrained: lastTrained,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserRanksTableTable, UserRankRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $UserRanksTableTable,
                    UserRankRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserRanksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserRanksTableTable,
      UserRankRow,
      $$UserRanksTableTableFilterComposer,
      $$UserRanksTableTableOrderingComposer,
      $$UserRanksTableTableAnnotationComposer,
      $$UserRanksTableTableCreateCompanionBuilder,
      $$UserRanksTableTableUpdateCompanionBuilder,
      (
        UserRankRow,
        BaseReferences<_$AppDatabase, $UserRanksTableTable, UserRankRow>,
      ),
      UserRankRow,
      PrefetchHooks Function()
    >;
typedef $$WeightEntriesTableTableCreateCompanionBuilder =
    WeightEntriesTableCompanion Function({
      Value<int> id,
      required double weightKg,
      required DateTime recordedAt,
      Value<String?> note,
    });
typedef $$WeightEntriesTableTableUpdateCompanionBuilder =
    WeightEntriesTableCompanion Function({
      Value<int> id,
      Value<double> weightKg,
      Value<DateTime> recordedAt,
      Value<String?> note,
    });

class $$WeightEntriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $WeightEntriesTableTable> {
  $$WeightEntriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeightEntriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightEntriesTableTable> {
  $$WeightEntriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeightEntriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightEntriesTableTable> {
  $$WeightEntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$WeightEntriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeightEntriesTableTable,
          WeightEntryRow,
          $$WeightEntriesTableTableFilterComposer,
          $$WeightEntriesTableTableOrderingComposer,
          $$WeightEntriesTableTableAnnotationComposer,
          $$WeightEntriesTableTableCreateCompanionBuilder,
          $$WeightEntriesTableTableUpdateCompanionBuilder,
          (
            WeightEntryRow,
            BaseReferences<
              _$AppDatabase,
              $WeightEntriesTableTable,
              WeightEntryRow
            >,
          ),
          WeightEntryRow,
          PrefetchHooks Function()
        > {
  $$WeightEntriesTableTableTableManager(
    _$AppDatabase db,
    $WeightEntriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightEntriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightEntriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightEntriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => WeightEntriesTableCompanion(
                id: id,
                weightKg: weightKg,
                recordedAt: recordedAt,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double weightKg,
                required DateTime recordedAt,
                Value<String?> note = const Value.absent(),
              }) => WeightEntriesTableCompanion.insert(
                id: id,
                weightKg: weightKg,
                recordedAt: recordedAt,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WeightEntriesTableTable, WeightEntryRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $WeightEntriesTableTable,
                    WeightEntryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeightEntriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeightEntriesTableTable,
      WeightEntryRow,
      $$WeightEntriesTableTableFilterComposer,
      $$WeightEntriesTableTableOrderingComposer,
      $$WeightEntriesTableTableAnnotationComposer,
      $$WeightEntriesTableTableCreateCompanionBuilder,
      $$WeightEntriesTableTableUpdateCompanionBuilder,
      (
        WeightEntryRow,
        BaseReferences<_$AppDatabase, $WeightEntriesTableTable, WeightEntryRow>,
      ),
      WeightEntryRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WorkoutPlansTableTableTableManager get workoutPlansTable =>
      $$WorkoutPlansTableTableTableManager(_db, _db.workoutPlansTable);
  $$TrainingSessionsTableTableTableManager get trainingSessionsTable =>
      $$TrainingSessionsTableTableTableManager(_db, _db.trainingSessionsTable);
  $$ExerciseEntriesTableTableTableManager get exerciseEntriesTable =>
      $$ExerciseEntriesTableTableTableManager(_db, _db.exerciseEntriesTable);
  $$ExerciseSetsTableTableTableManager get exerciseSetsTable =>
      $$ExerciseSetsTableTableTableManager(_db, _db.exerciseSetsTable);
  $$UserRanksTableTableTableManager get userRanksTable =>
      $$UserRanksTableTableTableManager(_db, _db.userRanksTable);
  $$WeightEntriesTableTableTableManager get weightEntriesTable =>
      $$WeightEntriesTableTableTableManager(_db, _db.weightEntriesTable);
}
