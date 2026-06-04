// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProgramsTable extends Programs with TableInfo<$ProgramsTable, Program> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgramsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    isBuiltIn,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'programs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Program> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Program map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Program(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProgramsTable createAlias(String alias) {
    return $ProgramsTable(attachedDatabase, alias);
  }
}

class Program extends DataClass implements Insertable<Program> {
  final int id;
  final String name;
  final String? description;

  /// True for the seeded default program; protects it from seed re-runs
  /// overwriting user data and lets the UI mark it as non-deletable.
  final bool isBuiltIn;

  /// Exactly one program should be active at a time (the one being tracked).
  final bool isActive;
  final DateTime createdAt;
  const Program({
    required this.id,
    required this.name,
    this.description,
    required this.isBuiltIn,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProgramsCompanion toCompanion(bool nullToAbsent) {
    return ProgramsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isBuiltIn: Value(isBuiltIn),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Program.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Program(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Program copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    bool? isBuiltIn,
    bool? isActive,
    DateTime? createdAt,
  }) => Program(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  Program copyWithCompanion(ProgramsCompanion data) {
    return Program(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Program(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, isBuiltIn, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Program &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.isBuiltIn == this.isBuiltIn &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class ProgramsCompanion extends UpdateCompanion<Program> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> isBuiltIn;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const ProgramsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProgramsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Program> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isBuiltIn,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProgramsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<bool>? isBuiltIn,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return ProgramsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgramsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WeeksTable extends Weeks with TableInfo<$WeeksTable, Week> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeksTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _programIdMeta = const VerificationMeta(
    'programId',
  );
  @override
  late final GeneratedColumn<int> programId = GeneratedColumn<int>(
    'program_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES programs (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _weekIndexMeta = const VerificationMeta(
    'weekIndex',
  );
  @override
  late final GeneratedColumn<int> weekIndex = GeneratedColumn<int>(
    'week_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phaseMeta = const VerificationMeta('phase');
  @override
  late final GeneratedColumn<int> phase = GeneratedColumn<int>(
    'phase',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phaseNameMeta = const VerificationMeta(
    'phaseName',
  );
  @override
  late final GeneratedColumn<String> phaseName = GeneratedColumn<String>(
    'phase_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isUnlockedMeta = const VerificationMeta(
    'isUnlocked',
  );
  @override
  late final GeneratedColumn<bool> isUnlocked = GeneratedColumn<bool>(
    'is_unlocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_unlocked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _unlockThresholdMeta = const VerificationMeta(
    'unlockThreshold',
  );
  @override
  late final GeneratedColumn<double> unlockThreshold = GeneratedColumn<double>(
    'unlock_threshold',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.70),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    programId,
    weekIndex,
    phase,
    title,
    phaseName,
    isUnlocked,
    unlockThreshold,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weeks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Week> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('program_id')) {
      context.handle(
        _programIdMeta,
        programId.isAcceptableOrUnknown(data['program_id']!, _programIdMeta),
      );
    } else if (isInserting) {
      context.missing(_programIdMeta);
    }
    if (data.containsKey('week_index')) {
      context.handle(
        _weekIndexMeta,
        weekIndex.isAcceptableOrUnknown(data['week_index']!, _weekIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_weekIndexMeta);
    }
    if (data.containsKey('phase')) {
      context.handle(
        _phaseMeta,
        phase.isAcceptableOrUnknown(data['phase']!, _phaseMeta),
      );
    } else if (isInserting) {
      context.missing(_phaseMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('phase_name')) {
      context.handle(
        _phaseNameMeta,
        phaseName.isAcceptableOrUnknown(data['phase_name']!, _phaseNameMeta),
      );
    }
    if (data.containsKey('is_unlocked')) {
      context.handle(
        _isUnlockedMeta,
        isUnlocked.isAcceptableOrUnknown(data['is_unlocked']!, _isUnlockedMeta),
      );
    }
    if (data.containsKey('unlock_threshold')) {
      context.handle(
        _unlockThresholdMeta,
        unlockThreshold.isAcceptableOrUnknown(
          data['unlock_threshold']!,
          _unlockThresholdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Week map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Week(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      programId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}program_id'],
      )!,
      weekIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_index'],
      )!,
      phase: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}phase'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      phaseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phase_name'],
      ),
      isUnlocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_unlocked'],
      )!,
      unlockThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unlock_threshold'],
      )!,
    );
  }

  @override
  $WeeksTable createAlias(String alias) {
    return $WeeksTable(attachedDatabase, alias);
  }
}

class Week extends DataClass implements Insertable<Week> {
  final int id;
  final int programId;
  final int weekIndex;
  final int phase;
  final String? title;

  /// Human-readable phase label (e.g. "Temel", "Gelişim") for the UI.
  final String? phaseName;
  final bool isUnlocked;

  /// Completion ratio (0..1) of the *previous* week required to unlock this one.
  final double unlockThreshold;
  const Week({
    required this.id,
    required this.programId,
    required this.weekIndex,
    required this.phase,
    this.title,
    this.phaseName,
    required this.isUnlocked,
    required this.unlockThreshold,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['program_id'] = Variable<int>(programId);
    map['week_index'] = Variable<int>(weekIndex);
    map['phase'] = Variable<int>(phase);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || phaseName != null) {
      map['phase_name'] = Variable<String>(phaseName);
    }
    map['is_unlocked'] = Variable<bool>(isUnlocked);
    map['unlock_threshold'] = Variable<double>(unlockThreshold);
    return map;
  }

  WeeksCompanion toCompanion(bool nullToAbsent) {
    return WeeksCompanion(
      id: Value(id),
      programId: Value(programId),
      weekIndex: Value(weekIndex),
      phase: Value(phase),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      phaseName: phaseName == null && nullToAbsent
          ? const Value.absent()
          : Value(phaseName),
      isUnlocked: Value(isUnlocked),
      unlockThreshold: Value(unlockThreshold),
    );
  }

  factory Week.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Week(
      id: serializer.fromJson<int>(json['id']),
      programId: serializer.fromJson<int>(json['programId']),
      weekIndex: serializer.fromJson<int>(json['weekIndex']),
      phase: serializer.fromJson<int>(json['phase']),
      title: serializer.fromJson<String?>(json['title']),
      phaseName: serializer.fromJson<String?>(json['phaseName']),
      isUnlocked: serializer.fromJson<bool>(json['isUnlocked']),
      unlockThreshold: serializer.fromJson<double>(json['unlockThreshold']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'programId': serializer.toJson<int>(programId),
      'weekIndex': serializer.toJson<int>(weekIndex),
      'phase': serializer.toJson<int>(phase),
      'title': serializer.toJson<String?>(title),
      'phaseName': serializer.toJson<String?>(phaseName),
      'isUnlocked': serializer.toJson<bool>(isUnlocked),
      'unlockThreshold': serializer.toJson<double>(unlockThreshold),
    };
  }

  Week copyWith({
    int? id,
    int? programId,
    int? weekIndex,
    int? phase,
    Value<String?> title = const Value.absent(),
    Value<String?> phaseName = const Value.absent(),
    bool? isUnlocked,
    double? unlockThreshold,
  }) => Week(
    id: id ?? this.id,
    programId: programId ?? this.programId,
    weekIndex: weekIndex ?? this.weekIndex,
    phase: phase ?? this.phase,
    title: title.present ? title.value : this.title,
    phaseName: phaseName.present ? phaseName.value : this.phaseName,
    isUnlocked: isUnlocked ?? this.isUnlocked,
    unlockThreshold: unlockThreshold ?? this.unlockThreshold,
  );
  Week copyWithCompanion(WeeksCompanion data) {
    return Week(
      id: data.id.present ? data.id.value : this.id,
      programId: data.programId.present ? data.programId.value : this.programId,
      weekIndex: data.weekIndex.present ? data.weekIndex.value : this.weekIndex,
      phase: data.phase.present ? data.phase.value : this.phase,
      title: data.title.present ? data.title.value : this.title,
      phaseName: data.phaseName.present ? data.phaseName.value : this.phaseName,
      isUnlocked: data.isUnlocked.present
          ? data.isUnlocked.value
          : this.isUnlocked,
      unlockThreshold: data.unlockThreshold.present
          ? data.unlockThreshold.value
          : this.unlockThreshold,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Week(')
          ..write('id: $id, ')
          ..write('programId: $programId, ')
          ..write('weekIndex: $weekIndex, ')
          ..write('phase: $phase, ')
          ..write('title: $title, ')
          ..write('phaseName: $phaseName, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockThreshold: $unlockThreshold')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    programId,
    weekIndex,
    phase,
    title,
    phaseName,
    isUnlocked,
    unlockThreshold,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Week &&
          other.id == this.id &&
          other.programId == this.programId &&
          other.weekIndex == this.weekIndex &&
          other.phase == this.phase &&
          other.title == this.title &&
          other.phaseName == this.phaseName &&
          other.isUnlocked == this.isUnlocked &&
          other.unlockThreshold == this.unlockThreshold);
}

class WeeksCompanion extends UpdateCompanion<Week> {
  final Value<int> id;
  final Value<int> programId;
  final Value<int> weekIndex;
  final Value<int> phase;
  final Value<String?> title;
  final Value<String?> phaseName;
  final Value<bool> isUnlocked;
  final Value<double> unlockThreshold;
  const WeeksCompanion({
    this.id = const Value.absent(),
    this.programId = const Value.absent(),
    this.weekIndex = const Value.absent(),
    this.phase = const Value.absent(),
    this.title = const Value.absent(),
    this.phaseName = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.unlockThreshold = const Value.absent(),
  });
  WeeksCompanion.insert({
    this.id = const Value.absent(),
    required int programId,
    required int weekIndex,
    required int phase,
    this.title = const Value.absent(),
    this.phaseName = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.unlockThreshold = const Value.absent(),
  }) : programId = Value(programId),
       weekIndex = Value(weekIndex),
       phase = Value(phase);
  static Insertable<Week> custom({
    Expression<int>? id,
    Expression<int>? programId,
    Expression<int>? weekIndex,
    Expression<int>? phase,
    Expression<String>? title,
    Expression<String>? phaseName,
    Expression<bool>? isUnlocked,
    Expression<double>? unlockThreshold,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (programId != null) 'program_id': programId,
      if (weekIndex != null) 'week_index': weekIndex,
      if (phase != null) 'phase': phase,
      if (title != null) 'title': title,
      if (phaseName != null) 'phase_name': phaseName,
      if (isUnlocked != null) 'is_unlocked': isUnlocked,
      if (unlockThreshold != null) 'unlock_threshold': unlockThreshold,
    });
  }

  WeeksCompanion copyWith({
    Value<int>? id,
    Value<int>? programId,
    Value<int>? weekIndex,
    Value<int>? phase,
    Value<String?>? title,
    Value<String?>? phaseName,
    Value<bool>? isUnlocked,
    Value<double>? unlockThreshold,
  }) {
    return WeeksCompanion(
      id: id ?? this.id,
      programId: programId ?? this.programId,
      weekIndex: weekIndex ?? this.weekIndex,
      phase: phase ?? this.phase,
      title: title ?? this.title,
      phaseName: phaseName ?? this.phaseName,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockThreshold: unlockThreshold ?? this.unlockThreshold,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (programId.present) {
      map['program_id'] = Variable<int>(programId.value);
    }
    if (weekIndex.present) {
      map['week_index'] = Variable<int>(weekIndex.value);
    }
    if (phase.present) {
      map['phase'] = Variable<int>(phase.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (phaseName.present) {
      map['phase_name'] = Variable<String>(phaseName.value);
    }
    if (isUnlocked.present) {
      map['is_unlocked'] = Variable<bool>(isUnlocked.value);
    }
    if (unlockThreshold.present) {
      map['unlock_threshold'] = Variable<double>(unlockThreshold.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeksCompanion(')
          ..write('id: $id, ')
          ..write('programId: $programId, ')
          ..write('weekIndex: $weekIndex, ')
          ..write('phase: $phase, ')
          ..write('title: $title, ')
          ..write('phaseName: $phaseName, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockThreshold: $unlockThreshold')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _weekIdMeta = const VerificationMeta('weekId');
  @override
  late final GeneratedColumn<int> weekId = GeneratedColumn<int>(
    'week_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weeks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<DayPart, String> dayPart =
      GeneratedColumn<String>(
        'day_part',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(DayPart.morning.name),
      ).withConverter<DayPart>($ExercisesTable.$converterdayPart);
  @override
  late final GeneratedColumnWithTypeConverter<ExerciseType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(ExerciseType.kegel.name),
      ).withConverter<ExerciseType>($ExercisesTable.$convertertype);
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> steps =
      GeneratedColumn<String>(
        'steps',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<String>?>($ExercisesTable.$converterstepsn);
  static const VerificationMeta _squeezeSecondsMeta = const VerificationMeta(
    'squeezeSeconds',
  );
  @override
  late final GeneratedColumn<int> squeezeSeconds = GeneratedColumn<int>(
    'squeeze_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _holdSecondsMeta = const VerificationMeta(
    'holdSeconds',
  );
  @override
  late final GeneratedColumn<int> holdSeconds = GeneratedColumn<int>(
    'hold_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _releaseSecondsMeta = const VerificationMeta(
    'releaseSeconds',
  );
  @override
  late final GeneratedColumn<int> releaseSeconds = GeneratedColumn<int>(
    'release_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restSecondsMeta = const VerificationMeta(
    'restSeconds',
  );
  @override
  late final GeneratedColumn<int> restSeconds = GeneratedColumn<int>(
    'rest_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _setsMeta = const VerificationMeta('sets');
  @override
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
    'sets',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    weekId,
    name,
    orderIndex,
    dayPart,
    type,
    description,
    steps,
    squeezeSeconds,
    holdSeconds,
    releaseSeconds,
    restSeconds,
    reps,
    sets,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('week_id')) {
      context.handle(
        _weekIdMeta,
        weekId.isAcceptableOrUnknown(data['week_id']!, _weekIdMeta),
      );
    } else if (isInserting) {
      context.missing(_weekIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('squeeze_seconds')) {
      context.handle(
        _squeezeSecondsMeta,
        squeezeSeconds.isAcceptableOrUnknown(
          data['squeeze_seconds']!,
          _squeezeSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_squeezeSecondsMeta);
    }
    if (data.containsKey('hold_seconds')) {
      context.handle(
        _holdSecondsMeta,
        holdSeconds.isAcceptableOrUnknown(
          data['hold_seconds']!,
          _holdSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_holdSecondsMeta);
    }
    if (data.containsKey('release_seconds')) {
      context.handle(
        _releaseSecondsMeta,
        releaseSeconds.isAcceptableOrUnknown(
          data['release_seconds']!,
          _releaseSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_releaseSecondsMeta);
    }
    if (data.containsKey('rest_seconds')) {
      context.handle(
        _restSecondsMeta,
        restSeconds.isAcceptableOrUnknown(
          data['rest_seconds']!,
          _restSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_restSecondsMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('sets')) {
      context.handle(
        _setsMeta,
        sets.isAcceptableOrUnknown(data['sets']!, _setsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      weekId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      dayPart: $ExercisesTable.$converterdayPart.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}day_part'],
        )!,
      ),
      type: $ExercisesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      steps: $ExercisesTable.$converterstepsn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}steps'],
        ),
      ),
      squeezeSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}squeeze_seconds'],
      )!,
      holdSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hold_seconds'],
      )!,
      releaseSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}release_seconds'],
      )!,
      restSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_seconds'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      sets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sets'],
      )!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DayPart, String, String> $converterdayPart =
      const EnumNameConverter<DayPart>(DayPart.values);
  static JsonTypeConverter2<ExerciseType, String, String> $convertertype =
      const EnumNameConverter<ExerciseType>(ExerciseType.values);
  static TypeConverter<List<String>, String> $convertersteps =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $converterstepsn =
      NullAwareTypeConverter.wrap($convertersteps);
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final int id;
  final int weekId;
  final String name;
  final int orderIndex;

  /// When in the day this exercise is performed.
  final DayPart dayPart;

  /// What kind of exercise this is (kegel / breath / mind / combo).
  final ExerciseType type;

  /// Free-text explanation shown above the timer.
  final String? description;

  /// Ordered step-by-step instructions, stored as a JSON list.
  final List<String>? steps;
  final int squeezeSeconds;
  final int holdSeconds;
  final int releaseSeconds;
  final int restSeconds;
  final int reps;
  final int sets;
  const Exercise({
    required this.id,
    required this.weekId,
    required this.name,
    required this.orderIndex,
    required this.dayPart,
    required this.type,
    this.description,
    this.steps,
    required this.squeezeSeconds,
    required this.holdSeconds,
    required this.releaseSeconds,
    required this.restSeconds,
    required this.reps,
    required this.sets,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['week_id'] = Variable<int>(weekId);
    map['name'] = Variable<String>(name);
    map['order_index'] = Variable<int>(orderIndex);
    {
      map['day_part'] = Variable<String>(
        $ExercisesTable.$converterdayPart.toSql(dayPart),
      );
    }
    {
      map['type'] = Variable<String>(
        $ExercisesTable.$convertertype.toSql(type),
      );
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || steps != null) {
      map['steps'] = Variable<String>(
        $ExercisesTable.$converterstepsn.toSql(steps),
      );
    }
    map['squeeze_seconds'] = Variable<int>(squeezeSeconds);
    map['hold_seconds'] = Variable<int>(holdSeconds);
    map['release_seconds'] = Variable<int>(releaseSeconds);
    map['rest_seconds'] = Variable<int>(restSeconds);
    map['reps'] = Variable<int>(reps);
    map['sets'] = Variable<int>(sets);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      weekId: Value(weekId),
      name: Value(name),
      orderIndex: Value(orderIndex),
      dayPart: Value(dayPart),
      type: Value(type),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      steps: steps == null && nullToAbsent
          ? const Value.absent()
          : Value(steps),
      squeezeSeconds: Value(squeezeSeconds),
      holdSeconds: Value(holdSeconds),
      releaseSeconds: Value(releaseSeconds),
      restSeconds: Value(restSeconds),
      reps: Value(reps),
      sets: Value(sets),
    );
  }

  factory Exercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<int>(json['id']),
      weekId: serializer.fromJson<int>(json['weekId']),
      name: serializer.fromJson<String>(json['name']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      dayPart: $ExercisesTable.$converterdayPart.fromJson(
        serializer.fromJson<String>(json['dayPart']),
      ),
      type: $ExercisesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      description: serializer.fromJson<String?>(json['description']),
      steps: serializer.fromJson<List<String>?>(json['steps']),
      squeezeSeconds: serializer.fromJson<int>(json['squeezeSeconds']),
      holdSeconds: serializer.fromJson<int>(json['holdSeconds']),
      releaseSeconds: serializer.fromJson<int>(json['releaseSeconds']),
      restSeconds: serializer.fromJson<int>(json['restSeconds']),
      reps: serializer.fromJson<int>(json['reps']),
      sets: serializer.fromJson<int>(json['sets']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'weekId': serializer.toJson<int>(weekId),
      'name': serializer.toJson<String>(name),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'dayPart': serializer.toJson<String>(
        $ExercisesTable.$converterdayPart.toJson(dayPart),
      ),
      'type': serializer.toJson<String>(
        $ExercisesTable.$convertertype.toJson(type),
      ),
      'description': serializer.toJson<String?>(description),
      'steps': serializer.toJson<List<String>?>(steps),
      'squeezeSeconds': serializer.toJson<int>(squeezeSeconds),
      'holdSeconds': serializer.toJson<int>(holdSeconds),
      'releaseSeconds': serializer.toJson<int>(releaseSeconds),
      'restSeconds': serializer.toJson<int>(restSeconds),
      'reps': serializer.toJson<int>(reps),
      'sets': serializer.toJson<int>(sets),
    };
  }

  Exercise copyWith({
    int? id,
    int? weekId,
    String? name,
    int? orderIndex,
    DayPart? dayPart,
    ExerciseType? type,
    Value<String?> description = const Value.absent(),
    Value<List<String>?> steps = const Value.absent(),
    int? squeezeSeconds,
    int? holdSeconds,
    int? releaseSeconds,
    int? restSeconds,
    int? reps,
    int? sets,
  }) => Exercise(
    id: id ?? this.id,
    weekId: weekId ?? this.weekId,
    name: name ?? this.name,
    orderIndex: orderIndex ?? this.orderIndex,
    dayPart: dayPart ?? this.dayPart,
    type: type ?? this.type,
    description: description.present ? description.value : this.description,
    steps: steps.present ? steps.value : this.steps,
    squeezeSeconds: squeezeSeconds ?? this.squeezeSeconds,
    holdSeconds: holdSeconds ?? this.holdSeconds,
    releaseSeconds: releaseSeconds ?? this.releaseSeconds,
    restSeconds: restSeconds ?? this.restSeconds,
    reps: reps ?? this.reps,
    sets: sets ?? this.sets,
  );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      weekId: data.weekId.present ? data.weekId.value : this.weekId,
      name: data.name.present ? data.name.value : this.name,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      dayPart: data.dayPart.present ? data.dayPart.value : this.dayPart,
      type: data.type.present ? data.type.value : this.type,
      description: data.description.present
          ? data.description.value
          : this.description,
      steps: data.steps.present ? data.steps.value : this.steps,
      squeezeSeconds: data.squeezeSeconds.present
          ? data.squeezeSeconds.value
          : this.squeezeSeconds,
      holdSeconds: data.holdSeconds.present
          ? data.holdSeconds.value
          : this.holdSeconds,
      releaseSeconds: data.releaseSeconds.present
          ? data.releaseSeconds.value
          : this.releaseSeconds,
      restSeconds: data.restSeconds.present
          ? data.restSeconds.value
          : this.restSeconds,
      reps: data.reps.present ? data.reps.value : this.reps,
      sets: data.sets.present ? data.sets.value : this.sets,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('weekId: $weekId, ')
          ..write('name: $name, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('dayPart: $dayPart, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('steps: $steps, ')
          ..write('squeezeSeconds: $squeezeSeconds, ')
          ..write('holdSeconds: $holdSeconds, ')
          ..write('releaseSeconds: $releaseSeconds, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('reps: $reps, ')
          ..write('sets: $sets')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    weekId,
    name,
    orderIndex,
    dayPart,
    type,
    description,
    steps,
    squeezeSeconds,
    holdSeconds,
    releaseSeconds,
    restSeconds,
    reps,
    sets,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.weekId == this.weekId &&
          other.name == this.name &&
          other.orderIndex == this.orderIndex &&
          other.dayPart == this.dayPart &&
          other.type == this.type &&
          other.description == this.description &&
          other.steps == this.steps &&
          other.squeezeSeconds == this.squeezeSeconds &&
          other.holdSeconds == this.holdSeconds &&
          other.releaseSeconds == this.releaseSeconds &&
          other.restSeconds == this.restSeconds &&
          other.reps == this.reps &&
          other.sets == this.sets);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<int> id;
  final Value<int> weekId;
  final Value<String> name;
  final Value<int> orderIndex;
  final Value<DayPart> dayPart;
  final Value<ExerciseType> type;
  final Value<String?> description;
  final Value<List<String>?> steps;
  final Value<int> squeezeSeconds;
  final Value<int> holdSeconds;
  final Value<int> releaseSeconds;
  final Value<int> restSeconds;
  final Value<int> reps;
  final Value<int> sets;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.weekId = const Value.absent(),
    this.name = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.dayPart = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.steps = const Value.absent(),
    this.squeezeSeconds = const Value.absent(),
    this.holdSeconds = const Value.absent(),
    this.releaseSeconds = const Value.absent(),
    this.restSeconds = const Value.absent(),
    this.reps = const Value.absent(),
    this.sets = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    required int weekId,
    required String name,
    this.orderIndex = const Value.absent(),
    this.dayPart = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.steps = const Value.absent(),
    required int squeezeSeconds,
    required int holdSeconds,
    required int releaseSeconds,
    required int restSeconds,
    required int reps,
    this.sets = const Value.absent(),
  }) : weekId = Value(weekId),
       name = Value(name),
       squeezeSeconds = Value(squeezeSeconds),
       holdSeconds = Value(holdSeconds),
       releaseSeconds = Value(releaseSeconds),
       restSeconds = Value(restSeconds),
       reps = Value(reps);
  static Insertable<Exercise> custom({
    Expression<int>? id,
    Expression<int>? weekId,
    Expression<String>? name,
    Expression<int>? orderIndex,
    Expression<String>? dayPart,
    Expression<String>? type,
    Expression<String>? description,
    Expression<String>? steps,
    Expression<int>? squeezeSeconds,
    Expression<int>? holdSeconds,
    Expression<int>? releaseSeconds,
    Expression<int>? restSeconds,
    Expression<int>? reps,
    Expression<int>? sets,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weekId != null) 'week_id': weekId,
      if (name != null) 'name': name,
      if (orderIndex != null) 'order_index': orderIndex,
      if (dayPart != null) 'day_part': dayPart,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
      if (steps != null) 'steps': steps,
      if (squeezeSeconds != null) 'squeeze_seconds': squeezeSeconds,
      if (holdSeconds != null) 'hold_seconds': holdSeconds,
      if (releaseSeconds != null) 'release_seconds': releaseSeconds,
      if (restSeconds != null) 'rest_seconds': restSeconds,
      if (reps != null) 'reps': reps,
      if (sets != null) 'sets': sets,
    });
  }

  ExercisesCompanion copyWith({
    Value<int>? id,
    Value<int>? weekId,
    Value<String>? name,
    Value<int>? orderIndex,
    Value<DayPart>? dayPart,
    Value<ExerciseType>? type,
    Value<String?>? description,
    Value<List<String>?>? steps,
    Value<int>? squeezeSeconds,
    Value<int>? holdSeconds,
    Value<int>? releaseSeconds,
    Value<int>? restSeconds,
    Value<int>? reps,
    Value<int>? sets,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      weekId: weekId ?? this.weekId,
      name: name ?? this.name,
      orderIndex: orderIndex ?? this.orderIndex,
      dayPart: dayPart ?? this.dayPart,
      type: type ?? this.type,
      description: description ?? this.description,
      steps: steps ?? this.steps,
      squeezeSeconds: squeezeSeconds ?? this.squeezeSeconds,
      holdSeconds: holdSeconds ?? this.holdSeconds,
      releaseSeconds: releaseSeconds ?? this.releaseSeconds,
      restSeconds: restSeconds ?? this.restSeconds,
      reps: reps ?? this.reps,
      sets: sets ?? this.sets,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (weekId.present) {
      map['week_id'] = Variable<int>(weekId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (dayPart.present) {
      map['day_part'] = Variable<String>(
        $ExercisesTable.$converterdayPart.toSql(dayPart.value),
      );
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $ExercisesTable.$convertertype.toSql(type.value),
      );
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (steps.present) {
      map['steps'] = Variable<String>(
        $ExercisesTable.$converterstepsn.toSql(steps.value),
      );
    }
    if (squeezeSeconds.present) {
      map['squeeze_seconds'] = Variable<int>(squeezeSeconds.value);
    }
    if (holdSeconds.present) {
      map['hold_seconds'] = Variable<int>(holdSeconds.value);
    }
    if (releaseSeconds.present) {
      map['release_seconds'] = Variable<int>(releaseSeconds.value);
    }
    if (restSeconds.present) {
      map['rest_seconds'] = Variable<int>(restSeconds.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (sets.present) {
      map['sets'] = Variable<int>(sets.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('weekId: $weekId, ')
          ..write('name: $name, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('dayPart: $dayPart, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('steps: $steps, ')
          ..write('squeezeSeconds: $squeezeSeconds, ')
          ..write('holdSeconds: $holdSeconds, ')
          ..write('releaseSeconds: $releaseSeconds, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('reps: $reps, ')
          ..write('sets: $sets')
          ..write(')'))
        .toString();
  }
}

class $CompletionLogsTable extends CompletionLogs
    with TableInfo<$CompletionLogsTable, CompletionLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompletionLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _weekIdMeta = const VerificationMeta('weekId');
  @override
  late final GeneratedColumn<int> weekId = GeneratedColumn<int>(
    'week_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weeks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SessionType, String> session =
      GeneratedColumn<String>(
        'session',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SessionType>($CompletionLogsTable.$convertersession);
  static const VerificationMeta _holdSecondsAchievedMeta =
      const VerificationMeta('holdSecondsAchieved');
  @override
  late final GeneratedColumn<int> holdSecondsAchieved = GeneratedColumn<int>(
    'hold_seconds_achieved',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    weekId,
    completedAt,
    session,
    holdSecondsAchieved,
    durationSeconds,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'completion_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompletionLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    }
    if (data.containsKey('week_id')) {
      context.handle(
        _weekIdMeta,
        weekId.isAcceptableOrUnknown(data['week_id']!, _weekIdMeta),
      );
    } else if (isInserting) {
      context.missing(_weekIdMeta);
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
    if (data.containsKey('hold_seconds_achieved')) {
      context.handle(
        _holdSecondsAchievedMeta,
        holdSecondsAchieved.isAcceptableOrUnknown(
          data['hold_seconds_achieved']!,
          _holdSecondsAchievedMeta,
        ),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
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
  CompletionLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompletionLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      ),
      weekId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_id'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      session: $CompletionLogsTable.$convertersession.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}session'],
        )!,
      ),
      holdSecondsAchieved: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hold_seconds_achieved'],
      ),
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $CompletionLogsTable createAlias(String alias) {
    return $CompletionLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SessionType, String, String> $convertersession =
      const EnumNameConverter<SessionType>(SessionType.values);
}

class CompletionLog extends DataClass implements Insertable<CompletionLog> {
  final int id;
  final int? exerciseId;
  final int weekId;
  final DateTime completedAt;
  final SessionType session;
  final int? holdSecondsAchieved;
  final int? durationSeconds;
  final String? note;
  const CompletionLog({
    required this.id,
    this.exerciseId,
    required this.weekId,
    required this.completedAt,
    required this.session,
    this.holdSecondsAchieved,
    this.durationSeconds,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || exerciseId != null) {
      map['exercise_id'] = Variable<int>(exerciseId);
    }
    map['week_id'] = Variable<int>(weekId);
    map['completed_at'] = Variable<DateTime>(completedAt);
    {
      map['session'] = Variable<String>(
        $CompletionLogsTable.$convertersession.toSql(session),
      );
    }
    if (!nullToAbsent || holdSecondsAchieved != null) {
      map['hold_seconds_achieved'] = Variable<int>(holdSecondsAchieved);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  CompletionLogsCompanion toCompanion(bool nullToAbsent) {
    return CompletionLogsCompanion(
      id: Value(id),
      exerciseId: exerciseId == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseId),
      weekId: Value(weekId),
      completedAt: Value(completedAt),
      session: Value(session),
      holdSecondsAchieved: holdSecondsAchieved == null && nullToAbsent
          ? const Value.absent()
          : Value(holdSecondsAchieved),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory CompletionLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompletionLog(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<int?>(json['exerciseId']),
      weekId: serializer.fromJson<int>(json['weekId']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      session: $CompletionLogsTable.$convertersession.fromJson(
        serializer.fromJson<String>(json['session']),
      ),
      holdSecondsAchieved: serializer.fromJson<int?>(
        json['holdSecondsAchieved'],
      ),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<int?>(exerciseId),
      'weekId': serializer.toJson<int>(weekId),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'session': serializer.toJson<String>(
        $CompletionLogsTable.$convertersession.toJson(session),
      ),
      'holdSecondsAchieved': serializer.toJson<int?>(holdSecondsAchieved),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'note': serializer.toJson<String?>(note),
    };
  }

  CompletionLog copyWith({
    int? id,
    Value<int?> exerciseId = const Value.absent(),
    int? weekId,
    DateTime? completedAt,
    SessionType? session,
    Value<int?> holdSecondsAchieved = const Value.absent(),
    Value<int?> durationSeconds = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => CompletionLog(
    id: id ?? this.id,
    exerciseId: exerciseId.present ? exerciseId.value : this.exerciseId,
    weekId: weekId ?? this.weekId,
    completedAt: completedAt ?? this.completedAt,
    session: session ?? this.session,
    holdSecondsAchieved: holdSecondsAchieved.present
        ? holdSecondsAchieved.value
        : this.holdSecondsAchieved,
    durationSeconds: durationSeconds.present
        ? durationSeconds.value
        : this.durationSeconds,
    note: note.present ? note.value : this.note,
  );
  CompletionLog copyWithCompanion(CompletionLogsCompanion data) {
    return CompletionLog(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      weekId: data.weekId.present ? data.weekId.value : this.weekId,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      session: data.session.present ? data.session.value : this.session,
      holdSecondsAchieved: data.holdSecondsAchieved.present
          ? data.holdSecondsAchieved.value
          : this.holdSecondsAchieved,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompletionLog(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('weekId: $weekId, ')
          ..write('completedAt: $completedAt, ')
          ..write('session: $session, ')
          ..write('holdSecondsAchieved: $holdSecondsAchieved, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    exerciseId,
    weekId,
    completedAt,
    session,
    holdSecondsAchieved,
    durationSeconds,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompletionLog &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.weekId == this.weekId &&
          other.completedAt == this.completedAt &&
          other.session == this.session &&
          other.holdSecondsAchieved == this.holdSecondsAchieved &&
          other.durationSeconds == this.durationSeconds &&
          other.note == this.note);
}

class CompletionLogsCompanion extends UpdateCompanion<CompletionLog> {
  final Value<int> id;
  final Value<int?> exerciseId;
  final Value<int> weekId;
  final Value<DateTime> completedAt;
  final Value<SessionType> session;
  final Value<int?> holdSecondsAchieved;
  final Value<int?> durationSeconds;
  final Value<String?> note;
  const CompletionLogsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.weekId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.session = const Value.absent(),
    this.holdSecondsAchieved = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.note = const Value.absent(),
  });
  CompletionLogsCompanion.insert({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    required int weekId,
    this.completedAt = const Value.absent(),
    required SessionType session,
    this.holdSecondsAchieved = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.note = const Value.absent(),
  }) : weekId = Value(weekId),
       session = Value(session);
  static Insertable<CompletionLog> custom({
    Expression<int>? id,
    Expression<int>? exerciseId,
    Expression<int>? weekId,
    Expression<DateTime>? completedAt,
    Expression<String>? session,
    Expression<int>? holdSecondsAchieved,
    Expression<int>? durationSeconds,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (weekId != null) 'week_id': weekId,
      if (completedAt != null) 'completed_at': completedAt,
      if (session != null) 'session': session,
      if (holdSecondsAchieved != null)
        'hold_seconds_achieved': holdSecondsAchieved,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (note != null) 'note': note,
    });
  }

  CompletionLogsCompanion copyWith({
    Value<int>? id,
    Value<int?>? exerciseId,
    Value<int>? weekId,
    Value<DateTime>? completedAt,
    Value<SessionType>? session,
    Value<int?>? holdSecondsAchieved,
    Value<int?>? durationSeconds,
    Value<String?>? note,
  }) {
    return CompletionLogsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      weekId: weekId ?? this.weekId,
      completedAt: completedAt ?? this.completedAt,
      session: session ?? this.session,
      holdSecondsAchieved: holdSecondsAchieved ?? this.holdSecondsAchieved,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (weekId.present) {
      map['week_id'] = Variable<int>(weekId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (session.present) {
      map['session'] = Variable<String>(
        $CompletionLogsTable.$convertersession.toSql(session.value),
      );
    }
    if (holdSecondsAchieved.present) {
      map['hold_seconds_achieved'] = Variable<int>(holdSecondsAchieved.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompletionLogsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('weekId: $weekId, ')
          ..write('completedAt: $completedAt, ')
          ..write('session: $session, ')
          ..write('holdSecondsAchieved: $holdSecondsAchieved, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $BadgesTable extends Badges with TableInfo<$BadgesTable, Badge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BadgesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
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
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isUnlockedMeta = const VerificationMeta(
    'isUnlocked',
  );
  @override
  late final GeneratedColumn<bool> isUnlocked = GeneratedColumn<bool>(
    'is_unlocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_unlocked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    title,
    description,
    iconName,
    isUnlocked,
    unlockedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'badges';
  @override
  VerificationContext validateIntegrity(
    Insertable<Badge> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
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
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    }
    if (data.containsKey('is_unlocked')) {
      context.handle(
        _isUnlockedMeta,
        isUnlocked.isAcceptableOrUnknown(data['is_unlocked']!, _isUnlockedMeta),
      );
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Badge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Badge(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      ),
      isUnlocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_unlocked'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      ),
    );
  }

  @override
  $BadgesTable createAlias(String alias) {
    return $BadgesTable(attachedDatabase, alias);
  }
}

class Badge extends DataClass implements Insertable<Badge> {
  final int id;
  final String code;
  final String title;
  final String description;

  /// Name of the icon to render in the achievements grid (e.g. a Material icon
  /// key or asset name). Nullable so older seeds remain valid.
  final String? iconName;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  const Badge({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    this.iconName,
    required this.isUnlocked,
    this.unlockedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    map['is_unlocked'] = Variable<bool>(isUnlocked);
    if (!nullToAbsent || unlockedAt != null) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    }
    return map;
  }

  BadgesCompanion toCompanion(bool nullToAbsent) {
    return BadgesCompanion(
      id: Value(id),
      code: Value(code),
      title: Value(title),
      description: Value(description),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
      isUnlocked: Value(isUnlocked),
      unlockedAt: unlockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedAt),
    );
  }

  factory Badge.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Badge(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      iconName: serializer.fromJson<String?>(json['iconName']),
      isUnlocked: serializer.fromJson<bool>(json['isUnlocked']),
      unlockedAt: serializer.fromJson<DateTime?>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'iconName': serializer.toJson<String?>(iconName),
      'isUnlocked': serializer.toJson<bool>(isUnlocked),
      'unlockedAt': serializer.toJson<DateTime?>(unlockedAt),
    };
  }

  Badge copyWith({
    int? id,
    String? code,
    String? title,
    String? description,
    Value<String?> iconName = const Value.absent(),
    bool? isUnlocked,
    Value<DateTime?> unlockedAt = const Value.absent(),
  }) => Badge(
    id: id ?? this.id,
    code: code ?? this.code,
    title: title ?? this.title,
    description: description ?? this.description,
    iconName: iconName.present ? iconName.value : this.iconName,
    isUnlocked: isUnlocked ?? this.isUnlocked,
    unlockedAt: unlockedAt.present ? unlockedAt.value : this.unlockedAt,
  );
  Badge copyWithCompanion(BadgesCompanion data) {
    return Badge(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      isUnlocked: data.isUnlocked.present
          ? data.isUnlocked.value
          : this.isUnlocked,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Badge(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('iconName: $iconName, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    title,
    description,
    iconName,
    isUnlocked,
    unlockedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Badge &&
          other.id == this.id &&
          other.code == this.code &&
          other.title == this.title &&
          other.description == this.description &&
          other.iconName == this.iconName &&
          other.isUnlocked == this.isUnlocked &&
          other.unlockedAt == this.unlockedAt);
}

class BadgesCompanion extends UpdateCompanion<Badge> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> title;
  final Value<String> description;
  final Value<String?> iconName;
  final Value<bool> isUnlocked;
  final Value<DateTime?> unlockedAt;
  const BadgesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.iconName = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
  });
  BadgesCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String title,
    required String description,
    this.iconName = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
  }) : code = Value(code),
       title = Value(title),
       description = Value(description);
  static Insertable<Badge> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? iconName,
    Expression<bool>? isUnlocked,
    Expression<DateTime>? unlockedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (iconName != null) 'icon_name': iconName,
      if (isUnlocked != null) 'is_unlocked': isUnlocked,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
    });
  }

  BadgesCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? title,
    Value<String>? description,
    Value<String?>? iconName,
    Value<bool>? isUnlocked,
    Value<DateTime?>? unlockedAt,
  }) {
    return BadgesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (isUnlocked.present) {
      map['is_unlocked'] = Variable<bool>(isUnlocked.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BadgesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('iconName: $iconName, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ThemeMode, String> themeMode =
      GeneratedColumn<String>(
        'theme_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(ThemeMode.system.name),
      ).withConverter<ThemeMode>($AppSettingsTable.$converterthemeMode);
  static const VerificationMeta _forceUnlockAllMeta = const VerificationMeta(
    'forceUnlockAll',
  );
  @override
  late final GeneratedColumn<bool> forceUnlockAll = GeneratedColumn<bool>(
    'force_unlock_all',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("force_unlock_all" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _weeklySummaryEnabledMeta =
      const VerificationMeta('weeklySummaryEnabled');
  @override
  late final GeneratedColumn<bool> weeklySummaryEnabled = GeneratedColumn<bool>(
    'weekly_summary_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("weekly_summary_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _reminderTimesCsvMeta = const VerificationMeta(
    'reminderTimesCsv',
  );
  @override
  late final GeneratedColumn<String> reminderTimesCsv = GeneratedColumn<String>(
    'reminder_times_csv',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('08:00,20:00'),
  );
  static const VerificationMeta _remindersEnabledMeta = const VerificationMeta(
    'remindersEnabled',
  );
  @override
  late final GeneratedColumn<bool> remindersEnabled = GeneratedColumn<bool>(
    'reminders_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminders_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _morningReminderTimeMeta =
      const VerificationMeta('morningReminderTime');
  @override
  late final GeneratedColumn<String> morningReminderTime =
      GeneratedColumn<String>(
        'morning_reminder_time',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('08:00'),
      );
  static const VerificationMeta _eveningReminderTimeMeta =
      const VerificationMeta('eveningReminderTime');
  @override
  late final GeneratedColumn<String> eveningReminderTime =
      GeneratedColumn<String>(
        'evening_reminder_time',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('20:00'),
      );
  static const VerificationMeta _weeklyReportEnabledMeta =
      const VerificationMeta('weeklyReportEnabled');
  @override
  late final GeneratedColumn<bool> weeklyReportEnabled = GeneratedColumn<bool>(
    'weekly_report_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("weekly_report_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _streakCountMeta = const VerificationMeta(
    'streakCount',
  );
  @override
  late final GeneratedColumn<int> streakCount = GeneratedColumn<int>(
    'streak_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _longestStreakMeta = const VerificationMeta(
    'longestStreak',
  );
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
    'longest_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastActiveDateMeta = const VerificationMeta(
    'lastActiveDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastActiveDate =
      GeneratedColumn<DateTime>(
        'last_active_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _currentWeekIdMeta = const VerificationMeta(
    'currentWeekId',
  );
  @override
  late final GeneratedColumn<int> currentWeekId = GeneratedColumn<int>(
    'current_week_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _levelSystemEnabledMeta =
      const VerificationMeta('levelSystemEnabled');
  @override
  late final GeneratedColumn<bool> levelSystemEnabled = GeneratedColumn<bool>(
    'level_system_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("level_system_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    themeMode,
    forceUnlockAll,
    weeklySummaryEnabled,
    reminderTimesCsv,
    remindersEnabled,
    morningReminderTime,
    eveningReminderTime,
    weeklyReportEnabled,
    streakCount,
    longestStreak,
    lastActiveDate,
    currentWeekId,
    levelSystemEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('force_unlock_all')) {
      context.handle(
        _forceUnlockAllMeta,
        forceUnlockAll.isAcceptableOrUnknown(
          data['force_unlock_all']!,
          _forceUnlockAllMeta,
        ),
      );
    }
    if (data.containsKey('weekly_summary_enabled')) {
      context.handle(
        _weeklySummaryEnabledMeta,
        weeklySummaryEnabled.isAcceptableOrUnknown(
          data['weekly_summary_enabled']!,
          _weeklySummaryEnabledMeta,
        ),
      );
    }
    if (data.containsKey('reminder_times_csv')) {
      context.handle(
        _reminderTimesCsvMeta,
        reminderTimesCsv.isAcceptableOrUnknown(
          data['reminder_times_csv']!,
          _reminderTimesCsvMeta,
        ),
      );
    }
    if (data.containsKey('reminders_enabled')) {
      context.handle(
        _remindersEnabledMeta,
        remindersEnabled.isAcceptableOrUnknown(
          data['reminders_enabled']!,
          _remindersEnabledMeta,
        ),
      );
    }
    if (data.containsKey('morning_reminder_time')) {
      context.handle(
        _morningReminderTimeMeta,
        morningReminderTime.isAcceptableOrUnknown(
          data['morning_reminder_time']!,
          _morningReminderTimeMeta,
        ),
      );
    }
    if (data.containsKey('evening_reminder_time')) {
      context.handle(
        _eveningReminderTimeMeta,
        eveningReminderTime.isAcceptableOrUnknown(
          data['evening_reminder_time']!,
          _eveningReminderTimeMeta,
        ),
      );
    }
    if (data.containsKey('weekly_report_enabled')) {
      context.handle(
        _weeklyReportEnabledMeta,
        weeklyReportEnabled.isAcceptableOrUnknown(
          data['weekly_report_enabled']!,
          _weeklyReportEnabledMeta,
        ),
      );
    }
    if (data.containsKey('streak_count')) {
      context.handle(
        _streakCountMeta,
        streakCount.isAcceptableOrUnknown(
          data['streak_count']!,
          _streakCountMeta,
        ),
      );
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
        _longestStreakMeta,
        longestStreak.isAcceptableOrUnknown(
          data['longest_streak']!,
          _longestStreakMeta,
        ),
      );
    }
    if (data.containsKey('last_active_date')) {
      context.handle(
        _lastActiveDateMeta,
        lastActiveDate.isAcceptableOrUnknown(
          data['last_active_date']!,
          _lastActiveDateMeta,
        ),
      );
    }
    if (data.containsKey('current_week_id')) {
      context.handle(
        _currentWeekIdMeta,
        currentWeekId.isAcceptableOrUnknown(
          data['current_week_id']!,
          _currentWeekIdMeta,
        ),
      );
    }
    if (data.containsKey('level_system_enabled')) {
      context.handle(
        _levelSystemEnabledMeta,
        levelSystemEnabled.isAcceptableOrUnknown(
          data['level_system_enabled']!,
          _levelSystemEnabledMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      themeMode: $AppSettingsTable.$converterthemeMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}theme_mode'],
        )!,
      ),
      forceUnlockAll: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}force_unlock_all'],
      )!,
      weeklySummaryEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}weekly_summary_enabled'],
      )!,
      reminderTimesCsv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_times_csv'],
      )!,
      remindersEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminders_enabled'],
      )!,
      morningReminderTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}morning_reminder_time'],
      )!,
      eveningReminderTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}evening_reminder_time'],
      )!,
      weeklyReportEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}weekly_report_enabled'],
      )!,
      streakCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak_count'],
      )!,
      longestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}longest_streak'],
      )!,
      lastActiveDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_active_date'],
      ),
      currentWeekId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_week_id'],
      ),
      levelSystemEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}level_system_enabled'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ThemeMode, String, String> $converterthemeMode =
      const EnumNameConverter<ThemeMode>(ThemeMode.values);
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final ThemeMode themeMode;
  final bool forceUnlockAll;
  final bool weeklySummaryEnabled;
  final String reminderTimesCsv;
  final bool remindersEnabled;
  final String morningReminderTime;
  final String eveningReminderTime;
  final bool weeklyReportEnabled;
  final int streakCount;
  final int longestStreak;
  final DateTime? lastActiveDate;

  /// The week the user is currently tracking (FK-ish pointer into Weeks).
  final int? currentWeekId;

  /// Whether the 70% level-gating system is enforced.
  final bool levelSystemEnabled;
  const AppSetting({
    required this.id,
    required this.themeMode,
    required this.forceUnlockAll,
    required this.weeklySummaryEnabled,
    required this.reminderTimesCsv,
    required this.remindersEnabled,
    required this.morningReminderTime,
    required this.eveningReminderTime,
    required this.weeklyReportEnabled,
    required this.streakCount,
    required this.longestStreak,
    this.lastActiveDate,
    this.currentWeekId,
    required this.levelSystemEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['theme_mode'] = Variable<String>(
        $AppSettingsTable.$converterthemeMode.toSql(themeMode),
      );
    }
    map['force_unlock_all'] = Variable<bool>(forceUnlockAll);
    map['weekly_summary_enabled'] = Variable<bool>(weeklySummaryEnabled);
    map['reminder_times_csv'] = Variable<String>(reminderTimesCsv);
    map['reminders_enabled'] = Variable<bool>(remindersEnabled);
    map['morning_reminder_time'] = Variable<String>(morningReminderTime);
    map['evening_reminder_time'] = Variable<String>(eveningReminderTime);
    map['weekly_report_enabled'] = Variable<bool>(weeklyReportEnabled);
    map['streak_count'] = Variable<int>(streakCount);
    map['longest_streak'] = Variable<int>(longestStreak);
    if (!nullToAbsent || lastActiveDate != null) {
      map['last_active_date'] = Variable<DateTime>(lastActiveDate);
    }
    if (!nullToAbsent || currentWeekId != null) {
      map['current_week_id'] = Variable<int>(currentWeekId);
    }
    map['level_system_enabled'] = Variable<bool>(levelSystemEnabled);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      forceUnlockAll: Value(forceUnlockAll),
      weeklySummaryEnabled: Value(weeklySummaryEnabled),
      reminderTimesCsv: Value(reminderTimesCsv),
      remindersEnabled: Value(remindersEnabled),
      morningReminderTime: Value(morningReminderTime),
      eveningReminderTime: Value(eveningReminderTime),
      weeklyReportEnabled: Value(weeklyReportEnabled),
      streakCount: Value(streakCount),
      longestStreak: Value(longestStreak),
      lastActiveDate: lastActiveDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastActiveDate),
      currentWeekId: currentWeekId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentWeekId),
      levelSystemEnabled: Value(levelSystemEnabled),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      themeMode: $AppSettingsTable.$converterthemeMode.fromJson(
        serializer.fromJson<String>(json['themeMode']),
      ),
      forceUnlockAll: serializer.fromJson<bool>(json['forceUnlockAll']),
      weeklySummaryEnabled: serializer.fromJson<bool>(
        json['weeklySummaryEnabled'],
      ),
      reminderTimesCsv: serializer.fromJson<String>(json['reminderTimesCsv']),
      remindersEnabled: serializer.fromJson<bool>(json['remindersEnabled']),
      morningReminderTime: serializer.fromJson<String>(
        json['morningReminderTime'],
      ),
      eveningReminderTime: serializer.fromJson<String>(
        json['eveningReminderTime'],
      ),
      weeklyReportEnabled: serializer.fromJson<bool>(
        json['weeklyReportEnabled'],
      ),
      streakCount: serializer.fromJson<int>(json['streakCount']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      lastActiveDate: serializer.fromJson<DateTime?>(json['lastActiveDate']),
      currentWeekId: serializer.fromJson<int?>(json['currentWeekId']),
      levelSystemEnabled: serializer.fromJson<bool>(json['levelSystemEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer.toJson<String>(
        $AppSettingsTable.$converterthemeMode.toJson(themeMode),
      ),
      'forceUnlockAll': serializer.toJson<bool>(forceUnlockAll),
      'weeklySummaryEnabled': serializer.toJson<bool>(weeklySummaryEnabled),
      'reminderTimesCsv': serializer.toJson<String>(reminderTimesCsv),
      'remindersEnabled': serializer.toJson<bool>(remindersEnabled),
      'morningReminderTime': serializer.toJson<String>(morningReminderTime),
      'eveningReminderTime': serializer.toJson<String>(eveningReminderTime),
      'weeklyReportEnabled': serializer.toJson<bool>(weeklyReportEnabled),
      'streakCount': serializer.toJson<int>(streakCount),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'lastActiveDate': serializer.toJson<DateTime?>(lastActiveDate),
      'currentWeekId': serializer.toJson<int?>(currentWeekId),
      'levelSystemEnabled': serializer.toJson<bool>(levelSystemEnabled),
    };
  }

  AppSetting copyWith({
    int? id,
    ThemeMode? themeMode,
    bool? forceUnlockAll,
    bool? weeklySummaryEnabled,
    String? reminderTimesCsv,
    bool? remindersEnabled,
    String? morningReminderTime,
    String? eveningReminderTime,
    bool? weeklyReportEnabled,
    int? streakCount,
    int? longestStreak,
    Value<DateTime?> lastActiveDate = const Value.absent(),
    Value<int?> currentWeekId = const Value.absent(),
    bool? levelSystemEnabled,
  }) => AppSetting(
    id: id ?? this.id,
    themeMode: themeMode ?? this.themeMode,
    forceUnlockAll: forceUnlockAll ?? this.forceUnlockAll,
    weeklySummaryEnabled: weeklySummaryEnabled ?? this.weeklySummaryEnabled,
    reminderTimesCsv: reminderTimesCsv ?? this.reminderTimesCsv,
    remindersEnabled: remindersEnabled ?? this.remindersEnabled,
    morningReminderTime: morningReminderTime ?? this.morningReminderTime,
    eveningReminderTime: eveningReminderTime ?? this.eveningReminderTime,
    weeklyReportEnabled: weeklyReportEnabled ?? this.weeklyReportEnabled,
    streakCount: streakCount ?? this.streakCount,
    longestStreak: longestStreak ?? this.longestStreak,
    lastActiveDate: lastActiveDate.present
        ? lastActiveDate.value
        : this.lastActiveDate,
    currentWeekId: currentWeekId.present
        ? currentWeekId.value
        : this.currentWeekId,
    levelSystemEnabled: levelSystemEnabled ?? this.levelSystemEnabled,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      forceUnlockAll: data.forceUnlockAll.present
          ? data.forceUnlockAll.value
          : this.forceUnlockAll,
      weeklySummaryEnabled: data.weeklySummaryEnabled.present
          ? data.weeklySummaryEnabled.value
          : this.weeklySummaryEnabled,
      reminderTimesCsv: data.reminderTimesCsv.present
          ? data.reminderTimesCsv.value
          : this.reminderTimesCsv,
      remindersEnabled: data.remindersEnabled.present
          ? data.remindersEnabled.value
          : this.remindersEnabled,
      morningReminderTime: data.morningReminderTime.present
          ? data.morningReminderTime.value
          : this.morningReminderTime,
      eveningReminderTime: data.eveningReminderTime.present
          ? data.eveningReminderTime.value
          : this.eveningReminderTime,
      weeklyReportEnabled: data.weeklyReportEnabled.present
          ? data.weeklyReportEnabled.value
          : this.weeklyReportEnabled,
      streakCount: data.streakCount.present
          ? data.streakCount.value
          : this.streakCount,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      lastActiveDate: data.lastActiveDate.present
          ? data.lastActiveDate.value
          : this.lastActiveDate,
      currentWeekId: data.currentWeekId.present
          ? data.currentWeekId.value
          : this.currentWeekId,
      levelSystemEnabled: data.levelSystemEnabled.present
          ? data.levelSystemEnabled.value
          : this.levelSystemEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('forceUnlockAll: $forceUnlockAll, ')
          ..write('weeklySummaryEnabled: $weeklySummaryEnabled, ')
          ..write('reminderTimesCsv: $reminderTimesCsv, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('morningReminderTime: $morningReminderTime, ')
          ..write('eveningReminderTime: $eveningReminderTime, ')
          ..write('weeklyReportEnabled: $weeklyReportEnabled, ')
          ..write('streakCount: $streakCount, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastActiveDate: $lastActiveDate, ')
          ..write('currentWeekId: $currentWeekId, ')
          ..write('levelSystemEnabled: $levelSystemEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    themeMode,
    forceUnlockAll,
    weeklySummaryEnabled,
    reminderTimesCsv,
    remindersEnabled,
    morningReminderTime,
    eveningReminderTime,
    weeklyReportEnabled,
    streakCount,
    longestStreak,
    lastActiveDate,
    currentWeekId,
    levelSystemEnabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.forceUnlockAll == this.forceUnlockAll &&
          other.weeklySummaryEnabled == this.weeklySummaryEnabled &&
          other.reminderTimesCsv == this.reminderTimesCsv &&
          other.remindersEnabled == this.remindersEnabled &&
          other.morningReminderTime == this.morningReminderTime &&
          other.eveningReminderTime == this.eveningReminderTime &&
          other.weeklyReportEnabled == this.weeklyReportEnabled &&
          other.streakCount == this.streakCount &&
          other.longestStreak == this.longestStreak &&
          other.lastActiveDate == this.lastActiveDate &&
          other.currentWeekId == this.currentWeekId &&
          other.levelSystemEnabled == this.levelSystemEnabled);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<ThemeMode> themeMode;
  final Value<bool> forceUnlockAll;
  final Value<bool> weeklySummaryEnabled;
  final Value<String> reminderTimesCsv;
  final Value<bool> remindersEnabled;
  final Value<String> morningReminderTime;
  final Value<String> eveningReminderTime;
  final Value<bool> weeklyReportEnabled;
  final Value<int> streakCount;
  final Value<int> longestStreak;
  final Value<DateTime?> lastActiveDate;
  final Value<int?> currentWeekId;
  final Value<bool> levelSystemEnabled;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.forceUnlockAll = const Value.absent(),
    this.weeklySummaryEnabled = const Value.absent(),
    this.reminderTimesCsv = const Value.absent(),
    this.remindersEnabled = const Value.absent(),
    this.morningReminderTime = const Value.absent(),
    this.eveningReminderTime = const Value.absent(),
    this.weeklyReportEnabled = const Value.absent(),
    this.streakCount = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
    this.currentWeekId = const Value.absent(),
    this.levelSystemEnabled = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.forceUnlockAll = const Value.absent(),
    this.weeklySummaryEnabled = const Value.absent(),
    this.reminderTimesCsv = const Value.absent(),
    this.remindersEnabled = const Value.absent(),
    this.morningReminderTime = const Value.absent(),
    this.eveningReminderTime = const Value.absent(),
    this.weeklyReportEnabled = const Value.absent(),
    this.streakCount = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
    this.currentWeekId = const Value.absent(),
    this.levelSystemEnabled = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? themeMode,
    Expression<bool>? forceUnlockAll,
    Expression<bool>? weeklySummaryEnabled,
    Expression<String>? reminderTimesCsv,
    Expression<bool>? remindersEnabled,
    Expression<String>? morningReminderTime,
    Expression<String>? eveningReminderTime,
    Expression<bool>? weeklyReportEnabled,
    Expression<int>? streakCount,
    Expression<int>? longestStreak,
    Expression<DateTime>? lastActiveDate,
    Expression<int>? currentWeekId,
    Expression<bool>? levelSystemEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (forceUnlockAll != null) 'force_unlock_all': forceUnlockAll,
      if (weeklySummaryEnabled != null)
        'weekly_summary_enabled': weeklySummaryEnabled,
      if (reminderTimesCsv != null) 'reminder_times_csv': reminderTimesCsv,
      if (remindersEnabled != null) 'reminders_enabled': remindersEnabled,
      if (morningReminderTime != null)
        'morning_reminder_time': morningReminderTime,
      if (eveningReminderTime != null)
        'evening_reminder_time': eveningReminderTime,
      if (weeklyReportEnabled != null)
        'weekly_report_enabled': weeklyReportEnabled,
      if (streakCount != null) 'streak_count': streakCount,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (lastActiveDate != null) 'last_active_date': lastActiveDate,
      if (currentWeekId != null) 'current_week_id': currentWeekId,
      if (levelSystemEnabled != null)
        'level_system_enabled': levelSystemEnabled,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<ThemeMode>? themeMode,
    Value<bool>? forceUnlockAll,
    Value<bool>? weeklySummaryEnabled,
    Value<String>? reminderTimesCsv,
    Value<bool>? remindersEnabled,
    Value<String>? morningReminderTime,
    Value<String>? eveningReminderTime,
    Value<bool>? weeklyReportEnabled,
    Value<int>? streakCount,
    Value<int>? longestStreak,
    Value<DateTime?>? lastActiveDate,
    Value<int?>? currentWeekId,
    Value<bool>? levelSystemEnabled,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      forceUnlockAll: forceUnlockAll ?? this.forceUnlockAll,
      weeklySummaryEnabled: weeklySummaryEnabled ?? this.weeklySummaryEnabled,
      reminderTimesCsv: reminderTimesCsv ?? this.reminderTimesCsv,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      morningReminderTime: morningReminderTime ?? this.morningReminderTime,
      eveningReminderTime: eveningReminderTime ?? this.eveningReminderTime,
      weeklyReportEnabled: weeklyReportEnabled ?? this.weeklyReportEnabled,
      streakCount: streakCount ?? this.streakCount,
      longestStreak: longestStreak ?? this.longestStreak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      currentWeekId: currentWeekId ?? this.currentWeekId,
      levelSystemEnabled: levelSystemEnabled ?? this.levelSystemEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(
        $AppSettingsTable.$converterthemeMode.toSql(themeMode.value),
      );
    }
    if (forceUnlockAll.present) {
      map['force_unlock_all'] = Variable<bool>(forceUnlockAll.value);
    }
    if (weeklySummaryEnabled.present) {
      map['weekly_summary_enabled'] = Variable<bool>(
        weeklySummaryEnabled.value,
      );
    }
    if (reminderTimesCsv.present) {
      map['reminder_times_csv'] = Variable<String>(reminderTimesCsv.value);
    }
    if (remindersEnabled.present) {
      map['reminders_enabled'] = Variable<bool>(remindersEnabled.value);
    }
    if (morningReminderTime.present) {
      map['morning_reminder_time'] = Variable<String>(
        morningReminderTime.value,
      );
    }
    if (eveningReminderTime.present) {
      map['evening_reminder_time'] = Variable<String>(
        eveningReminderTime.value,
      );
    }
    if (weeklyReportEnabled.present) {
      map['weekly_report_enabled'] = Variable<bool>(weeklyReportEnabled.value);
    }
    if (streakCount.present) {
      map['streak_count'] = Variable<int>(streakCount.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (lastActiveDate.present) {
      map['last_active_date'] = Variable<DateTime>(lastActiveDate.value);
    }
    if (currentWeekId.present) {
      map['current_week_id'] = Variable<int>(currentWeekId.value);
    }
    if (levelSystemEnabled.present) {
      map['level_system_enabled'] = Variable<bool>(levelSystemEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('forceUnlockAll: $forceUnlockAll, ')
          ..write('weeklySummaryEnabled: $weeklySummaryEnabled, ')
          ..write('reminderTimesCsv: $reminderTimesCsv, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('morningReminderTime: $morningReminderTime, ')
          ..write('eveningReminderTime: $eveningReminderTime, ')
          ..write('weeklyReportEnabled: $weeklyReportEnabled, ')
          ..write('streakCount: $streakCount, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastActiveDate: $lastActiveDate, ')
          ..write('currentWeekId: $currentWeekId, ')
          ..write('levelSystemEnabled: $levelSystemEnabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProgramsTable programs = $ProgramsTable(this);
  late final $WeeksTable weeks = $WeeksTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $CompletionLogsTable completionLogs = $CompletionLogsTable(this);
  late final $BadgesTable badges = $BadgesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final ProgramDao programDao = ProgramDao(this as AppDatabase);
  late final CompletionDao completionDao = CompletionDao(this as AppDatabase);
  late final BadgeDao badgeDao = BadgeDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    programs,
    weeks,
    exercises,
    completionLogs,
    badges,
    appSettings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'programs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('weeks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'weeks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('exercises', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'exercises',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('completion_logs', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'weeks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('completion_logs', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProgramsTableCreateCompanionBuilder =
    ProgramsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<bool> isBuiltIn,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$ProgramsTableUpdateCompanionBuilder =
    ProgramsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<bool> isBuiltIn,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

final class $$ProgramsTableReferences
    extends BaseReferences<_$AppDatabase, $ProgramsTable, Program> {
  $$ProgramsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WeeksTable, List<Week>> _weeksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.weeks,
    aliasName: $_aliasNameGenerator(db.programs.id, db.weeks.programId),
  );

  $$WeeksTableProcessedTableManager get weeksRefs {
    final manager = $$WeeksTableTableManager(
      $_db,
      $_db.weeks,
    ).filter((f) => f.programId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_weeksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProgramsTableFilterComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> weeksRefs(
    Expression<bool> Function($$WeeksTableFilterComposer f) f,
  ) {
    final $$WeeksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weeks,
      getReferencedColumn: (t) => t.programId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeksTableFilterComposer(
            $db: $db,
            $table: $db.weeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProgramsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgramsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> weeksRefs<T extends Object>(
    Expression<T> Function($$WeeksTableAnnotationComposer a) f,
  ) {
    final $$WeeksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weeks,
      getReferencedColumn: (t) => t.programId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeksTableAnnotationComposer(
            $db: $db,
            $table: $db.weeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProgramsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgramsTable,
          Program,
          $$ProgramsTableFilterComposer,
          $$ProgramsTableOrderingComposer,
          $$ProgramsTableAnnotationComposer,
          $$ProgramsTableCreateCompanionBuilder,
          $$ProgramsTableUpdateCompanionBuilder,
          (Program, $$ProgramsTableReferences),
          Program,
          PrefetchHooks Function({bool weeksRefs})
        > {
  $$ProgramsTableTableManager(_$AppDatabase db, $ProgramsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgramsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgramsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgramsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProgramsCompanion(
                id: id,
                name: name,
                description: description,
                isBuiltIn: isBuiltIn,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProgramsCompanion.insert(
                id: id,
                name: name,
                description: description,
                isBuiltIn: isBuiltIn,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProgramsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({weeksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (weeksRefs) db.weeks],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (weeksRefs)
                    await $_getPrefetchedData<Program, $ProgramsTable, Week>(
                      currentTable: table,
                      referencedTable: $$ProgramsTableReferences
                          ._weeksRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProgramsTableReferences(db, table, p0).weeksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.programId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProgramsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgramsTable,
      Program,
      $$ProgramsTableFilterComposer,
      $$ProgramsTableOrderingComposer,
      $$ProgramsTableAnnotationComposer,
      $$ProgramsTableCreateCompanionBuilder,
      $$ProgramsTableUpdateCompanionBuilder,
      (Program, $$ProgramsTableReferences),
      Program,
      PrefetchHooks Function({bool weeksRefs})
    >;
typedef $$WeeksTableCreateCompanionBuilder =
    WeeksCompanion Function({
      Value<int> id,
      required int programId,
      required int weekIndex,
      required int phase,
      Value<String?> title,
      Value<String?> phaseName,
      Value<bool> isUnlocked,
      Value<double> unlockThreshold,
    });
typedef $$WeeksTableUpdateCompanionBuilder =
    WeeksCompanion Function({
      Value<int> id,
      Value<int> programId,
      Value<int> weekIndex,
      Value<int> phase,
      Value<String?> title,
      Value<String?> phaseName,
      Value<bool> isUnlocked,
      Value<double> unlockThreshold,
    });

final class $$WeeksTableReferences
    extends BaseReferences<_$AppDatabase, $WeeksTable, Week> {
  $$WeeksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProgramsTable _programIdTable(_$AppDatabase db) => db.programs
      .createAlias($_aliasNameGenerator(db.weeks.programId, db.programs.id));

  $$ProgramsTableProcessedTableManager get programId {
    final $_column = $_itemColumn<int>('program_id')!;

    final manager = $$ProgramsTableTableManager(
      $_db,
      $_db.programs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_programIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExercisesTable, List<Exercise>>
  _exercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exercises,
    aliasName: $_aliasNameGenerator(db.weeks.id, db.exercises.weekId),
  );

  $$ExercisesTableProcessedTableManager get exercisesRefs {
    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.weekId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_exercisesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CompletionLogsTable, List<CompletionLog>>
  _completionLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.completionLogs,
    aliasName: $_aliasNameGenerator(db.weeks.id, db.completionLogs.weekId),
  );

  $$CompletionLogsTableProcessedTableManager get completionLogsRefs {
    final manager = $$CompletionLogsTableTableManager(
      $_db,
      $_db.completionLogs,
    ).filter((f) => f.weekId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_completionLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WeeksTableFilterComposer extends Composer<_$AppDatabase, $WeeksTable> {
  $$WeeksTableFilterComposer({
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

  ColumnFilters<int> get weekIndex => $composableBuilder(
    column: $table.weekIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phaseName => $composableBuilder(
    column: $table.phaseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unlockThreshold => $composableBuilder(
    column: $table.unlockThreshold,
    builder: (column) => ColumnFilters(column),
  );

  $$ProgramsTableFilterComposer get programId {
    final $$ProgramsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programId,
      referencedTable: $db.programs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramsTableFilterComposer(
            $db: $db,
            $table: $db.programs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> exercisesRefs(
    Expression<bool> Function($$ExercisesTableFilterComposer f) f,
  ) {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.weekId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> completionLogsRefs(
    Expression<bool> Function($$CompletionLogsTableFilterComposer f) f,
  ) {
    final $$CompletionLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.completionLogs,
      getReferencedColumn: (t) => t.weekId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompletionLogsTableFilterComposer(
            $db: $db,
            $table: $db.completionLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeeksTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeksTable> {
  $$WeeksTableOrderingComposer({
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

  ColumnOrderings<int> get weekIndex => $composableBuilder(
    column: $table.weekIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phaseName => $composableBuilder(
    column: $table.phaseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unlockThreshold => $composableBuilder(
    column: $table.unlockThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProgramsTableOrderingComposer get programId {
    final $$ProgramsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programId,
      referencedTable: $db.programs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramsTableOrderingComposer(
            $db: $db,
            $table: $db.programs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeksTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeksTable> {
  $$WeeksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get weekIndex =>
      $composableBuilder(column: $table.weekIndex, builder: (column) => column);

  GeneratedColumn<int> get phase =>
      $composableBuilder(column: $table.phase, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get phaseName =>
      $composableBuilder(column: $table.phaseName, builder: (column) => column);

  GeneratedColumn<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => column,
  );

  GeneratedColumn<double> get unlockThreshold => $composableBuilder(
    column: $table.unlockThreshold,
    builder: (column) => column,
  );

  $$ProgramsTableAnnotationComposer get programId {
    final $$ProgramsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.programId,
      referencedTable: $db.programs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProgramsTableAnnotationComposer(
            $db: $db,
            $table: $db.programs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> exercisesRefs<T extends Object>(
    Expression<T> Function($$ExercisesTableAnnotationComposer a) f,
  ) {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.weekId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> completionLogsRefs<T extends Object>(
    Expression<T> Function($$CompletionLogsTableAnnotationComposer a) f,
  ) {
    final $$CompletionLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.completionLogs,
      getReferencedColumn: (t) => t.weekId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompletionLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.completionLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeeksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeeksTable,
          Week,
          $$WeeksTableFilterComposer,
          $$WeeksTableOrderingComposer,
          $$WeeksTableAnnotationComposer,
          $$WeeksTableCreateCompanionBuilder,
          $$WeeksTableUpdateCompanionBuilder,
          (Week, $$WeeksTableReferences),
          Week,
          PrefetchHooks Function({
            bool programId,
            bool exercisesRefs,
            bool completionLogsRefs,
          })
        > {
  $$WeeksTableTableManager(_$AppDatabase db, $WeeksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> programId = const Value.absent(),
                Value<int> weekIndex = const Value.absent(),
                Value<int> phase = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> phaseName = const Value.absent(),
                Value<bool> isUnlocked = const Value.absent(),
                Value<double> unlockThreshold = const Value.absent(),
              }) => WeeksCompanion(
                id: id,
                programId: programId,
                weekIndex: weekIndex,
                phase: phase,
                title: title,
                phaseName: phaseName,
                isUnlocked: isUnlocked,
                unlockThreshold: unlockThreshold,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int programId,
                required int weekIndex,
                required int phase,
                Value<String?> title = const Value.absent(),
                Value<String?> phaseName = const Value.absent(),
                Value<bool> isUnlocked = const Value.absent(),
                Value<double> unlockThreshold = const Value.absent(),
              }) => WeeksCompanion.insert(
                id: id,
                programId: programId,
                weekIndex: weekIndex,
                phase: phase,
                title: title,
                phaseName: phaseName,
                isUnlocked: isUnlocked,
                unlockThreshold: unlockThreshold,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$WeeksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                programId = false,
                exercisesRefs = false,
                completionLogsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (exercisesRefs) db.exercises,
                    if (completionLogsRefs) db.completionLogs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (programId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.programId,
                                    referencedTable: $$WeeksTableReferences
                                        ._programIdTable(db),
                                    referencedColumn: $$WeeksTableReferences
                                        ._programIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (exercisesRefs)
                        await $_getPrefetchedData<Week, $WeeksTable, Exercise>(
                          currentTable: table,
                          referencedTable: $$WeeksTableReferences
                              ._exercisesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeeksTableReferences(
                                db,
                                table,
                                p0,
                              ).exercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.weekId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (completionLogsRefs)
                        await $_getPrefetchedData<
                          Week,
                          $WeeksTable,
                          CompletionLog
                        >(
                          currentTable: table,
                          referencedTable: $$WeeksTableReferences
                              ._completionLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeeksTableReferences(
                                db,
                                table,
                                p0,
                              ).completionLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.weekId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WeeksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeeksTable,
      Week,
      $$WeeksTableFilterComposer,
      $$WeeksTableOrderingComposer,
      $$WeeksTableAnnotationComposer,
      $$WeeksTableCreateCompanionBuilder,
      $$WeeksTableUpdateCompanionBuilder,
      (Week, $$WeeksTableReferences),
      Week,
      PrefetchHooks Function({
        bool programId,
        bool exercisesRefs,
        bool completionLogsRefs,
      })
    >;
typedef $$ExercisesTableCreateCompanionBuilder =
    ExercisesCompanion Function({
      Value<int> id,
      required int weekId,
      required String name,
      Value<int> orderIndex,
      Value<DayPart> dayPart,
      Value<ExerciseType> type,
      Value<String?> description,
      Value<List<String>?> steps,
      required int squeezeSeconds,
      required int holdSeconds,
      required int releaseSeconds,
      required int restSeconds,
      required int reps,
      Value<int> sets,
    });
typedef $$ExercisesTableUpdateCompanionBuilder =
    ExercisesCompanion Function({
      Value<int> id,
      Value<int> weekId,
      Value<String> name,
      Value<int> orderIndex,
      Value<DayPart> dayPart,
      Value<ExerciseType> type,
      Value<String?> description,
      Value<List<String>?> steps,
      Value<int> squeezeSeconds,
      Value<int> holdSeconds,
      Value<int> releaseSeconds,
      Value<int> restSeconds,
      Value<int> reps,
      Value<int> sets,
    });

final class $$ExercisesTableReferences
    extends BaseReferences<_$AppDatabase, $ExercisesTable, Exercise> {
  $$ExercisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WeeksTable _weekIdTable(_$AppDatabase db) => db.weeks.createAlias(
    $_aliasNameGenerator(db.exercises.weekId, db.weeks.id),
  );

  $$WeeksTableProcessedTableManager get weekId {
    final $_column = $_itemColumn<int>('week_id')!;

    final manager = $$WeeksTableTableManager(
      $_db,
      $_db.weeks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_weekIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CompletionLogsTable, List<CompletionLog>>
  _completionLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.completionLogs,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.completionLogs.exerciseId,
    ),
  );

  $$CompletionLogsTableProcessedTableManager get completionLogsRefs {
    final manager = $$CompletionLogsTableTableManager(
      $_db,
      $_db.completionLogs,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_completionLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DayPart, DayPart, String> get dayPart =>
      $composableBuilder(
        column: $table.dayPart,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<ExerciseType, ExerciseType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get squeezeSeconds => $composableBuilder(
    column: $table.squeezeSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get holdSeconds => $composableBuilder(
    column: $table.holdSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get releaseSeconds => $composableBuilder(
    column: $table.releaseSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnFilters(column),
  );

  $$WeeksTableFilterComposer get weekId {
    final $$WeeksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekId,
      referencedTable: $db.weeks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeksTableFilterComposer(
            $db: $db,
            $table: $db.weeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> completionLogsRefs(
    Expression<bool> Function($$CompletionLogsTableFilterComposer f) f,
  ) {
    final $$CompletionLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.completionLogs,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompletionLogsTableFilterComposer(
            $db: $db,
            $table: $db.completionLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dayPart => $composableBuilder(
    column: $table.dayPart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get squeezeSeconds => $composableBuilder(
    column: $table.squeezeSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get holdSeconds => $composableBuilder(
    column: $table.holdSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get releaseSeconds => $composableBuilder(
    column: $table.releaseSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeeksTableOrderingComposer get weekId {
    final $$WeeksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekId,
      referencedTable: $db.weeks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeksTableOrderingComposer(
            $db: $db,
            $table: $db.weeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DayPart, String> get dayPart =>
      $composableBuilder(column: $table.dayPart, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ExerciseType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>?, String> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<int> get squeezeSeconds => $composableBuilder(
    column: $table.squeezeSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get holdSeconds => $composableBuilder(
    column: $table.holdSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get releaseSeconds => $composableBuilder(
    column: $table.releaseSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get sets =>
      $composableBuilder(column: $table.sets, builder: (column) => column);

  $$WeeksTableAnnotationComposer get weekId {
    final $$WeeksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekId,
      referencedTable: $db.weeks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeksTableAnnotationComposer(
            $db: $db,
            $table: $db.weeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> completionLogsRefs<T extends Object>(
    Expression<T> Function($$CompletionLogsTableAnnotationComposer a) f,
  ) {
    final $$CompletionLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.completionLogs,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompletionLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.completionLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTable,
          Exercise,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (Exercise, $$ExercisesTableReferences),
          Exercise,
          PrefetchHooks Function({bool weekId, bool completionLogsRefs})
        > {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> weekId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<DayPart> dayPart = const Value.absent(),
                Value<ExerciseType> type = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<List<String>?> steps = const Value.absent(),
                Value<int> squeezeSeconds = const Value.absent(),
                Value<int> holdSeconds = const Value.absent(),
                Value<int> releaseSeconds = const Value.absent(),
                Value<int> restSeconds = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<int> sets = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                weekId: weekId,
                name: name,
                orderIndex: orderIndex,
                dayPart: dayPart,
                type: type,
                description: description,
                steps: steps,
                squeezeSeconds: squeezeSeconds,
                holdSeconds: holdSeconds,
                releaseSeconds: releaseSeconds,
                restSeconds: restSeconds,
                reps: reps,
                sets: sets,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int weekId,
                required String name,
                Value<int> orderIndex = const Value.absent(),
                Value<DayPart> dayPart = const Value.absent(),
                Value<ExerciseType> type = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<List<String>?> steps = const Value.absent(),
                required int squeezeSeconds,
                required int holdSeconds,
                required int releaseSeconds,
                required int restSeconds,
                required int reps,
                Value<int> sets = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                weekId: weekId,
                name: name,
                orderIndex: orderIndex,
                dayPart: dayPart,
                type: type,
                description: description,
                steps: steps,
                squeezeSeconds: squeezeSeconds,
                holdSeconds: holdSeconds,
                releaseSeconds: releaseSeconds,
                restSeconds: restSeconds,
                reps: reps,
                sets: sets,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({weekId = false, completionLogsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (completionLogsRefs) db.completionLogs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (weekId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.weekId,
                                    referencedTable: $$ExercisesTableReferences
                                        ._weekIdTable(db),
                                    referencedColumn: $$ExercisesTableReferences
                                        ._weekIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (completionLogsRefs)
                        await $_getPrefetchedData<
                          Exercise,
                          $ExercisesTable,
                          CompletionLog
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._completionLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).completionLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTable,
      Exercise,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (Exercise, $$ExercisesTableReferences),
      Exercise,
      PrefetchHooks Function({bool weekId, bool completionLogsRefs})
    >;
typedef $$CompletionLogsTableCreateCompanionBuilder =
    CompletionLogsCompanion Function({
      Value<int> id,
      Value<int?> exerciseId,
      required int weekId,
      Value<DateTime> completedAt,
      required SessionType session,
      Value<int?> holdSecondsAchieved,
      Value<int?> durationSeconds,
      Value<String?> note,
    });
typedef $$CompletionLogsTableUpdateCompanionBuilder =
    CompletionLogsCompanion Function({
      Value<int> id,
      Value<int?> exerciseId,
      Value<int> weekId,
      Value<DateTime> completedAt,
      Value<SessionType> session,
      Value<int?> holdSecondsAchieved,
      Value<int?> durationSeconds,
      Value<String?> note,
    });

final class $$CompletionLogsTableReferences
    extends BaseReferences<_$AppDatabase, $CompletionLogsTable, CompletionLog> {
  $$CompletionLogsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.completionLogs.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager? get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id');
    if ($_column == null) return null;
    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WeeksTable _weekIdTable(_$AppDatabase db) => db.weeks.createAlias(
    $_aliasNameGenerator(db.completionLogs.weekId, db.weeks.id),
  );

  $$WeeksTableProcessedTableManager get weekId {
    final $_column = $_itemColumn<int>('week_id')!;

    final manager = $$WeeksTableTableManager(
      $_db,
      $_db.weeks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_weekIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CompletionLogsTableFilterComposer
    extends Composer<_$AppDatabase, $CompletionLogsTable> {
  $$CompletionLogsTableFilterComposer({
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

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SessionType, SessionType, String>
  get session => $composableBuilder(
    column: $table.session,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get holdSecondsAchieved => $composableBuilder(
    column: $table.holdSecondsAchieved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeeksTableFilterComposer get weekId {
    final $$WeeksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekId,
      referencedTable: $db.weeks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeksTableFilterComposer(
            $db: $db,
            $table: $db.weeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompletionLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $CompletionLogsTable> {
  $$CompletionLogsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get session => $composableBuilder(
    column: $table.session,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get holdSecondsAchieved => $composableBuilder(
    column: $table.holdSecondsAchieved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeeksTableOrderingComposer get weekId {
    final $$WeeksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekId,
      referencedTable: $db.weeks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeksTableOrderingComposer(
            $db: $db,
            $table: $db.weeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompletionLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompletionLogsTable> {
  $$CompletionLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SessionType, String> get session =>
      $composableBuilder(column: $table.session, builder: (column) => column);

  GeneratedColumn<int> get holdSecondsAchieved => $composableBuilder(
    column: $table.holdSecondsAchieved,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeeksTableAnnotationComposer get weekId {
    final $$WeeksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekId,
      referencedTable: $db.weeks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeksTableAnnotationComposer(
            $db: $db,
            $table: $db.weeks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompletionLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompletionLogsTable,
          CompletionLog,
          $$CompletionLogsTableFilterComposer,
          $$CompletionLogsTableOrderingComposer,
          $$CompletionLogsTableAnnotationComposer,
          $$CompletionLogsTableCreateCompanionBuilder,
          $$CompletionLogsTableUpdateCompanionBuilder,
          (CompletionLog, $$CompletionLogsTableReferences),
          CompletionLog,
          PrefetchHooks Function({bool exerciseId, bool weekId})
        > {
  $$CompletionLogsTableTableManager(
    _$AppDatabase db,
    $CompletionLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompletionLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompletionLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompletionLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> exerciseId = const Value.absent(),
                Value<int> weekId = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<SessionType> session = const Value.absent(),
                Value<int?> holdSecondsAchieved = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => CompletionLogsCompanion(
                id: id,
                exerciseId: exerciseId,
                weekId: weekId,
                completedAt: completedAt,
                session: session,
                holdSecondsAchieved: holdSecondsAchieved,
                durationSeconds: durationSeconds,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> exerciseId = const Value.absent(),
                required int weekId,
                Value<DateTime> completedAt = const Value.absent(),
                required SessionType session,
                Value<int?> holdSecondsAchieved = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => CompletionLogsCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                weekId: weekId,
                completedAt: completedAt,
                session: session,
                holdSecondsAchieved: holdSecondsAchieved,
                durationSeconds: durationSeconds,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CompletionLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false, weekId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable: $$CompletionLogsTableReferences
                                    ._exerciseIdTable(db),
                                referencedColumn:
                                    $$CompletionLogsTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (weekId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.weekId,
                                referencedTable: $$CompletionLogsTableReferences
                                    ._weekIdTable(db),
                                referencedColumn:
                                    $$CompletionLogsTableReferences
                                        ._weekIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CompletionLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompletionLogsTable,
      CompletionLog,
      $$CompletionLogsTableFilterComposer,
      $$CompletionLogsTableOrderingComposer,
      $$CompletionLogsTableAnnotationComposer,
      $$CompletionLogsTableCreateCompanionBuilder,
      $$CompletionLogsTableUpdateCompanionBuilder,
      (CompletionLog, $$CompletionLogsTableReferences),
      CompletionLog,
      PrefetchHooks Function({bool exerciseId, bool weekId})
    >;
typedef $$BadgesTableCreateCompanionBuilder =
    BadgesCompanion Function({
      Value<int> id,
      required String code,
      required String title,
      required String description,
      Value<String?> iconName,
      Value<bool> isUnlocked,
      Value<DateTime?> unlockedAt,
    });
typedef $$BadgesTableUpdateCompanionBuilder =
    BadgesCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> title,
      Value<String> description,
      Value<String?> iconName,
      Value<bool> isUnlocked,
      Value<DateTime?> unlockedAt,
    });

class $$BadgesTableFilterComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableFilterComposer({
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BadgesTableOrderingComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableOrderingComposer({
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BadgesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );
}

class $$BadgesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BadgesTable,
          Badge,
          $$BadgesTableFilterComposer,
          $$BadgesTableOrderingComposer,
          $$BadgesTableAnnotationComposer,
          $$BadgesTableCreateCompanionBuilder,
          $$BadgesTableUpdateCompanionBuilder,
          (Badge, BaseReferences<_$AppDatabase, $BadgesTable, Badge>),
          Badge,
          PrefetchHooks Function()
        > {
  $$BadgesTableTableManager(_$AppDatabase db, $BadgesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BadgesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BadgesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BadgesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> iconName = const Value.absent(),
                Value<bool> isUnlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
              }) => BadgesCompanion(
                id: id,
                code: code,
                title: title,
                description: description,
                iconName: iconName,
                isUnlocked: isUnlocked,
                unlockedAt: unlockedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String title,
                required String description,
                Value<String?> iconName = const Value.absent(),
                Value<bool> isUnlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
              }) => BadgesCompanion.insert(
                id: id,
                code: code,
                title: title,
                description: description,
                iconName: iconName,
                isUnlocked: isUnlocked,
                unlockedAt: unlockedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BadgesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BadgesTable,
      Badge,
      $$BadgesTableFilterComposer,
      $$BadgesTableOrderingComposer,
      $$BadgesTableAnnotationComposer,
      $$BadgesTableCreateCompanionBuilder,
      $$BadgesTableUpdateCompanionBuilder,
      (Badge, BaseReferences<_$AppDatabase, $BadgesTable, Badge>),
      Badge,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<ThemeMode> themeMode,
      Value<bool> forceUnlockAll,
      Value<bool> weeklySummaryEnabled,
      Value<String> reminderTimesCsv,
      Value<bool> remindersEnabled,
      Value<String> morningReminderTime,
      Value<String> eveningReminderTime,
      Value<bool> weeklyReportEnabled,
      Value<int> streakCount,
      Value<int> longestStreak,
      Value<DateTime?> lastActiveDate,
      Value<int?> currentWeekId,
      Value<bool> levelSystemEnabled,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<ThemeMode> themeMode,
      Value<bool> forceUnlockAll,
      Value<bool> weeklySummaryEnabled,
      Value<String> reminderTimesCsv,
      Value<bool> remindersEnabled,
      Value<String> morningReminderTime,
      Value<String> eveningReminderTime,
      Value<bool> weeklyReportEnabled,
      Value<int> streakCount,
      Value<int> longestStreak,
      Value<DateTime?> lastActiveDate,
      Value<int?> currentWeekId,
      Value<bool> levelSystemEnabled,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
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

  ColumnWithTypeConverterFilters<ThemeMode, ThemeMode, String> get themeMode =>
      $composableBuilder(
        column: $table.themeMode,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get forceUnlockAll => $composableBuilder(
    column: $table.forceUnlockAll,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get weeklySummaryEnabled => $composableBuilder(
    column: $table.weeklySummaryEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderTimesCsv => $composableBuilder(
    column: $table.reminderTimesCsv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remindersEnabled => $composableBuilder(
    column: $table.remindersEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get morningReminderTime => $composableBuilder(
    column: $table.morningReminderTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eveningReminderTime => $composableBuilder(
    column: $table.eveningReminderTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get weeklyReportEnabled => $composableBuilder(
    column: $table.weeklyReportEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streakCount => $composableBuilder(
    column: $table.streakCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentWeekId => $composableBuilder(
    column: $table.currentWeekId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get levelSystemEnabled => $composableBuilder(
    column: $table.levelSystemEnabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
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

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get forceUnlockAll => $composableBuilder(
    column: $table.forceUnlockAll,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get weeklySummaryEnabled => $composableBuilder(
    column: $table.weeklySummaryEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderTimesCsv => $composableBuilder(
    column: $table.reminderTimesCsv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remindersEnabled => $composableBuilder(
    column: $table.remindersEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get morningReminderTime => $composableBuilder(
    column: $table.morningReminderTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eveningReminderTime => $composableBuilder(
    column: $table.eveningReminderTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get weeklyReportEnabled => $composableBuilder(
    column: $table.weeklyReportEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streakCount => $composableBuilder(
    column: $table.streakCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentWeekId => $composableBuilder(
    column: $table.currentWeekId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get levelSystemEnabled => $composableBuilder(
    column: $table.levelSystemEnabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ThemeMode, String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<bool> get forceUnlockAll => $composableBuilder(
    column: $table.forceUnlockAll,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get weeklySummaryEnabled => $composableBuilder(
    column: $table.weeklySummaryEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reminderTimesCsv => $composableBuilder(
    column: $table.reminderTimesCsv,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get remindersEnabled => $composableBuilder(
    column: $table.remindersEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get morningReminderTime => $composableBuilder(
    column: $table.morningReminderTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eveningReminderTime => $composableBuilder(
    column: $table.eveningReminderTime,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get weeklyReportEnabled => $composableBuilder(
    column: $table.weeklyReportEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get streakCount => $composableBuilder(
    column: $table.streakCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastActiveDate => $composableBuilder(
    column: $table.lastActiveDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentWeekId => $composableBuilder(
    column: $table.currentWeekId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get levelSystemEnabled => $composableBuilder(
    column: $table.levelSystemEnabled,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<ThemeMode> themeMode = const Value.absent(),
                Value<bool> forceUnlockAll = const Value.absent(),
                Value<bool> weeklySummaryEnabled = const Value.absent(),
                Value<String> reminderTimesCsv = const Value.absent(),
                Value<bool> remindersEnabled = const Value.absent(),
                Value<String> morningReminderTime = const Value.absent(),
                Value<String> eveningReminderTime = const Value.absent(),
                Value<bool> weeklyReportEnabled = const Value.absent(),
                Value<int> streakCount = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<DateTime?> lastActiveDate = const Value.absent(),
                Value<int?> currentWeekId = const Value.absent(),
                Value<bool> levelSystemEnabled = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                themeMode: themeMode,
                forceUnlockAll: forceUnlockAll,
                weeklySummaryEnabled: weeklySummaryEnabled,
                reminderTimesCsv: reminderTimesCsv,
                remindersEnabled: remindersEnabled,
                morningReminderTime: morningReminderTime,
                eveningReminderTime: eveningReminderTime,
                weeklyReportEnabled: weeklyReportEnabled,
                streakCount: streakCount,
                longestStreak: longestStreak,
                lastActiveDate: lastActiveDate,
                currentWeekId: currentWeekId,
                levelSystemEnabled: levelSystemEnabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<ThemeMode> themeMode = const Value.absent(),
                Value<bool> forceUnlockAll = const Value.absent(),
                Value<bool> weeklySummaryEnabled = const Value.absent(),
                Value<String> reminderTimesCsv = const Value.absent(),
                Value<bool> remindersEnabled = const Value.absent(),
                Value<String> morningReminderTime = const Value.absent(),
                Value<String> eveningReminderTime = const Value.absent(),
                Value<bool> weeklyReportEnabled = const Value.absent(),
                Value<int> streakCount = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<DateTime?> lastActiveDate = const Value.absent(),
                Value<int?> currentWeekId = const Value.absent(),
                Value<bool> levelSystemEnabled = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                themeMode: themeMode,
                forceUnlockAll: forceUnlockAll,
                weeklySummaryEnabled: weeklySummaryEnabled,
                reminderTimesCsv: reminderTimesCsv,
                remindersEnabled: remindersEnabled,
                morningReminderTime: morningReminderTime,
                eveningReminderTime: eveningReminderTime,
                weeklyReportEnabled: weeklyReportEnabled,
                streakCount: streakCount,
                longestStreak: longestStreak,
                lastActiveDate: lastActiveDate,
                currentWeekId: currentWeekId,
                levelSystemEnabled: levelSystemEnabled,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProgramsTableTableManager get programs =>
      $$ProgramsTableTableManager(_db, _db.programs);
  $$WeeksTableTableManager get weeks =>
      $$WeeksTableTableManager(_db, _db.weeks);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$CompletionLogsTableTableManager get completionLogs =>
      $$CompletionLogsTableTableManager(_db, _db.completionLogs);
  $$BadgesTableTableManager get badges =>
      $$BadgesTableTableManager(_db, _db.badges);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
