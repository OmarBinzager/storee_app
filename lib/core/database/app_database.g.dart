// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CurrenciesTableTable extends CurrenciesTable
    with TableInfo<$CurrenciesTableTable, CurrenciesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurrenciesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 5,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
    'name_ar',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _symbolArMeta = const VerificationMeta(
    'symbolAr',
  );
  @override
  late final GeneratedColumn<String> symbolAr = GeneratedColumn<String>(
    'symbol_ar',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minorUnitDigitsMeta = const VerificationMeta(
    'minorUnitDigits',
  );
  @override
  late final GeneratedColumn<int> minorUnitDigits = GeneratedColumn<int>(
    'minor_unit_digits',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
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
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    code,
    nameAr,
    symbolAr,
    minorUnitDigits,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'currencies';
  @override
  VerificationContext validateIntegrity(
    Insertable<CurrenciesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(
        _nameArMeta,
        nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta),
      );
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('symbol_ar')) {
      context.handle(
        _symbolArMeta,
        symbolAr.isAcceptableOrUnknown(data['symbol_ar']!, _symbolArMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolArMeta);
    }
    if (data.containsKey('minor_unit_digits')) {
      context.handle(
        _minorUnitDigitsMeta,
        minorUnitDigits.isAcceptableOrUnknown(
          data['minor_unit_digits']!,
          _minorUnitDigitsMeta,
        ),
      );
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
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  CurrenciesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurrenciesTableData(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      nameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ar'],
      )!,
      symbolAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol_ar'],
      )!,
      minorUnitDigits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minor_unit_digits'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $CurrenciesTableTable createAlias(String alias) {
    return $CurrenciesTableTable(attachedDatabase, alias);
  }
}

class CurrenciesTableData extends DataClass
    implements Insertable<CurrenciesTableData> {
  final String code;
  final String nameAr;
  final String symbolAr;
  final int minorUnitDigits;
  final bool isActive;
  const CurrenciesTableData({
    required this.code,
    required this.nameAr,
    required this.symbolAr,
    required this.minorUnitDigits,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name_ar'] = Variable<String>(nameAr);
    map['symbol_ar'] = Variable<String>(symbolAr);
    map['minor_unit_digits'] = Variable<int>(minorUnitDigits);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  CurrenciesTableCompanion toCompanion(bool nullToAbsent) {
    return CurrenciesTableCompanion(
      code: Value(code),
      nameAr: Value(nameAr),
      symbolAr: Value(symbolAr),
      minorUnitDigits: Value(minorUnitDigits),
      isActive: Value(isActive),
    );
  }

  factory CurrenciesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurrenciesTableData(
      code: serializer.fromJson<String>(json['code']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      symbolAr: serializer.fromJson<String>(json['symbolAr']),
      minorUnitDigits: serializer.fromJson<int>(json['minorUnitDigits']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'nameAr': serializer.toJson<String>(nameAr),
      'symbolAr': serializer.toJson<String>(symbolAr),
      'minorUnitDigits': serializer.toJson<int>(minorUnitDigits),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  CurrenciesTableData copyWith({
    String? code,
    String? nameAr,
    String? symbolAr,
    int? minorUnitDigits,
    bool? isActive,
  }) => CurrenciesTableData(
    code: code ?? this.code,
    nameAr: nameAr ?? this.nameAr,
    symbolAr: symbolAr ?? this.symbolAr,
    minorUnitDigits: minorUnitDigits ?? this.minorUnitDigits,
    isActive: isActive ?? this.isActive,
  );
  CurrenciesTableData copyWithCompanion(CurrenciesTableCompanion data) {
    return CurrenciesTableData(
      code: data.code.present ? data.code.value : this.code,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      symbolAr: data.symbolAr.present ? data.symbolAr.value : this.symbolAr,
      minorUnitDigits: data.minorUnitDigits.present
          ? data.minorUnitDigits.value
          : this.minorUnitDigits,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CurrenciesTableData(')
          ..write('code: $code, ')
          ..write('nameAr: $nameAr, ')
          ..write('symbolAr: $symbolAr, ')
          ..write('minorUnitDigits: $minorUnitDigits, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(code, nameAr, symbolAr, minorUnitDigits, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrenciesTableData &&
          other.code == this.code &&
          other.nameAr == this.nameAr &&
          other.symbolAr == this.symbolAr &&
          other.minorUnitDigits == this.minorUnitDigits &&
          other.isActive == this.isActive);
}

class CurrenciesTableCompanion extends UpdateCompanion<CurrenciesTableData> {
  final Value<String> code;
  final Value<String> nameAr;
  final Value<String> symbolAr;
  final Value<int> minorUnitDigits;
  final Value<bool> isActive;
  final Value<int> rowid;
  const CurrenciesTableCompanion({
    this.code = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.symbolAr = const Value.absent(),
    this.minorUnitDigits = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CurrenciesTableCompanion.insert({
    required String code,
    required String nameAr,
    required String symbolAr,
    this.minorUnitDigits = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       nameAr = Value(nameAr),
       symbolAr = Value(symbolAr);
  static Insertable<CurrenciesTableData> custom({
    Expression<String>? code,
    Expression<String>? nameAr,
    Expression<String>? symbolAr,
    Expression<int>? minorUnitDigits,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (nameAr != null) 'name_ar': nameAr,
      if (symbolAr != null) 'symbol_ar': symbolAr,
      if (minorUnitDigits != null) 'minor_unit_digits': minorUnitDigits,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CurrenciesTableCompanion copyWith({
    Value<String>? code,
    Value<String>? nameAr,
    Value<String>? symbolAr,
    Value<int>? minorUnitDigits,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return CurrenciesTableCompanion(
      code: code ?? this.code,
      nameAr: nameAr ?? this.nameAr,
      symbolAr: symbolAr ?? this.symbolAr,
      minorUnitDigits: minorUnitDigits ?? this.minorUnitDigits,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (symbolAr.present) {
      map['symbol_ar'] = Variable<String>(symbolAr.value);
    }
    if (minorUnitDigits.present) {
      map['minor_unit_digits'] = Variable<int>(minorUnitDigits.value);
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
    return (StringBuffer('CurrenciesTableCompanion(')
          ..write('code: $code, ')
          ..write('nameAr: $nameAr, ')
          ..write('symbolAr: $symbolAr, ')
          ..write('minorUnitDigits: $minorUnitDigits, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WalletsTableTable extends WalletsTable
    with TableInfo<$WalletsTableTable, WalletsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletsTableTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
    defaultValue: const Constant(true),
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
  List<GeneratedColumn> get $columns => [id, name, type, isActive, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallets';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalletsTableData> instance, {
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
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
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
  WalletsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalletsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
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
  $WalletsTableTable createAlias(String alias) {
    return $WalletsTableTable(attachedDatabase, alias);
  }
}

class WalletsTableData extends DataClass
    implements Insertable<WalletsTableData> {
  final String id;
  final String name;
  final String type;
  final bool isActive;
  final DateTime createdAt;
  const WalletsTableData({
    required this.id,
    required this.name,
    required this.type,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WalletsTableCompanion toCompanion(bool nullToAbsent) {
    return WalletsTableCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory WalletsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalletsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WalletsTableData copyWith({
    String? id,
    String? name,
    String? type,
    bool? isActive,
    DateTime? createdAt,
  }) => WalletsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  WalletsTableData copyWithCompanion(WalletsTableCompanion data) {
    return WalletsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalletsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalletsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class WalletsTableCompanion extends UpdateCompanion<WalletsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WalletsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WalletsTableCompanion.insert({
    required String id,
    required String name,
    required String type,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type);
  static Insertable<WalletsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WalletsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WalletsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
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
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalletsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WalletBalancesTableTable extends WalletBalancesTable
    with TableInfo<$WalletBalancesTableTable, WalletBalancesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletBalancesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _walletIdMeta = const VerificationMeta(
    'walletId',
  );
  @override
  late final GeneratedColumn<String> walletId = GeneratedColumn<String>(
    'wallet_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wallets (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES currencies (code)',
    ),
  );
  static const VerificationMeta _balanceMinorMeta = const VerificationMeta(
    'balanceMinor',
  );
  @override
  late final GeneratedColumn<int> balanceMinor = GeneratedColumn<int>(
    'balance_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [walletId, currencyCode, balanceMinor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallet_balances';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalletBalancesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('wallet_id')) {
      context.handle(
        _walletIdMeta,
        walletId.isAcceptableOrUnknown(data['wallet_id']!, _walletIdMeta),
      );
    } else if (isInserting) {
      context.missing(_walletIdMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('balance_minor')) {
      context.handle(
        _balanceMinorMeta,
        balanceMinor.isAcceptableOrUnknown(
          data['balance_minor']!,
          _balanceMinorMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {walletId, currencyCode};
  @override
  WalletBalancesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalletBalancesTableData(
      walletId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wallet_id'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      balanceMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_minor'],
      )!,
    );
  }

  @override
  $WalletBalancesTableTable createAlias(String alias) {
    return $WalletBalancesTableTable(attachedDatabase, alias);
  }
}

class WalletBalancesTableData extends DataClass
    implements Insertable<WalletBalancesTableData> {
  final String walletId;
  final String currencyCode;
  final int balanceMinor;
  const WalletBalancesTableData({
    required this.walletId,
    required this.currencyCode,
    required this.balanceMinor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['wallet_id'] = Variable<String>(walletId);
    map['currency_code'] = Variable<String>(currencyCode);
    map['balance_minor'] = Variable<int>(balanceMinor);
    return map;
  }

  WalletBalancesTableCompanion toCompanion(bool nullToAbsent) {
    return WalletBalancesTableCompanion(
      walletId: Value(walletId),
      currencyCode: Value(currencyCode),
      balanceMinor: Value(balanceMinor),
    );
  }

  factory WalletBalancesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalletBalancesTableData(
      walletId: serializer.fromJson<String>(json['walletId']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      balanceMinor: serializer.fromJson<int>(json['balanceMinor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'walletId': serializer.toJson<String>(walletId),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'balanceMinor': serializer.toJson<int>(balanceMinor),
    };
  }

  WalletBalancesTableData copyWith({
    String? walletId,
    String? currencyCode,
    int? balanceMinor,
  }) => WalletBalancesTableData(
    walletId: walletId ?? this.walletId,
    currencyCode: currencyCode ?? this.currencyCode,
    balanceMinor: balanceMinor ?? this.balanceMinor,
  );
  WalletBalancesTableData copyWithCompanion(WalletBalancesTableCompanion data) {
    return WalletBalancesTableData(
      walletId: data.walletId.present ? data.walletId.value : this.walletId,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      balanceMinor: data.balanceMinor.present
          ? data.balanceMinor.value
          : this.balanceMinor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalletBalancesTableData(')
          ..write('walletId: $walletId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('balanceMinor: $balanceMinor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(walletId, currencyCode, balanceMinor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalletBalancesTableData &&
          other.walletId == this.walletId &&
          other.currencyCode == this.currencyCode &&
          other.balanceMinor == this.balanceMinor);
}

class WalletBalancesTableCompanion
    extends UpdateCompanion<WalletBalancesTableData> {
  final Value<String> walletId;
  final Value<String> currencyCode;
  final Value<int> balanceMinor;
  final Value<int> rowid;
  const WalletBalancesTableCompanion({
    this.walletId = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.balanceMinor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WalletBalancesTableCompanion.insert({
    required String walletId,
    required String currencyCode,
    this.balanceMinor = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : walletId = Value(walletId),
       currencyCode = Value(currencyCode);
  static Insertable<WalletBalancesTableData> custom({
    Expression<String>? walletId,
    Expression<String>? currencyCode,
    Expression<int>? balanceMinor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (walletId != null) 'wallet_id': walletId,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (balanceMinor != null) 'balance_minor': balanceMinor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WalletBalancesTableCompanion copyWith({
    Value<String>? walletId,
    Value<String>? currencyCode,
    Value<int>? balanceMinor,
    Value<int>? rowid,
  }) {
    return WalletBalancesTableCompanion(
      walletId: walletId ?? this.walletId,
      currencyCode: currencyCode ?? this.currencyCode,
      balanceMinor: balanceMinor ?? this.balanceMinor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (walletId.present) {
      map['wallet_id'] = Variable<String>(walletId.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (balanceMinor.present) {
      map['balance_minor'] = Variable<int>(balanceMinor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalletBalancesTableCompanion(')
          ..write('walletId: $walletId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('balanceMinor: $balanceMinor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTableTable extends CustomersTable
    with TableInfo<$CustomersTableTable, CustomersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTableTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 5,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultCurrencyCodeMeta =
      const VerificationMeta('defaultCurrencyCode');
  @override
  late final GeneratedColumn<String> defaultCurrencyCode =
      GeneratedColumn<String>(
        'default_currency_code',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES currencies (code)',
        ),
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
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
    phone,
    defaultCurrencyCode,
    notes,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomersTableData> instance, {
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
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('default_currency_code')) {
      context.handle(
        _defaultCurrencyCodeMeta,
        defaultCurrencyCode.isAcceptableOrUnknown(
          data['default_currency_code']!,
          _defaultCurrencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_defaultCurrencyCodeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      defaultCurrencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_currency_code'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CustomersTableTable createAlias(String alias) {
    return $CustomersTableTable(attachedDatabase, alias);
  }
}

class CustomersTableData extends DataClass
    implements Insertable<CustomersTableData> {
  final String id;
  final String name;
  final String phone;
  final String defaultCurrencyCode;
  final String? notes;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CustomersTableData({
    required this.id,
    required this.name,
    required this.phone,
    required this.defaultCurrencyCode,
    this.notes,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    map['default_currency_code'] = Variable<String>(defaultCurrencyCode);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CustomersTableCompanion toCompanion(bool nullToAbsent) {
    return CustomersTableCompanion(
      id: Value(id),
      name: Value(name),
      phone: Value(phone),
      defaultCurrencyCode: Value(defaultCurrencyCode),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CustomersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomersTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      defaultCurrencyCode: serializer.fromJson<String>(
        json['defaultCurrencyCode'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'defaultCurrencyCode': serializer.toJson<String>(defaultCurrencyCode),
      'notes': serializer.toJson<String?>(notes),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CustomersTableData copyWith({
    String? id,
    String? name,
    String? phone,
    String? defaultCurrencyCode,
    Value<String?> notes = const Value.absent(),
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CustomersTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    defaultCurrencyCode: defaultCurrencyCode ?? this.defaultCurrencyCode,
    notes: notes.present ? notes.value : this.notes,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CustomersTableData copyWithCompanion(CustomersTableCompanion data) {
    return CustomersTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      defaultCurrencyCode: data.defaultCurrencyCode.present
          ? data.defaultCurrencyCode.value
          : this.defaultCurrencyCode,
      notes: data.notes.present ? data.notes.value : this.notes,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomersTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('defaultCurrencyCode: $defaultCurrencyCode, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    phone,
    defaultCurrencyCode,
    notes,
    isArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomersTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.defaultCurrencyCode == this.defaultCurrencyCode &&
          other.notes == this.notes &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CustomersTableCompanion extends UpdateCompanion<CustomersTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String> defaultCurrencyCode;
  final Value<String?> notes;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CustomersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.defaultCurrencyCode = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersTableCompanion.insert({
    required String id,
    required String name,
    required String phone,
    required String defaultCurrencyCode,
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       phone = Value(phone),
       defaultCurrencyCode = Value(defaultCurrencyCode);
  static Insertable<CustomersTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? defaultCurrencyCode,
    Expression<String>? notes,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (defaultCurrencyCode != null)
        'default_currency_code': defaultCurrencyCode,
      if (notes != null) 'notes': notes,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? phone,
    Value<String>? defaultCurrencyCode,
    Value<String?>? notes,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CustomersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      defaultCurrencyCode: defaultCurrencyCode ?? this.defaultCurrencyCode,
      notes: notes ?? this.notes,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (defaultCurrencyCode.present) {
      map['default_currency_code'] = Variable<String>(
        defaultCurrencyCode.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('defaultCurrencyCode: $defaultCurrencyCode, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTableTable extends ProductsTable
    with TableInfo<$ProductsTableTable, ProductsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTableTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
    'size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseUrlMeta = const VerificationMeta(
    'purchaseUrl',
  );
  @override
  late final GeneratedColumn<String> purchaseUrl = GeneratedColumn<String>(
    'purchase_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    imagePath,
    color,
    size,
    purchaseUrl,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductsTableData> instance, {
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
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    }
    if (data.containsKey('purchase_url')) {
      context.handle(
        _purchaseUrlMeta,
        purchaseUrl.isAcceptableOrUnknown(
          data['purchase_url']!,
          _purchaseUrlMeta,
        ),
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
  ProductsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size'],
      ),
      purchaseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductsTableTable createAlias(String alias) {
    return $ProductsTableTable(attachedDatabase, alias);
  }
}

class ProductsTableData extends DataClass
    implements Insertable<ProductsTableData> {
  final String id;
  final String name;
  final String? imagePath;
  final String? color;
  final String? size;
  final String? purchaseUrl;
  final DateTime createdAt;
  const ProductsTableData({
    required this.id,
    required this.name,
    this.imagePath,
    this.color,
    this.size,
    this.purchaseUrl,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<String>(size);
    }
    if (!nullToAbsent || purchaseUrl != null) {
      map['purchase_url'] = Variable<String>(purchaseUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductsTableCompanion toCompanion(bool nullToAbsent) {
    return ProductsTableCompanion(
      id: Value(id),
      name: Value(name),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      purchaseUrl: purchaseUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseUrl),
      createdAt: Value(createdAt),
    );
  }

  factory ProductsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      color: serializer.fromJson<String?>(json['color']),
      size: serializer.fromJson<String?>(json['size']),
      purchaseUrl: serializer.fromJson<String?>(json['purchaseUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'imagePath': serializer.toJson<String?>(imagePath),
      'color': serializer.toJson<String?>(color),
      'size': serializer.toJson<String?>(size),
      'purchaseUrl': serializer.toJson<String?>(purchaseUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProductsTableData copyWith({
    String? id,
    String? name,
    Value<String?> imagePath = const Value.absent(),
    Value<String?> color = const Value.absent(),
    Value<String?> size = const Value.absent(),
    Value<String?> purchaseUrl = const Value.absent(),
    DateTime? createdAt,
  }) => ProductsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    color: color.present ? color.value : this.color,
    size: size.present ? size.value : this.size,
    purchaseUrl: purchaseUrl.present ? purchaseUrl.value : this.purchaseUrl,
    createdAt: createdAt ?? this.createdAt,
  );
  ProductsTableData copyWithCompanion(ProductsTableCompanion data) {
    return ProductsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      color: data.color.present ? data.color.value : this.color,
      size: data.size.present ? data.size.value : this.size,
      purchaseUrl: data.purchaseUrl.present
          ? data.purchaseUrl.value
          : this.purchaseUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath, ')
          ..write('color: $color, ')
          ..write('size: $size, ')
          ..write('purchaseUrl: $purchaseUrl, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, imagePath, color, size, purchaseUrl, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.imagePath == this.imagePath &&
          other.color == this.color &&
          other.size == this.size &&
          other.purchaseUrl == this.purchaseUrl &&
          other.createdAt == this.createdAt);
}

class ProductsTableCompanion extends UpdateCompanion<ProductsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> imagePath;
  final Value<String?> color;
  final Value<String?> size;
  final Value<String?> purchaseUrl;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ProductsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.color = const Value.absent(),
    this.size = const Value.absent(),
    this.purchaseUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsTableCompanion.insert({
    required String id,
    required String name,
    this.imagePath = const Value.absent(),
    this.color = const Value.absent(),
    this.size = const Value.absent(),
    this.purchaseUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<ProductsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? imagePath,
    Expression<String>? color,
    Expression<String>? size,
    Expression<String>? purchaseUrl,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imagePath != null) 'image_path': imagePath,
      if (color != null) 'color': color,
      if (size != null) 'size': size,
      if (purchaseUrl != null) 'purchase_url': purchaseUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? imagePath,
    Value<String?>? color,
    Value<String?>? size,
    Value<String?>? purchaseUrl,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ProductsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      color: color ?? this.color,
      size: size ?? this.size,
      purchaseUrl: purchaseUrl ?? this.purchaseUrl,
      createdAt: createdAt ?? this.createdAt,
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
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (purchaseUrl.present) {
      map['purchase_url'] = Variable<String>(purchaseUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath, ')
          ..write('color: $color, ')
          ..write('size: $size, ')
          ..write('purchaseUrl: $purchaseUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomerOrdersTableTable extends CustomerOrdersTable
    with TableInfo<$CustomerOrdersTableTable, CustomerOrdersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerOrdersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _orderNumberMeta = const VerificationMeta(
    'orderNumber',
  );
  @override
  late final GeneratedColumn<String> orderNumber = GeneratedColumn<String>(
    'order_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _executionStatusMeta = const VerificationMeta(
    'executionStatus',
  );
  @override
  late final GeneratedColumn<String> executionStatus = GeneratedColumn<String>(
    'execution_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentStatusMeta = const VerificationMeta(
    'paymentStatus',
  );
  @override
  late final GeneratedColumn<String> paymentStatus = GeneratedColumn<String>(
    'payment_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES currencies (code)',
    ),
  );
  static const VerificationMeta _paidAmountMinorMeta = const VerificationMeta(
    'paidAmountMinor',
  );
  @override
  late final GeneratedColumn<int> paidAmountMinor = GeneratedColumn<int>(
    'paid_amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _discountAmountMinorMeta =
      const VerificationMeta('discountAmountMinor');
  @override
  late final GeneratedColumn<int> discountAmountMinor = GeneratedColumn<int>(
    'discount_amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerId,
    orderNumber,
    executionStatus,
    paymentStatus,
    currencyCode,
    paidAmountMinor,
    discountAmountMinor,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerOrdersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('order_number')) {
      context.handle(
        _orderNumberMeta,
        orderNumber.isAcceptableOrUnknown(
          data['order_number']!,
          _orderNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_orderNumberMeta);
    }
    if (data.containsKey('execution_status')) {
      context.handle(
        _executionStatusMeta,
        executionStatus.isAcceptableOrUnknown(
          data['execution_status']!,
          _executionStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_executionStatusMeta);
    }
    if (data.containsKey('payment_status')) {
      context.handle(
        _paymentStatusMeta,
        paymentStatus.isAcceptableOrUnknown(
          data['payment_status']!,
          _paymentStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentStatusMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('paid_amount_minor')) {
      context.handle(
        _paidAmountMinorMeta,
        paidAmountMinor.isAcceptableOrUnknown(
          data['paid_amount_minor']!,
          _paidAmountMinorMeta,
        ),
      );
    }
    if (data.containsKey('discount_amount_minor')) {
      context.handle(
        _discountAmountMinorMeta,
        discountAmountMinor.isAcceptableOrUnknown(
          data['discount_amount_minor']!,
          _discountAmountMinorMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerOrdersTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerOrdersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      orderNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_number'],
      )!,
      executionStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}execution_status'],
      )!,
      paymentStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_status'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      paidAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paid_amount_minor'],
      )!,
      discountAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_amount_minor'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CustomerOrdersTableTable createAlias(String alias) {
    return $CustomerOrdersTableTable(attachedDatabase, alias);
  }
}

class CustomerOrdersTableData extends DataClass
    implements Insertable<CustomerOrdersTableData> {
  final String id;
  final String customerId;
  final String orderNumber;
  final String executionStatus;
  final String paymentStatus;
  final String currencyCode;
  final int paidAmountMinor;
  final int discountAmountMinor;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CustomerOrdersTableData({
    required this.id,
    required this.customerId,
    required this.orderNumber,
    required this.executionStatus,
    required this.paymentStatus,
    required this.currencyCode,
    required this.paidAmountMinor,
    required this.discountAmountMinor,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['customer_id'] = Variable<String>(customerId);
    map['order_number'] = Variable<String>(orderNumber);
    map['execution_status'] = Variable<String>(executionStatus);
    map['payment_status'] = Variable<String>(paymentStatus);
    map['currency_code'] = Variable<String>(currencyCode);
    map['paid_amount_minor'] = Variable<int>(paidAmountMinor);
    map['discount_amount_minor'] = Variable<int>(discountAmountMinor);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CustomerOrdersTableCompanion toCompanion(bool nullToAbsent) {
    return CustomerOrdersTableCompanion(
      id: Value(id),
      customerId: Value(customerId),
      orderNumber: Value(orderNumber),
      executionStatus: Value(executionStatus),
      paymentStatus: Value(paymentStatus),
      currencyCode: Value(currencyCode),
      paidAmountMinor: Value(paidAmountMinor),
      discountAmountMinor: Value(discountAmountMinor),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CustomerOrdersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerOrdersTableData(
      id: serializer.fromJson<String>(json['id']),
      customerId: serializer.fromJson<String>(json['customerId']),
      orderNumber: serializer.fromJson<String>(json['orderNumber']),
      executionStatus: serializer.fromJson<String>(json['executionStatus']),
      paymentStatus: serializer.fromJson<String>(json['paymentStatus']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      paidAmountMinor: serializer.fromJson<int>(json['paidAmountMinor']),
      discountAmountMinor: serializer.fromJson<int>(
        json['discountAmountMinor'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'customerId': serializer.toJson<String>(customerId),
      'orderNumber': serializer.toJson<String>(orderNumber),
      'executionStatus': serializer.toJson<String>(executionStatus),
      'paymentStatus': serializer.toJson<String>(paymentStatus),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'paidAmountMinor': serializer.toJson<int>(paidAmountMinor),
      'discountAmountMinor': serializer.toJson<int>(discountAmountMinor),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CustomerOrdersTableData copyWith({
    String? id,
    String? customerId,
    String? orderNumber,
    String? executionStatus,
    String? paymentStatus,
    String? currencyCode,
    int? paidAmountMinor,
    int? discountAmountMinor,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CustomerOrdersTableData(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    orderNumber: orderNumber ?? this.orderNumber,
    executionStatus: executionStatus ?? this.executionStatus,
    paymentStatus: paymentStatus ?? this.paymentStatus,
    currencyCode: currencyCode ?? this.currencyCode,
    paidAmountMinor: paidAmountMinor ?? this.paidAmountMinor,
    discountAmountMinor: discountAmountMinor ?? this.discountAmountMinor,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CustomerOrdersTableData copyWithCompanion(CustomerOrdersTableCompanion data) {
    return CustomerOrdersTableData(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      orderNumber: data.orderNumber.present
          ? data.orderNumber.value
          : this.orderNumber,
      executionStatus: data.executionStatus.present
          ? data.executionStatus.value
          : this.executionStatus,
      paymentStatus: data.paymentStatus.present
          ? data.paymentStatus.value
          : this.paymentStatus,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      paidAmountMinor: data.paidAmountMinor.present
          ? data.paidAmountMinor.value
          : this.paidAmountMinor,
      discountAmountMinor: data.discountAmountMinor.present
          ? data.discountAmountMinor.value
          : this.discountAmountMinor,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerOrdersTableData(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('executionStatus: $executionStatus, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('paidAmountMinor: $paidAmountMinor, ')
          ..write('discountAmountMinor: $discountAmountMinor, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    customerId,
    orderNumber,
    executionStatus,
    paymentStatus,
    currencyCode,
    paidAmountMinor,
    discountAmountMinor,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerOrdersTableData &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.orderNumber == this.orderNumber &&
          other.executionStatus == this.executionStatus &&
          other.paymentStatus == this.paymentStatus &&
          other.currencyCode == this.currencyCode &&
          other.paidAmountMinor == this.paidAmountMinor &&
          other.discountAmountMinor == this.discountAmountMinor &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CustomerOrdersTableCompanion
    extends UpdateCompanion<CustomerOrdersTableData> {
  final Value<String> id;
  final Value<String> customerId;
  final Value<String> orderNumber;
  final Value<String> executionStatus;
  final Value<String> paymentStatus;
  final Value<String> currencyCode;
  final Value<int> paidAmountMinor;
  final Value<int> discountAmountMinor;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CustomerOrdersTableCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.orderNumber = const Value.absent(),
    this.executionStatus = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.paidAmountMinor = const Value.absent(),
    this.discountAmountMinor = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomerOrdersTableCompanion.insert({
    required String id,
    required String customerId,
    required String orderNumber,
    required String executionStatus,
    required String paymentStatus,
    required String currencyCode,
    this.paidAmountMinor = const Value.absent(),
    this.discountAmountMinor = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       customerId = Value(customerId),
       orderNumber = Value(orderNumber),
       executionStatus = Value(executionStatus),
       paymentStatus = Value(paymentStatus),
       currencyCode = Value(currencyCode);
  static Insertable<CustomerOrdersTableData> custom({
    Expression<String>? id,
    Expression<String>? customerId,
    Expression<String>? orderNumber,
    Expression<String>? executionStatus,
    Expression<String>? paymentStatus,
    Expression<String>? currencyCode,
    Expression<int>? paidAmountMinor,
    Expression<int>? discountAmountMinor,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (orderNumber != null) 'order_number': orderNumber,
      if (executionStatus != null) 'execution_status': executionStatus,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (paidAmountMinor != null) 'paid_amount_minor': paidAmountMinor,
      if (discountAmountMinor != null)
        'discount_amount_minor': discountAmountMinor,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomerOrdersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? customerId,
    Value<String>? orderNumber,
    Value<String>? executionStatus,
    Value<String>? paymentStatus,
    Value<String>? currencyCode,
    Value<int>? paidAmountMinor,
    Value<int>? discountAmountMinor,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CustomerOrdersTableCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      orderNumber: orderNumber ?? this.orderNumber,
      executionStatus: executionStatus ?? this.executionStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      currencyCode: currencyCode ?? this.currencyCode,
      paidAmountMinor: paidAmountMinor ?? this.paidAmountMinor,
      discountAmountMinor: discountAmountMinor ?? this.discountAmountMinor,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (orderNumber.present) {
      map['order_number'] = Variable<String>(orderNumber.value);
    }
    if (executionStatus.present) {
      map['execution_status'] = Variable<String>(executionStatus.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(paymentStatus.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (paidAmountMinor.present) {
      map['paid_amount_minor'] = Variable<int>(paidAmountMinor.value);
    }
    if (discountAmountMinor.present) {
      map['discount_amount_minor'] = Variable<int>(discountAmountMinor.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerOrdersTableCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('executionStatus: $executionStatus, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('paidAmountMinor: $paidAmountMinor, ')
          ..write('discountAmountMinor: $discountAmountMinor, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrderItemsTableTable extends OrderItemsTable
    with TableInfo<$OrderItemsTableTable, OrderItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customer_orders (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
    'size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _saleUnitPriceMinorMeta =
      const VerificationMeta('saleUnitPriceMinor');
  @override
  late final GeneratedColumn<int> saleUnitPriceMinor = GeneratedColumn<int>(
    'sale_unit_price_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostMinorMeta = const VerificationMeta(
    'unitCostMinor',
  );
  @override
  late final GeneratedColumn<int> unitCostMinor = GeneratedColumn<int>(
    'unit_cost_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allocatedExtraCostMinorMeta =
      const VerificationMeta('allocatedExtraCostMinor');
  @override
  late final GeneratedColumn<int> allocatedExtraCostMinor =
      GeneratedColumn<int>(
        'allocated_extra_cost_minor',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    productId,
    title,
    color,
    size,
    quantity,
    saleUnitPriceMinor,
    unitCostMinor,
    allocatedExtraCostMinor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderItemsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('sale_unit_price_minor')) {
      context.handle(
        _saleUnitPriceMinorMeta,
        saleUnitPriceMinor.isAcceptableOrUnknown(
          data['sale_unit_price_minor']!,
          _saleUnitPriceMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_saleUnitPriceMinorMeta);
    }
    if (data.containsKey('unit_cost_minor')) {
      context.handle(
        _unitCostMinorMeta,
        unitCostMinor.isAcceptableOrUnknown(
          data['unit_cost_minor']!,
          _unitCostMinorMeta,
        ),
      );
    }
    if (data.containsKey('allocated_extra_cost_minor')) {
      context.handle(
        _allocatedExtraCostMinorMeta,
        allocatedExtraCostMinor.isAcceptableOrUnknown(
          data['allocated_extra_cost_minor']!,
          _allocatedExtraCostMinorMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderItemsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderItemsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      saleUnitPriceMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sale_unit_price_minor'],
      )!,
      unitCostMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_cost_minor'],
      ),
      allocatedExtraCostMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}allocated_extra_cost_minor'],
      ),
    );
  }

  @override
  $OrderItemsTableTable createAlias(String alias) {
    return $OrderItemsTableTable(attachedDatabase, alias);
  }
}

class OrderItemsTableData extends DataClass
    implements Insertable<OrderItemsTableData> {
  final String id;
  final String orderId;
  final String? productId;
  final String title;
  final String? color;
  final String? size;
  final int quantity;
  final int saleUnitPriceMinor;
  final int? unitCostMinor;
  final int? allocatedExtraCostMinor;
  const OrderItemsTableData({
    required this.id,
    required this.orderId,
    this.productId,
    required this.title,
    this.color,
    this.size,
    required this.quantity,
    required this.saleUnitPriceMinor,
    this.unitCostMinor,
    this.allocatedExtraCostMinor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['order_id'] = Variable<String>(orderId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<String>(size);
    }
    map['quantity'] = Variable<int>(quantity);
    map['sale_unit_price_minor'] = Variable<int>(saleUnitPriceMinor);
    if (!nullToAbsent || unitCostMinor != null) {
      map['unit_cost_minor'] = Variable<int>(unitCostMinor);
    }
    if (!nullToAbsent || allocatedExtraCostMinor != null) {
      map['allocated_extra_cost_minor'] = Variable<int>(
        allocatedExtraCostMinor,
      );
    }
    return map;
  }

  OrderItemsTableCompanion toCompanion(bool nullToAbsent) {
    return OrderItemsTableCompanion(
      id: Value(id),
      orderId: Value(orderId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      title: Value(title),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      quantity: Value(quantity),
      saleUnitPriceMinor: Value(saleUnitPriceMinor),
      unitCostMinor: unitCostMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(unitCostMinor),
      allocatedExtraCostMinor: allocatedExtraCostMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(allocatedExtraCostMinor),
    );
  }

  factory OrderItemsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderItemsTableData(
      id: serializer.fromJson<String>(json['id']),
      orderId: serializer.fromJson<String>(json['orderId']),
      productId: serializer.fromJson<String?>(json['productId']),
      title: serializer.fromJson<String>(json['title']),
      color: serializer.fromJson<String?>(json['color']),
      size: serializer.fromJson<String?>(json['size']),
      quantity: serializer.fromJson<int>(json['quantity']),
      saleUnitPriceMinor: serializer.fromJson<int>(json['saleUnitPriceMinor']),
      unitCostMinor: serializer.fromJson<int?>(json['unitCostMinor']),
      allocatedExtraCostMinor: serializer.fromJson<int?>(
        json['allocatedExtraCostMinor'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'orderId': serializer.toJson<String>(orderId),
      'productId': serializer.toJson<String?>(productId),
      'title': serializer.toJson<String>(title),
      'color': serializer.toJson<String?>(color),
      'size': serializer.toJson<String?>(size),
      'quantity': serializer.toJson<int>(quantity),
      'saleUnitPriceMinor': serializer.toJson<int>(saleUnitPriceMinor),
      'unitCostMinor': serializer.toJson<int?>(unitCostMinor),
      'allocatedExtraCostMinor': serializer.toJson<int?>(
        allocatedExtraCostMinor,
      ),
    };
  }

  OrderItemsTableData copyWith({
    String? id,
    String? orderId,
    Value<String?> productId = const Value.absent(),
    String? title,
    Value<String?> color = const Value.absent(),
    Value<String?> size = const Value.absent(),
    int? quantity,
    int? saleUnitPriceMinor,
    Value<int?> unitCostMinor = const Value.absent(),
    Value<int?> allocatedExtraCostMinor = const Value.absent(),
  }) => OrderItemsTableData(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    productId: productId.present ? productId.value : this.productId,
    title: title ?? this.title,
    color: color.present ? color.value : this.color,
    size: size.present ? size.value : this.size,
    quantity: quantity ?? this.quantity,
    saleUnitPriceMinor: saleUnitPriceMinor ?? this.saleUnitPriceMinor,
    unitCostMinor: unitCostMinor.present
        ? unitCostMinor.value
        : this.unitCostMinor,
    allocatedExtraCostMinor: allocatedExtraCostMinor.present
        ? allocatedExtraCostMinor.value
        : this.allocatedExtraCostMinor,
  );
  OrderItemsTableData copyWithCompanion(OrderItemsTableCompanion data) {
    return OrderItemsTableData(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      productId: data.productId.present ? data.productId.value : this.productId,
      title: data.title.present ? data.title.value : this.title,
      color: data.color.present ? data.color.value : this.color,
      size: data.size.present ? data.size.value : this.size,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      saleUnitPriceMinor: data.saleUnitPriceMinor.present
          ? data.saleUnitPriceMinor.value
          : this.saleUnitPriceMinor,
      unitCostMinor: data.unitCostMinor.present
          ? data.unitCostMinor.value
          : this.unitCostMinor,
      allocatedExtraCostMinor: data.allocatedExtraCostMinor.present
          ? data.allocatedExtraCostMinor.value
          : this.allocatedExtraCostMinor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderItemsTableData(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('productId: $productId, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('size: $size, ')
          ..write('quantity: $quantity, ')
          ..write('saleUnitPriceMinor: $saleUnitPriceMinor, ')
          ..write('unitCostMinor: $unitCostMinor, ')
          ..write('allocatedExtraCostMinor: $allocatedExtraCostMinor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderId,
    productId,
    title,
    color,
    size,
    quantity,
    saleUnitPriceMinor,
    unitCostMinor,
    allocatedExtraCostMinor,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderItemsTableData &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.productId == this.productId &&
          other.title == this.title &&
          other.color == this.color &&
          other.size == this.size &&
          other.quantity == this.quantity &&
          other.saleUnitPriceMinor == this.saleUnitPriceMinor &&
          other.unitCostMinor == this.unitCostMinor &&
          other.allocatedExtraCostMinor == this.allocatedExtraCostMinor);
}

class OrderItemsTableCompanion extends UpdateCompanion<OrderItemsTableData> {
  final Value<String> id;
  final Value<String> orderId;
  final Value<String?> productId;
  final Value<String> title;
  final Value<String?> color;
  final Value<String?> size;
  final Value<int> quantity;
  final Value<int> saleUnitPriceMinor;
  final Value<int?> unitCostMinor;
  final Value<int?> allocatedExtraCostMinor;
  final Value<int> rowid;
  const OrderItemsTableCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.productId = const Value.absent(),
    this.title = const Value.absent(),
    this.color = const Value.absent(),
    this.size = const Value.absent(),
    this.quantity = const Value.absent(),
    this.saleUnitPriceMinor = const Value.absent(),
    this.unitCostMinor = const Value.absent(),
    this.allocatedExtraCostMinor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderItemsTableCompanion.insert({
    required String id,
    required String orderId,
    this.productId = const Value.absent(),
    required String title,
    this.color = const Value.absent(),
    this.size = const Value.absent(),
    this.quantity = const Value.absent(),
    required int saleUnitPriceMinor,
    this.unitCostMinor = const Value.absent(),
    this.allocatedExtraCostMinor = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       orderId = Value(orderId),
       title = Value(title),
       saleUnitPriceMinor = Value(saleUnitPriceMinor);
  static Insertable<OrderItemsTableData> custom({
    Expression<String>? id,
    Expression<String>? orderId,
    Expression<String>? productId,
    Expression<String>? title,
    Expression<String>? color,
    Expression<String>? size,
    Expression<int>? quantity,
    Expression<int>? saleUnitPriceMinor,
    Expression<int>? unitCostMinor,
    Expression<int>? allocatedExtraCostMinor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (productId != null) 'product_id': productId,
      if (title != null) 'title': title,
      if (color != null) 'color': color,
      if (size != null) 'size': size,
      if (quantity != null) 'quantity': quantity,
      if (saleUnitPriceMinor != null)
        'sale_unit_price_minor': saleUnitPriceMinor,
      if (unitCostMinor != null) 'unit_cost_minor': unitCostMinor,
      if (allocatedExtraCostMinor != null)
        'allocated_extra_cost_minor': allocatedExtraCostMinor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderItemsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? orderId,
    Value<String?>? productId,
    Value<String>? title,
    Value<String?>? color,
    Value<String?>? size,
    Value<int>? quantity,
    Value<int>? saleUnitPriceMinor,
    Value<int?>? unitCostMinor,
    Value<int?>? allocatedExtraCostMinor,
    Value<int>? rowid,
  }) {
    return OrderItemsTableCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      color: color ?? this.color,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      saleUnitPriceMinor: saleUnitPriceMinor ?? this.saleUnitPriceMinor,
      unitCostMinor: unitCostMinor ?? this.unitCostMinor,
      allocatedExtraCostMinor:
          allocatedExtraCostMinor ?? this.allocatedExtraCostMinor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (saleUnitPriceMinor.present) {
      map['sale_unit_price_minor'] = Variable<int>(saleUnitPriceMinor.value);
    }
    if (unitCostMinor.present) {
      map['unit_cost_minor'] = Variable<int>(unitCostMinor.value);
    }
    if (allocatedExtraCostMinor.present) {
      map['allocated_extra_cost_minor'] = Variable<int>(
        allocatedExtraCostMinor.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('productId: $productId, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('size: $size, ')
          ..write('quantity: $quantity, ')
          ..write('saleUnitPriceMinor: $saleUnitPriceMinor, ')
          ..write('unitCostMinor: $unitCostMinor, ')
          ..write('allocatedExtraCostMinor: $allocatedExtraCostMinor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseBatchesTableTable extends PurchaseBatchesTable
    with TableInfo<$PurchaseBatchesTableTable, PurchaseBatchesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseBatchesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _storeNameMeta = const VerificationMeta(
    'storeName',
  );
  @override
  late final GeneratedColumn<String> storeName = GeneratedColumn<String>(
    'store_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceReferenceMeta = const VerificationMeta(
    'invoiceReference',
  );
  @override
  late final GeneratedColumn<String> invoiceReference = GeneratedColumn<String>(
    'invoice_reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES currencies (code)',
    ),
  );
  static const VerificationMeta _extraCostsMinorMeta = const VerificationMeta(
    'extraCostsMinor',
  );
  @override
  late final GeneratedColumn<int> extraCostsMinor = GeneratedColumn<int>(
    'extra_costs_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _discountsMinorMeta = const VerificationMeta(
    'discountsMinor',
  );
  @override
  late final GeneratedColumn<int> discountsMinor = GeneratedColumn<int>(
    'discounts_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasedAtMeta = const VerificationMeta(
    'purchasedAt',
  );
  @override
  late final GeneratedColumn<DateTime> purchasedAt = GeneratedColumn<DateTime>(
    'purchased_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
    storeName,
    invoiceReference,
    currencyCode,
    extraCostsMinor,
    discountsMinor,
    status,
    purchasedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_batches';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseBatchesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('store_name')) {
      context.handle(
        _storeNameMeta,
        storeName.isAcceptableOrUnknown(data['store_name']!, _storeNameMeta),
      );
    } else if (isInserting) {
      context.missing(_storeNameMeta);
    }
    if (data.containsKey('invoice_reference')) {
      context.handle(
        _invoiceReferenceMeta,
        invoiceReference.isAcceptableOrUnknown(
          data['invoice_reference']!,
          _invoiceReferenceMeta,
        ),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('extra_costs_minor')) {
      context.handle(
        _extraCostsMinorMeta,
        extraCostsMinor.isAcceptableOrUnknown(
          data['extra_costs_minor']!,
          _extraCostsMinorMeta,
        ),
      );
    }
    if (data.containsKey('discounts_minor')) {
      context.handle(
        _discountsMinorMeta,
        discountsMinor.isAcceptableOrUnknown(
          data['discounts_minor']!,
          _discountsMinorMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('purchased_at')) {
      context.handle(
        _purchasedAtMeta,
        purchasedAt.isAcceptableOrUnknown(
          data['purchased_at']!,
          _purchasedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasedAtMeta);
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
  PurchaseBatchesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseBatchesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      storeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}store_name'],
      )!,
      invoiceReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_reference'],
      ),
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      extraCostsMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}extra_costs_minor'],
      )!,
      discountsMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discounts_minor'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      purchasedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchased_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PurchaseBatchesTableTable createAlias(String alias) {
    return $PurchaseBatchesTableTable(attachedDatabase, alias);
  }
}

class PurchaseBatchesTableData extends DataClass
    implements Insertable<PurchaseBatchesTableData> {
  final String id;
  final String storeName;
  final String? invoiceReference;
  final String currencyCode;
  final int extraCostsMinor;
  final int discountsMinor;
  final String status;
  final DateTime purchasedAt;
  final DateTime createdAt;
  const PurchaseBatchesTableData({
    required this.id,
    required this.storeName,
    this.invoiceReference,
    required this.currencyCode,
    required this.extraCostsMinor,
    required this.discountsMinor,
    required this.status,
    required this.purchasedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['store_name'] = Variable<String>(storeName);
    if (!nullToAbsent || invoiceReference != null) {
      map['invoice_reference'] = Variable<String>(invoiceReference);
    }
    map['currency_code'] = Variable<String>(currencyCode);
    map['extra_costs_minor'] = Variable<int>(extraCostsMinor);
    map['discounts_minor'] = Variable<int>(discountsMinor);
    map['status'] = Variable<String>(status);
    map['purchased_at'] = Variable<DateTime>(purchasedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PurchaseBatchesTableCompanion toCompanion(bool nullToAbsent) {
    return PurchaseBatchesTableCompanion(
      id: Value(id),
      storeName: Value(storeName),
      invoiceReference: invoiceReference == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceReference),
      currencyCode: Value(currencyCode),
      extraCostsMinor: Value(extraCostsMinor),
      discountsMinor: Value(discountsMinor),
      status: Value(status),
      purchasedAt: Value(purchasedAt),
      createdAt: Value(createdAt),
    );
  }

  factory PurchaseBatchesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseBatchesTableData(
      id: serializer.fromJson<String>(json['id']),
      storeName: serializer.fromJson<String>(json['storeName']),
      invoiceReference: serializer.fromJson<String?>(json['invoiceReference']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      extraCostsMinor: serializer.fromJson<int>(json['extraCostsMinor']),
      discountsMinor: serializer.fromJson<int>(json['discountsMinor']),
      status: serializer.fromJson<String>(json['status']),
      purchasedAt: serializer.fromJson<DateTime>(json['purchasedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'storeName': serializer.toJson<String>(storeName),
      'invoiceReference': serializer.toJson<String?>(invoiceReference),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'extraCostsMinor': serializer.toJson<int>(extraCostsMinor),
      'discountsMinor': serializer.toJson<int>(discountsMinor),
      'status': serializer.toJson<String>(status),
      'purchasedAt': serializer.toJson<DateTime>(purchasedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PurchaseBatchesTableData copyWith({
    String? id,
    String? storeName,
    Value<String?> invoiceReference = const Value.absent(),
    String? currencyCode,
    int? extraCostsMinor,
    int? discountsMinor,
    String? status,
    DateTime? purchasedAt,
    DateTime? createdAt,
  }) => PurchaseBatchesTableData(
    id: id ?? this.id,
    storeName: storeName ?? this.storeName,
    invoiceReference: invoiceReference.present
        ? invoiceReference.value
        : this.invoiceReference,
    currencyCode: currencyCode ?? this.currencyCode,
    extraCostsMinor: extraCostsMinor ?? this.extraCostsMinor,
    discountsMinor: discountsMinor ?? this.discountsMinor,
    status: status ?? this.status,
    purchasedAt: purchasedAt ?? this.purchasedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  PurchaseBatchesTableData copyWithCompanion(
    PurchaseBatchesTableCompanion data,
  ) {
    return PurchaseBatchesTableData(
      id: data.id.present ? data.id.value : this.id,
      storeName: data.storeName.present ? data.storeName.value : this.storeName,
      invoiceReference: data.invoiceReference.present
          ? data.invoiceReference.value
          : this.invoiceReference,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      extraCostsMinor: data.extraCostsMinor.present
          ? data.extraCostsMinor.value
          : this.extraCostsMinor,
      discountsMinor: data.discountsMinor.present
          ? data.discountsMinor.value
          : this.discountsMinor,
      status: data.status.present ? data.status.value : this.status,
      purchasedAt: data.purchasedAt.present
          ? data.purchasedAt.value
          : this.purchasedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseBatchesTableData(')
          ..write('id: $id, ')
          ..write('storeName: $storeName, ')
          ..write('invoiceReference: $invoiceReference, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('extraCostsMinor: $extraCostsMinor, ')
          ..write('discountsMinor: $discountsMinor, ')
          ..write('status: $status, ')
          ..write('purchasedAt: $purchasedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    storeName,
    invoiceReference,
    currencyCode,
    extraCostsMinor,
    discountsMinor,
    status,
    purchasedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseBatchesTableData &&
          other.id == this.id &&
          other.storeName == this.storeName &&
          other.invoiceReference == this.invoiceReference &&
          other.currencyCode == this.currencyCode &&
          other.extraCostsMinor == this.extraCostsMinor &&
          other.discountsMinor == this.discountsMinor &&
          other.status == this.status &&
          other.purchasedAt == this.purchasedAt &&
          other.createdAt == this.createdAt);
}

class PurchaseBatchesTableCompanion
    extends UpdateCompanion<PurchaseBatchesTableData> {
  final Value<String> id;
  final Value<String> storeName;
  final Value<String?> invoiceReference;
  final Value<String> currencyCode;
  final Value<int> extraCostsMinor;
  final Value<int> discountsMinor;
  final Value<String> status;
  final Value<DateTime> purchasedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PurchaseBatchesTableCompanion({
    this.id = const Value.absent(),
    this.storeName = const Value.absent(),
    this.invoiceReference = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.extraCostsMinor = const Value.absent(),
    this.discountsMinor = const Value.absent(),
    this.status = const Value.absent(),
    this.purchasedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseBatchesTableCompanion.insert({
    required String id,
    required String storeName,
    this.invoiceReference = const Value.absent(),
    required String currencyCode,
    this.extraCostsMinor = const Value.absent(),
    this.discountsMinor = const Value.absent(),
    required String status,
    required DateTime purchasedAt,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       storeName = Value(storeName),
       currencyCode = Value(currencyCode),
       status = Value(status),
       purchasedAt = Value(purchasedAt);
  static Insertable<PurchaseBatchesTableData> custom({
    Expression<String>? id,
    Expression<String>? storeName,
    Expression<String>? invoiceReference,
    Expression<String>? currencyCode,
    Expression<int>? extraCostsMinor,
    Expression<int>? discountsMinor,
    Expression<String>? status,
    Expression<DateTime>? purchasedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeName != null) 'store_name': storeName,
      if (invoiceReference != null) 'invoice_reference': invoiceReference,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (extraCostsMinor != null) 'extra_costs_minor': extraCostsMinor,
      if (discountsMinor != null) 'discounts_minor': discountsMinor,
      if (status != null) 'status': status,
      if (purchasedAt != null) 'purchased_at': purchasedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseBatchesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? storeName,
    Value<String?>? invoiceReference,
    Value<String>? currencyCode,
    Value<int>? extraCostsMinor,
    Value<int>? discountsMinor,
    Value<String>? status,
    Value<DateTime>? purchasedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PurchaseBatchesTableCompanion(
      id: id ?? this.id,
      storeName: storeName ?? this.storeName,
      invoiceReference: invoiceReference ?? this.invoiceReference,
      currencyCode: currencyCode ?? this.currencyCode,
      extraCostsMinor: extraCostsMinor ?? this.extraCostsMinor,
      discountsMinor: discountsMinor ?? this.discountsMinor,
      status: status ?? this.status,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (storeName.present) {
      map['store_name'] = Variable<String>(storeName.value);
    }
    if (invoiceReference.present) {
      map['invoice_reference'] = Variable<String>(invoiceReference.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (extraCostsMinor.present) {
      map['extra_costs_minor'] = Variable<int>(extraCostsMinor.value);
    }
    if (discountsMinor.present) {
      map['discounts_minor'] = Variable<int>(discountsMinor.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (purchasedAt.present) {
      map['purchased_at'] = Variable<DateTime>(purchasedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseBatchesTableCompanion(')
          ..write('id: $id, ')
          ..write('storeName: $storeName, ')
          ..write('invoiceReference: $invoiceReference, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('extraCostsMinor: $extraCostsMinor, ')
          ..write('discountsMinor: $discountsMinor, ')
          ..write('status: $status, ')
          ..write('purchasedAt: $purchasedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseBatchItemsTableTable extends PurchaseBatchItemsTable
    with TableInfo<$PurchaseBatchItemsTableTable, PurchaseBatchItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseBatchItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta(
    'batchId',
  );
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchase_batches (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _orderItemIdMeta = const VerificationMeta(
    'orderItemId',
  );
  @override
  late final GeneratedColumn<String> orderItemId = GeneratedColumn<String>(
    'order_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES order_items (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostMinorMeta = const VerificationMeta(
    'unitCostMinor',
  );
  @override
  late final GeneratedColumn<int> unitCostMinor = GeneratedColumn<int>(
    'unit_cost_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allocatedExtraCostMinorMeta =
      const VerificationMeta('allocatedExtraCostMinor');
  @override
  late final GeneratedColumn<int> allocatedExtraCostMinor =
      GeneratedColumn<int>(
        'allocated_extra_cost_minor',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _manualOverrideReasonMeta =
      const VerificationMeta('manualOverrideReason');
  @override
  late final GeneratedColumn<String> manualOverrideReason =
      GeneratedColumn<String>(
        'manual_override_reason',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    batchId,
    orderItemId,
    quantity,
    unitCostMinor,
    allocatedExtraCostMinor,
    manualOverrideReason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_batch_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseBatchItemsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(
        _batchIdMeta,
        batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('order_item_id')) {
      context.handle(
        _orderItemIdMeta,
        orderItemId.isAcceptableOrUnknown(
          data['order_item_id']!,
          _orderItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_orderItemIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_cost_minor')) {
      context.handle(
        _unitCostMinorMeta,
        unitCostMinor.isAcceptableOrUnknown(
          data['unit_cost_minor']!,
          _unitCostMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitCostMinorMeta);
    }
    if (data.containsKey('allocated_extra_cost_minor')) {
      context.handle(
        _allocatedExtraCostMinorMeta,
        allocatedExtraCostMinor.isAcceptableOrUnknown(
          data['allocated_extra_cost_minor']!,
          _allocatedExtraCostMinorMeta,
        ),
      );
    }
    if (data.containsKey('manual_override_reason')) {
      context.handle(
        _manualOverrideReasonMeta,
        manualOverrideReason.isAcceptableOrUnknown(
          data['manual_override_reason']!,
          _manualOverrideReasonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseBatchItemsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseBatchItemsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      batchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_id'],
      )!,
      orderItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_item_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitCostMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_cost_minor'],
      )!,
      allocatedExtraCostMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}allocated_extra_cost_minor'],
      )!,
      manualOverrideReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manual_override_reason'],
      ),
    );
  }

  @override
  $PurchaseBatchItemsTableTable createAlias(String alias) {
    return $PurchaseBatchItemsTableTable(attachedDatabase, alias);
  }
}

class PurchaseBatchItemsTableData extends DataClass
    implements Insertable<PurchaseBatchItemsTableData> {
  final String id;
  final String batchId;
  final String orderItemId;
  final int quantity;
  final int unitCostMinor;
  final int allocatedExtraCostMinor;
  final String? manualOverrideReason;
  const PurchaseBatchItemsTableData({
    required this.id,
    required this.batchId,
    required this.orderItemId,
    required this.quantity,
    required this.unitCostMinor,
    required this.allocatedExtraCostMinor,
    this.manualOverrideReason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['batch_id'] = Variable<String>(batchId);
    map['order_item_id'] = Variable<String>(orderItemId);
    map['quantity'] = Variable<int>(quantity);
    map['unit_cost_minor'] = Variable<int>(unitCostMinor);
    map['allocated_extra_cost_minor'] = Variable<int>(allocatedExtraCostMinor);
    if (!nullToAbsent || manualOverrideReason != null) {
      map['manual_override_reason'] = Variable<String>(manualOverrideReason);
    }
    return map;
  }

  PurchaseBatchItemsTableCompanion toCompanion(bool nullToAbsent) {
    return PurchaseBatchItemsTableCompanion(
      id: Value(id),
      batchId: Value(batchId),
      orderItemId: Value(orderItemId),
      quantity: Value(quantity),
      unitCostMinor: Value(unitCostMinor),
      allocatedExtraCostMinor: Value(allocatedExtraCostMinor),
      manualOverrideReason: manualOverrideReason == null && nullToAbsent
          ? const Value.absent()
          : Value(manualOverrideReason),
    );
  }

  factory PurchaseBatchItemsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseBatchItemsTableData(
      id: serializer.fromJson<String>(json['id']),
      batchId: serializer.fromJson<String>(json['batchId']),
      orderItemId: serializer.fromJson<String>(json['orderItemId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitCostMinor: serializer.fromJson<int>(json['unitCostMinor']),
      allocatedExtraCostMinor: serializer.fromJson<int>(
        json['allocatedExtraCostMinor'],
      ),
      manualOverrideReason: serializer.fromJson<String?>(
        json['manualOverrideReason'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'batchId': serializer.toJson<String>(batchId),
      'orderItemId': serializer.toJson<String>(orderItemId),
      'quantity': serializer.toJson<int>(quantity),
      'unitCostMinor': serializer.toJson<int>(unitCostMinor),
      'allocatedExtraCostMinor': serializer.toJson<int>(
        allocatedExtraCostMinor,
      ),
      'manualOverrideReason': serializer.toJson<String?>(manualOverrideReason),
    };
  }

  PurchaseBatchItemsTableData copyWith({
    String? id,
    String? batchId,
    String? orderItemId,
    int? quantity,
    int? unitCostMinor,
    int? allocatedExtraCostMinor,
    Value<String?> manualOverrideReason = const Value.absent(),
  }) => PurchaseBatchItemsTableData(
    id: id ?? this.id,
    batchId: batchId ?? this.batchId,
    orderItemId: orderItemId ?? this.orderItemId,
    quantity: quantity ?? this.quantity,
    unitCostMinor: unitCostMinor ?? this.unitCostMinor,
    allocatedExtraCostMinor:
        allocatedExtraCostMinor ?? this.allocatedExtraCostMinor,
    manualOverrideReason: manualOverrideReason.present
        ? manualOverrideReason.value
        : this.manualOverrideReason,
  );
  PurchaseBatchItemsTableData copyWithCompanion(
    PurchaseBatchItemsTableCompanion data,
  ) {
    return PurchaseBatchItemsTableData(
      id: data.id.present ? data.id.value : this.id,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      orderItemId: data.orderItemId.present
          ? data.orderItemId.value
          : this.orderItemId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitCostMinor: data.unitCostMinor.present
          ? data.unitCostMinor.value
          : this.unitCostMinor,
      allocatedExtraCostMinor: data.allocatedExtraCostMinor.present
          ? data.allocatedExtraCostMinor.value
          : this.allocatedExtraCostMinor,
      manualOverrideReason: data.manualOverrideReason.present
          ? data.manualOverrideReason.value
          : this.manualOverrideReason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseBatchItemsTableData(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('orderItemId: $orderItemId, ')
          ..write('quantity: $quantity, ')
          ..write('unitCostMinor: $unitCostMinor, ')
          ..write('allocatedExtraCostMinor: $allocatedExtraCostMinor, ')
          ..write('manualOverrideReason: $manualOverrideReason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    batchId,
    orderItemId,
    quantity,
    unitCostMinor,
    allocatedExtraCostMinor,
    manualOverrideReason,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseBatchItemsTableData &&
          other.id == this.id &&
          other.batchId == this.batchId &&
          other.orderItemId == this.orderItemId &&
          other.quantity == this.quantity &&
          other.unitCostMinor == this.unitCostMinor &&
          other.allocatedExtraCostMinor == this.allocatedExtraCostMinor &&
          other.manualOverrideReason == this.manualOverrideReason);
}

class PurchaseBatchItemsTableCompanion
    extends UpdateCompanion<PurchaseBatchItemsTableData> {
  final Value<String> id;
  final Value<String> batchId;
  final Value<String> orderItemId;
  final Value<int> quantity;
  final Value<int> unitCostMinor;
  final Value<int> allocatedExtraCostMinor;
  final Value<String?> manualOverrideReason;
  final Value<int> rowid;
  const PurchaseBatchItemsTableCompanion({
    this.id = const Value.absent(),
    this.batchId = const Value.absent(),
    this.orderItemId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitCostMinor = const Value.absent(),
    this.allocatedExtraCostMinor = const Value.absent(),
    this.manualOverrideReason = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseBatchItemsTableCompanion.insert({
    required String id,
    required String batchId,
    required String orderItemId,
    required int quantity,
    required int unitCostMinor,
    this.allocatedExtraCostMinor = const Value.absent(),
    this.manualOverrideReason = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       batchId = Value(batchId),
       orderItemId = Value(orderItemId),
       quantity = Value(quantity),
       unitCostMinor = Value(unitCostMinor);
  static Insertable<PurchaseBatchItemsTableData> custom({
    Expression<String>? id,
    Expression<String>? batchId,
    Expression<String>? orderItemId,
    Expression<int>? quantity,
    Expression<int>? unitCostMinor,
    Expression<int>? allocatedExtraCostMinor,
    Expression<String>? manualOverrideReason,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchId != null) 'batch_id': batchId,
      if (orderItemId != null) 'order_item_id': orderItemId,
      if (quantity != null) 'quantity': quantity,
      if (unitCostMinor != null) 'unit_cost_minor': unitCostMinor,
      if (allocatedExtraCostMinor != null)
        'allocated_extra_cost_minor': allocatedExtraCostMinor,
      if (manualOverrideReason != null)
        'manual_override_reason': manualOverrideReason,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseBatchItemsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? batchId,
    Value<String>? orderItemId,
    Value<int>? quantity,
    Value<int>? unitCostMinor,
    Value<int>? allocatedExtraCostMinor,
    Value<String?>? manualOverrideReason,
    Value<int>? rowid,
  }) {
    return PurchaseBatchItemsTableCompanion(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      orderItemId: orderItemId ?? this.orderItemId,
      quantity: quantity ?? this.quantity,
      unitCostMinor: unitCostMinor ?? this.unitCostMinor,
      allocatedExtraCostMinor:
          allocatedExtraCostMinor ?? this.allocatedExtraCostMinor,
      manualOverrideReason: manualOverrideReason ?? this.manualOverrideReason,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (orderItemId.present) {
      map['order_item_id'] = Variable<String>(orderItemId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitCostMinor.present) {
      map['unit_cost_minor'] = Variable<int>(unitCostMinor.value);
    }
    if (allocatedExtraCostMinor.present) {
      map['allocated_extra_cost_minor'] = Variable<int>(
        allocatedExtraCostMinor.value,
      );
    }
    if (manualOverrideReason.present) {
      map['manual_override_reason'] = Variable<String>(
        manualOverrideReason.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseBatchItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('orderItemId: $orderItemId, ')
          ..write('quantity: $quantity, ')
          ..write('unitCostMinor: $unitCostMinor, ')
          ..write('allocatedExtraCostMinor: $allocatedExtraCostMinor, ')
          ..write('manualOverrideReason: $manualOverrideReason, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinancialTransactionsTableTable extends FinancialTransactionsTable
    with
        TableInfo<
          $FinancialTransactionsTableTable,
          FinancialTransactionsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialTransactionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _walletIdMeta = const VerificationMeta(
    'walletId',
  );
  @override
  late final GeneratedColumn<String> walletId = GeneratedColumn<String>(
    'wallet_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wallets (id)',
    ),
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES currencies (code)',
    ),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
    'reference_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    type,
    walletId,
    amountMinor,
    currencyCode,
    occurredAt,
    referenceId,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinancialTransactionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('wallet_id')) {
      context.handle(
        _walletIdMeta,
        walletId.isAcceptableOrUnknown(data['wallet_id']!, _walletIdMeta),
      );
    } else if (isInserting) {
      context.missing(_walletIdMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
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
  FinancialTransactionsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialTransactionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      walletId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wallet_id'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FinancialTransactionsTableTable createAlias(String alias) {
    return $FinancialTransactionsTableTable(attachedDatabase, alias);
  }
}

class FinancialTransactionsTableData extends DataClass
    implements Insertable<FinancialTransactionsTableData> {
  final String id;
  final String type;
  final String walletId;
  final int amountMinor;
  final String currencyCode;
  final DateTime occurredAt;
  final String? referenceId;
  final String? notes;
  final DateTime createdAt;
  const FinancialTransactionsTableData({
    required this.id,
    required this.type,
    required this.walletId,
    required this.amountMinor,
    required this.currencyCode,
    required this.occurredAt,
    this.referenceId,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['wallet_id'] = Variable<String>(walletId);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['currency_code'] = Variable<String>(currencyCode);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FinancialTransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return FinancialTransactionsTableCompanion(
      id: Value(id),
      type: Value(type),
      walletId: Value(walletId),
      amountMinor: Value(amountMinor),
      currencyCode: Value(currencyCode),
      occurredAt: Value(occurredAt),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory FinancialTransactionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialTransactionsTableData(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      walletId: serializer.fromJson<String>(json['walletId']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'walletId': serializer.toJson<String>(walletId),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'referenceId': serializer.toJson<String?>(referenceId),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FinancialTransactionsTableData copyWith({
    String? id,
    String? type,
    String? walletId,
    int? amountMinor,
    String? currencyCode,
    DateTime? occurredAt,
    Value<String?> referenceId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => FinancialTransactionsTableData(
    id: id ?? this.id,
    type: type ?? this.type,
    walletId: walletId ?? this.walletId,
    amountMinor: amountMinor ?? this.amountMinor,
    currencyCode: currencyCode ?? this.currencyCode,
    occurredAt: occurredAt ?? this.occurredAt,
    referenceId: referenceId.present ? referenceId.value : this.referenceId,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  FinancialTransactionsTableData copyWithCompanion(
    FinancialTransactionsTableCompanion data,
  ) {
    return FinancialTransactionsTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      walletId: data.walletId.present ? data.walletId.value : this.walletId,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialTransactionsTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('walletId: $walletId, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('referenceId: $referenceId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    walletId,
    amountMinor,
    currencyCode,
    occurredAt,
    referenceId,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialTransactionsTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.walletId == this.walletId &&
          other.amountMinor == this.amountMinor &&
          other.currencyCode == this.currencyCode &&
          other.occurredAt == this.occurredAt &&
          other.referenceId == this.referenceId &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class FinancialTransactionsTableCompanion
    extends UpdateCompanion<FinancialTransactionsTableData> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> walletId;
  final Value<int> amountMinor;
  final Value<String> currencyCode;
  final Value<DateTime> occurredAt;
  final Value<String?> referenceId;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FinancialTransactionsTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.walletId = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinancialTransactionsTableCompanion.insert({
    required String id,
    required String type,
    required String walletId,
    required int amountMinor,
    required String currencyCode,
    required DateTime occurredAt,
    this.referenceId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       walletId = Value(walletId),
       amountMinor = Value(amountMinor),
       currencyCode = Value(currencyCode),
       occurredAt = Value(occurredAt);
  static Insertable<FinancialTransactionsTableData> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? walletId,
    Expression<int>? amountMinor,
    Expression<String>? currencyCode,
    Expression<DateTime>? occurredAt,
    Expression<String>? referenceId,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (walletId != null) 'wallet_id': walletId,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (referenceId != null) 'reference_id': referenceId,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinancialTransactionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String>? walletId,
    Value<int>? amountMinor,
    Value<String>? currencyCode,
    Value<DateTime>? occurredAt,
    Value<String?>? referenceId,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return FinancialTransactionsTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      walletId: walletId ?? this.walletId,
      amountMinor: amountMinor ?? this.amountMinor,
      currencyCode: currencyCode ?? this.currencyCode,
      occurredAt: occurredAt ?? this.occurredAt,
      referenceId: referenceId ?? this.referenceId,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (walletId.present) {
      map['wallet_id'] = Variable<String>(walletId.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialTransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('walletId: $walletId, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('referenceId: $referenceId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTableTable extends PaymentsTable
    with TableInfo<$PaymentsTableTable, PaymentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES currencies (code)',
    ),
  );
  static const VerificationMeta _walletIdMeta = const VerificationMeta(
    'walletId',
  );
  @override
  late final GeneratedColumn<String> walletId = GeneratedColumn<String>(
    'wallet_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wallets (id)',
    ),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerId,
    direction,
    amountMinor,
    currencyCode,
    walletId,
    occurredAt,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('wallet_id')) {
      context.handle(
        _walletIdMeta,
        walletId.isAcceptableOrUnknown(data['wallet_id']!, _walletIdMeta),
      );
    } else if (isInserting) {
      context.missing(_walletIdMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      walletId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wallet_id'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PaymentsTableTable createAlias(String alias) {
    return $PaymentsTableTable(attachedDatabase, alias);
  }
}

class PaymentsTableData extends DataClass
    implements Insertable<PaymentsTableData> {
  final String id;
  final String customerId;
  final String direction;
  final int amountMinor;
  final String currencyCode;
  final String walletId;
  final DateTime occurredAt;
  final String? notes;
  const PaymentsTableData({
    required this.id,
    required this.customerId,
    required this.direction,
    required this.amountMinor,
    required this.currencyCode,
    required this.walletId,
    required this.occurredAt,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['customer_id'] = Variable<String>(customerId);
    map['direction'] = Variable<String>(direction);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['currency_code'] = Variable<String>(currencyCode);
    map['wallet_id'] = Variable<String>(walletId);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PaymentsTableCompanion toCompanion(bool nullToAbsent) {
    return PaymentsTableCompanion(
      id: Value(id),
      customerId: Value(customerId),
      direction: Value(direction),
      amountMinor: Value(amountMinor),
      currencyCode: Value(currencyCode),
      walletId: Value(walletId),
      occurredAt: Value(occurredAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PaymentsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentsTableData(
      id: serializer.fromJson<String>(json['id']),
      customerId: serializer.fromJson<String>(json['customerId']),
      direction: serializer.fromJson<String>(json['direction']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      walletId: serializer.fromJson<String>(json['walletId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'customerId': serializer.toJson<String>(customerId),
      'direction': serializer.toJson<String>(direction),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'walletId': serializer.toJson<String>(walletId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PaymentsTableData copyWith({
    String? id,
    String? customerId,
    String? direction,
    int? amountMinor,
    String? currencyCode,
    String? walletId,
    DateTime? occurredAt,
    Value<String?> notes = const Value.absent(),
  }) => PaymentsTableData(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    direction: direction ?? this.direction,
    amountMinor: amountMinor ?? this.amountMinor,
    currencyCode: currencyCode ?? this.currencyCode,
    walletId: walletId ?? this.walletId,
    occurredAt: occurredAt ?? this.occurredAt,
    notes: notes.present ? notes.value : this.notes,
  );
  PaymentsTableData copyWithCompanion(PaymentsTableCompanion data) {
    return PaymentsTableData(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      direction: data.direction.present ? data.direction.value : this.direction,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      walletId: data.walletId.present ? data.walletId.value : this.walletId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsTableData(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('direction: $direction, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('walletId: $walletId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    customerId,
    direction,
    amountMinor,
    currencyCode,
    walletId,
    occurredAt,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentsTableData &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.direction == this.direction &&
          other.amountMinor == this.amountMinor &&
          other.currencyCode == this.currencyCode &&
          other.walletId == this.walletId &&
          other.occurredAt == this.occurredAt &&
          other.notes == this.notes);
}

class PaymentsTableCompanion extends UpdateCompanion<PaymentsTableData> {
  final Value<String> id;
  final Value<String> customerId;
  final Value<String> direction;
  final Value<int> amountMinor;
  final Value<String> currencyCode;
  final Value<String> walletId;
  final Value<DateTime> occurredAt;
  final Value<String?> notes;
  final Value<int> rowid;
  const PaymentsTableCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.direction = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.walletId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsTableCompanion.insert({
    required String id,
    required String customerId,
    required String direction,
    required int amountMinor,
    required String currencyCode,
    required String walletId,
    required DateTime occurredAt,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       customerId = Value(customerId),
       direction = Value(direction),
       amountMinor = Value(amountMinor),
       currencyCode = Value(currencyCode),
       walletId = Value(walletId),
       occurredAt = Value(occurredAt);
  static Insertable<PaymentsTableData> custom({
    Expression<String>? id,
    Expression<String>? customerId,
    Expression<String>? direction,
    Expression<int>? amountMinor,
    Expression<String>? currencyCode,
    Expression<String>? walletId,
    Expression<DateTime>? occurredAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (direction != null) 'direction': direction,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (walletId != null) 'wallet_id': walletId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? customerId,
    Value<String>? direction,
    Value<int>? amountMinor,
    Value<String>? currencyCode,
    Value<String>? walletId,
    Value<DateTime>? occurredAt,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return PaymentsTableCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      direction: direction ?? this.direction,
      amountMinor: amountMinor ?? this.amountMinor,
      currencyCode: currencyCode ?? this.currencyCode,
      walletId: walletId ?? this.walletId,
      occurredAt: occurredAt ?? this.occurredAt,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (walletId.present) {
      map['wallet_id'] = Variable<String>(walletId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsTableCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('direction: $direction, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('walletId: $walletId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentAllocationsTableTable extends PaymentAllocationsTable
    with TableInfo<$PaymentAllocationsTableTable, PaymentAllocationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentAllocationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentIdMeta = const VerificationMeta(
    'paymentId',
  );
  @override
  late final GeneratedColumn<String> paymentId = GeneratedColumn<String>(
    'payment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES payments (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customer_orders (id)',
    ),
  );
  static const VerificationMeta _allocatedMinorMeta = const VerificationMeta(
    'allocatedMinor',
  );
  @override
  late final GeneratedColumn<int> allocatedMinor = GeneratedColumn<int>(
    'allocated_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES currencies (code)',
    ),
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
    paymentId,
    orderId,
    allocatedMinor,
    currencyCode,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentAllocationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('payment_id')) {
      context.handle(
        _paymentIdMeta,
        paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_paymentIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('allocated_minor')) {
      context.handle(
        _allocatedMinorMeta,
        allocatedMinor.isAcceptableOrUnknown(
          data['allocated_minor']!,
          _allocatedMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_allocatedMinorMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
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
  PaymentAllocationsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentAllocationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      paymentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      allocatedMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}allocated_minor'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaymentAllocationsTableTable createAlias(String alias) {
    return $PaymentAllocationsTableTable(attachedDatabase, alias);
  }
}

class PaymentAllocationsTableData extends DataClass
    implements Insertable<PaymentAllocationsTableData> {
  final String id;
  final String paymentId;
  final String orderId;
  final int allocatedMinor;
  final String currencyCode;
  final DateTime createdAt;
  const PaymentAllocationsTableData({
    required this.id,
    required this.paymentId,
    required this.orderId,
    required this.allocatedMinor,
    required this.currencyCode,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['payment_id'] = Variable<String>(paymentId);
    map['order_id'] = Variable<String>(orderId);
    map['allocated_minor'] = Variable<int>(allocatedMinor);
    map['currency_code'] = Variable<String>(currencyCode);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaymentAllocationsTableCompanion toCompanion(bool nullToAbsent) {
    return PaymentAllocationsTableCompanion(
      id: Value(id),
      paymentId: Value(paymentId),
      orderId: Value(orderId),
      allocatedMinor: Value(allocatedMinor),
      currencyCode: Value(currencyCode),
      createdAt: Value(createdAt),
    );
  }

  factory PaymentAllocationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentAllocationsTableData(
      id: serializer.fromJson<String>(json['id']),
      paymentId: serializer.fromJson<String>(json['paymentId']),
      orderId: serializer.fromJson<String>(json['orderId']),
      allocatedMinor: serializer.fromJson<int>(json['allocatedMinor']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'paymentId': serializer.toJson<String>(paymentId),
      'orderId': serializer.toJson<String>(orderId),
      'allocatedMinor': serializer.toJson<int>(allocatedMinor),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PaymentAllocationsTableData copyWith({
    String? id,
    String? paymentId,
    String? orderId,
    int? allocatedMinor,
    String? currencyCode,
    DateTime? createdAt,
  }) => PaymentAllocationsTableData(
    id: id ?? this.id,
    paymentId: paymentId ?? this.paymentId,
    orderId: orderId ?? this.orderId,
    allocatedMinor: allocatedMinor ?? this.allocatedMinor,
    currencyCode: currencyCode ?? this.currencyCode,
    createdAt: createdAt ?? this.createdAt,
  );
  PaymentAllocationsTableData copyWithCompanion(
    PaymentAllocationsTableCompanion data,
  ) {
    return PaymentAllocationsTableData(
      id: data.id.present ? data.id.value : this.id,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      allocatedMinor: data.allocatedMinor.present
          ? data.allocatedMinor.value
          : this.allocatedMinor,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAllocationsTableData(')
          ..write('id: $id, ')
          ..write('paymentId: $paymentId, ')
          ..write('orderId: $orderId, ')
          ..write('allocatedMinor: $allocatedMinor, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    paymentId,
    orderId,
    allocatedMinor,
    currencyCode,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentAllocationsTableData &&
          other.id == this.id &&
          other.paymentId == this.paymentId &&
          other.orderId == this.orderId &&
          other.allocatedMinor == this.allocatedMinor &&
          other.currencyCode == this.currencyCode &&
          other.createdAt == this.createdAt);
}

class PaymentAllocationsTableCompanion
    extends UpdateCompanion<PaymentAllocationsTableData> {
  final Value<String> id;
  final Value<String> paymentId;
  final Value<String> orderId;
  final Value<int> allocatedMinor;
  final Value<String> currencyCode;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PaymentAllocationsTableCompanion({
    this.id = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.allocatedMinor = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentAllocationsTableCompanion.insert({
    required String id,
    required String paymentId,
    required String orderId,
    required int allocatedMinor,
    required String currencyCode,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       paymentId = Value(paymentId),
       orderId = Value(orderId),
       allocatedMinor = Value(allocatedMinor),
       currencyCode = Value(currencyCode);
  static Insertable<PaymentAllocationsTableData> custom({
    Expression<String>? id,
    Expression<String>? paymentId,
    Expression<String>? orderId,
    Expression<int>? allocatedMinor,
    Expression<String>? currencyCode,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (paymentId != null) 'payment_id': paymentId,
      if (orderId != null) 'order_id': orderId,
      if (allocatedMinor != null) 'allocated_minor': allocatedMinor,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentAllocationsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? paymentId,
    Value<String>? orderId,
    Value<int>? allocatedMinor,
    Value<String>? currencyCode,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PaymentAllocationsTableCompanion(
      id: id ?? this.id,
      paymentId: paymentId ?? this.paymentId,
      orderId: orderId ?? this.orderId,
      allocatedMinor: allocatedMinor ?? this.allocatedMinor,
      currencyCode: currencyCode ?? this.currencyCode,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<String>(paymentId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (allocatedMinor.present) {
      map['allocated_minor'] = Variable<int>(allocatedMinor.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAllocationsTableCompanion(')
          ..write('id: $id, ')
          ..write('paymentId: $paymentId, ')
          ..write('orderId: $orderId, ')
          ..write('allocatedMinor: $allocatedMinor, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExchangeRatesTableTable extends ExchangeRatesTable
    with TableInfo<$ExchangeRatesTableTable, ExchangeRatesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExchangeRatesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromCurrencyMeta = const VerificationMeta(
    'fromCurrency',
  );
  @override
  late final GeneratedColumn<String> fromCurrency = GeneratedColumn<String>(
    'from_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES currencies (code)',
    ),
  );
  static const VerificationMeta _toCurrencyMeta = const VerificationMeta(
    'toCurrency',
  );
  @override
  late final GeneratedColumn<String> toCurrency = GeneratedColumn<String>(
    'to_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES currencies (code)',
    ),
  );
  static const VerificationMeta _rateDecimalMeta = const VerificationMeta(
    'rateDecimal',
  );
  @override
  late final GeneratedColumn<double> rateDecimal = GeneratedColumn<double>(
    'rate_decimal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _effectiveAtMeta = const VerificationMeta(
    'effectiveAt',
  );
  @override
  late final GeneratedColumn<DateTime> effectiveAt = GeneratedColumn<DateTime>(
    'effective_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fromCurrency,
    toCurrency,
    rateDecimal,
    effectiveAt,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exchange_rates';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExchangeRatesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('from_currency')) {
      context.handle(
        _fromCurrencyMeta,
        fromCurrency.isAcceptableOrUnknown(
          data['from_currency']!,
          _fromCurrencyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromCurrencyMeta);
    }
    if (data.containsKey('to_currency')) {
      context.handle(
        _toCurrencyMeta,
        toCurrency.isAcceptableOrUnknown(data['to_currency']!, _toCurrencyMeta),
      );
    } else if (isInserting) {
      context.missing(_toCurrencyMeta);
    }
    if (data.containsKey('rate_decimal')) {
      context.handle(
        _rateDecimalMeta,
        rateDecimal.isAcceptableOrUnknown(
          data['rate_decimal']!,
          _rateDecimalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rateDecimalMeta);
    }
    if (data.containsKey('effective_at')) {
      context.handle(
        _effectiveAtMeta,
        effectiveAt.isAcceptableOrUnknown(
          data['effective_at']!,
          _effectiveAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveAtMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExchangeRatesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExchangeRatesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fromCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_currency'],
      )!,
      toCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_currency'],
      )!,
      rateDecimal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate_decimal'],
      )!,
      effectiveAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}effective_at'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
    );
  }

  @override
  $ExchangeRatesTableTable createAlias(String alias) {
    return $ExchangeRatesTableTable(attachedDatabase, alias);
  }
}

class ExchangeRatesTableData extends DataClass
    implements Insertable<ExchangeRatesTableData> {
  final String id;
  final String fromCurrency;
  final String toCurrency;
  final double rateDecimal;
  final DateTime effectiveAt;
  final String? source;
  const ExchangeRatesTableData({
    required this.id,
    required this.fromCurrency,
    required this.toCurrency,
    required this.rateDecimal,
    required this.effectiveAt,
    this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['from_currency'] = Variable<String>(fromCurrency);
    map['to_currency'] = Variable<String>(toCurrency);
    map['rate_decimal'] = Variable<double>(rateDecimal);
    map['effective_at'] = Variable<DateTime>(effectiveAt);
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    return map;
  }

  ExchangeRatesTableCompanion toCompanion(bool nullToAbsent) {
    return ExchangeRatesTableCompanion(
      id: Value(id),
      fromCurrency: Value(fromCurrency),
      toCurrency: Value(toCurrency),
      rateDecimal: Value(rateDecimal),
      effectiveAt: Value(effectiveAt),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
    );
  }

  factory ExchangeRatesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExchangeRatesTableData(
      id: serializer.fromJson<String>(json['id']),
      fromCurrency: serializer.fromJson<String>(json['fromCurrency']),
      toCurrency: serializer.fromJson<String>(json['toCurrency']),
      rateDecimal: serializer.fromJson<double>(json['rateDecimal']),
      effectiveAt: serializer.fromJson<DateTime>(json['effectiveAt']),
      source: serializer.fromJson<String?>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fromCurrency': serializer.toJson<String>(fromCurrency),
      'toCurrency': serializer.toJson<String>(toCurrency),
      'rateDecimal': serializer.toJson<double>(rateDecimal),
      'effectiveAt': serializer.toJson<DateTime>(effectiveAt),
      'source': serializer.toJson<String?>(source),
    };
  }

  ExchangeRatesTableData copyWith({
    String? id,
    String? fromCurrency,
    String? toCurrency,
    double? rateDecimal,
    DateTime? effectiveAt,
    Value<String?> source = const Value.absent(),
  }) => ExchangeRatesTableData(
    id: id ?? this.id,
    fromCurrency: fromCurrency ?? this.fromCurrency,
    toCurrency: toCurrency ?? this.toCurrency,
    rateDecimal: rateDecimal ?? this.rateDecimal,
    effectiveAt: effectiveAt ?? this.effectiveAt,
    source: source.present ? source.value : this.source,
  );
  ExchangeRatesTableData copyWithCompanion(ExchangeRatesTableCompanion data) {
    return ExchangeRatesTableData(
      id: data.id.present ? data.id.value : this.id,
      fromCurrency: data.fromCurrency.present
          ? data.fromCurrency.value
          : this.fromCurrency,
      toCurrency: data.toCurrency.present
          ? data.toCurrency.value
          : this.toCurrency,
      rateDecimal: data.rateDecimal.present
          ? data.rateDecimal.value
          : this.rateDecimal,
      effectiveAt: data.effectiveAt.present
          ? data.effectiveAt.value
          : this.effectiveAt,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRatesTableData(')
          ..write('id: $id, ')
          ..write('fromCurrency: $fromCurrency, ')
          ..write('toCurrency: $toCurrency, ')
          ..write('rateDecimal: $rateDecimal, ')
          ..write('effectiveAt: $effectiveAt, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fromCurrency,
    toCurrency,
    rateDecimal,
    effectiveAt,
    source,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExchangeRatesTableData &&
          other.id == this.id &&
          other.fromCurrency == this.fromCurrency &&
          other.toCurrency == this.toCurrency &&
          other.rateDecimal == this.rateDecimal &&
          other.effectiveAt == this.effectiveAt &&
          other.source == this.source);
}

class ExchangeRatesTableCompanion
    extends UpdateCompanion<ExchangeRatesTableData> {
  final Value<String> id;
  final Value<String> fromCurrency;
  final Value<String> toCurrency;
  final Value<double> rateDecimal;
  final Value<DateTime> effectiveAt;
  final Value<String?> source;
  final Value<int> rowid;
  const ExchangeRatesTableCompanion({
    this.id = const Value.absent(),
    this.fromCurrency = const Value.absent(),
    this.toCurrency = const Value.absent(),
    this.rateDecimal = const Value.absent(),
    this.effectiveAt = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExchangeRatesTableCompanion.insert({
    required String id,
    required String fromCurrency,
    required String toCurrency,
    required double rateDecimal,
    required DateTime effectiveAt,
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fromCurrency = Value(fromCurrency),
       toCurrency = Value(toCurrency),
       rateDecimal = Value(rateDecimal),
       effectiveAt = Value(effectiveAt);
  static Insertable<ExchangeRatesTableData> custom({
    Expression<String>? id,
    Expression<String>? fromCurrency,
    Expression<String>? toCurrency,
    Expression<double>? rateDecimal,
    Expression<DateTime>? effectiveAt,
    Expression<String>? source,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromCurrency != null) 'from_currency': fromCurrency,
      if (toCurrency != null) 'to_currency': toCurrency,
      if (rateDecimal != null) 'rate_decimal': rateDecimal,
      if (effectiveAt != null) 'effective_at': effectiveAt,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExchangeRatesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? fromCurrency,
    Value<String>? toCurrency,
    Value<double>? rateDecimal,
    Value<DateTime>? effectiveAt,
    Value<String?>? source,
    Value<int>? rowid,
  }) {
    return ExchangeRatesTableCompanion(
      id: id ?? this.id,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      rateDecimal: rateDecimal ?? this.rateDecimal,
      effectiveAt: effectiveAt ?? this.effectiveAt,
      source: source ?? this.source,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fromCurrency.present) {
      map['from_currency'] = Variable<String>(fromCurrency.value);
    }
    if (toCurrency.present) {
      map['to_currency'] = Variable<String>(toCurrency.value);
    }
    if (rateDecimal.present) {
      map['rate_decimal'] = Variable<double>(rateDecimal.value);
    }
    if (effectiveAt.present) {
      map['effective_at'] = Variable<DateTime>(effectiveAt.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRatesTableCompanion(')
          ..write('id: $id, ')
          ..write('fromCurrency: $fromCurrency, ')
          ..write('toCurrency: $toCurrency, ')
          ..write('rateDecimal: $rateDecimal, ')
          ..write('effectiveAt: $effectiveAt, ')
          ..write('source: $source, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTableTable extends ExpensesTable
    with TableInfo<$ExpensesTableTable, ExpensesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES currencies (code)',
    ),
  );
  static const VerificationMeta _walletIdMeta = const VerificationMeta(
    'walletId',
  );
  @override
  late final GeneratedColumn<String> walletId = GeneratedColumn<String>(
    'wallet_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wallets (id)',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customer_orders (id)',
    ),
  );
  static const VerificationMeta _purchaseBatchIdMeta = const VerificationMeta(
    'purchaseBatchId',
  );
  @override
  late final GeneratedColumn<String> purchaseBatchId = GeneratedColumn<String>(
    'purchase_batch_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchase_batches (id)',
    ),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    category,
    amountMinor,
    currencyCode,
    walletId,
    orderId,
    purchaseBatchId,
    notes,
    occurredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpensesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('wallet_id')) {
      context.handle(
        _walletIdMeta,
        walletId.isAcceptableOrUnknown(data['wallet_id']!, _walletIdMeta),
      );
    } else if (isInserting) {
      context.missing(_walletIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    }
    if (data.containsKey('purchase_batch_id')) {
      context.handle(
        _purchaseBatchIdMeta,
        purchaseBatchId.isAcceptableOrUnknown(
          data['purchase_batch_id']!,
          _purchaseBatchIdMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpensesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpensesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      walletId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wallet_id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      ),
      purchaseBatchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_batch_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $ExpensesTableTable createAlias(String alias) {
    return $ExpensesTableTable(attachedDatabase, alias);
  }
}

class ExpensesTableData extends DataClass
    implements Insertable<ExpensesTableData> {
  final String id;
  final String category;
  final int amountMinor;
  final String currencyCode;
  final String walletId;
  final String? orderId;
  final String? purchaseBatchId;
  final String? notes;
  final DateTime occurredAt;
  const ExpensesTableData({
    required this.id,
    required this.category,
    required this.amountMinor,
    required this.currencyCode,
    required this.walletId,
    this.orderId,
    this.purchaseBatchId,
    this.notes,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category'] = Variable<String>(category);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['currency_code'] = Variable<String>(currencyCode);
    map['wallet_id'] = Variable<String>(walletId);
    if (!nullToAbsent || orderId != null) {
      map['order_id'] = Variable<String>(orderId);
    }
    if (!nullToAbsent || purchaseBatchId != null) {
      map['purchase_batch_id'] = Variable<String>(purchaseBatchId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  ExpensesTableCompanion toCompanion(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      category: Value(category),
      amountMinor: Value(amountMinor),
      currencyCode: Value(currencyCode),
      walletId: Value(walletId),
      orderId: orderId == null && nullToAbsent
          ? const Value.absent()
          : Value(orderId),
      purchaseBatchId: purchaseBatchId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseBatchId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      occurredAt: Value(occurredAt),
    );
  }

  factory ExpensesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpensesTableData(
      id: serializer.fromJson<String>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      walletId: serializer.fromJson<String>(json['walletId']),
      orderId: serializer.fromJson<String?>(json['orderId']),
      purchaseBatchId: serializer.fromJson<String?>(json['purchaseBatchId']),
      notes: serializer.fromJson<String?>(json['notes']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'category': serializer.toJson<String>(category),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'walletId': serializer.toJson<String>(walletId),
      'orderId': serializer.toJson<String?>(orderId),
      'purchaseBatchId': serializer.toJson<String?>(purchaseBatchId),
      'notes': serializer.toJson<String?>(notes),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  ExpensesTableData copyWith({
    String? id,
    String? category,
    int? amountMinor,
    String? currencyCode,
    String? walletId,
    Value<String?> orderId = const Value.absent(),
    Value<String?> purchaseBatchId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? occurredAt,
  }) => ExpensesTableData(
    id: id ?? this.id,
    category: category ?? this.category,
    amountMinor: amountMinor ?? this.amountMinor,
    currencyCode: currencyCode ?? this.currencyCode,
    walletId: walletId ?? this.walletId,
    orderId: orderId.present ? orderId.value : this.orderId,
    purchaseBatchId: purchaseBatchId.present
        ? purchaseBatchId.value
        : this.purchaseBatchId,
    notes: notes.present ? notes.value : this.notes,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  ExpensesTableData copyWithCompanion(ExpensesTableCompanion data) {
    return ExpensesTableData(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      walletId: data.walletId.present ? data.walletId.value : this.walletId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      purchaseBatchId: data.purchaseBatchId.present
          ? data.purchaseBatchId.value
          : this.purchaseBatchId,
      notes: data.notes.present ? data.notes.value : this.notes,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTableData(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('walletId: $walletId, ')
          ..write('orderId: $orderId, ')
          ..write('purchaseBatchId: $purchaseBatchId, ')
          ..write('notes: $notes, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    category,
    amountMinor,
    currencyCode,
    walletId,
    orderId,
    purchaseBatchId,
    notes,
    occurredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpensesTableData &&
          other.id == this.id &&
          other.category == this.category &&
          other.amountMinor == this.amountMinor &&
          other.currencyCode == this.currencyCode &&
          other.walletId == this.walletId &&
          other.orderId == this.orderId &&
          other.purchaseBatchId == this.purchaseBatchId &&
          other.notes == this.notes &&
          other.occurredAt == this.occurredAt);
}

class ExpensesTableCompanion extends UpdateCompanion<ExpensesTableData> {
  final Value<String> id;
  final Value<String> category;
  final Value<int> amountMinor;
  final Value<String> currencyCode;
  final Value<String> walletId;
  final Value<String?> orderId;
  final Value<String?> purchaseBatchId;
  final Value<String?> notes;
  final Value<DateTime> occurredAt;
  final Value<int> rowid;
  const ExpensesTableCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.walletId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.purchaseBatchId = const Value.absent(),
    this.notes = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesTableCompanion.insert({
    required String id,
    required String category,
    required int amountMinor,
    required String currencyCode,
    required String walletId,
    this.orderId = const Value.absent(),
    this.purchaseBatchId = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime occurredAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       category = Value(category),
       amountMinor = Value(amountMinor),
       currencyCode = Value(currencyCode),
       walletId = Value(walletId),
       occurredAt = Value(occurredAt);
  static Insertable<ExpensesTableData> custom({
    Expression<String>? id,
    Expression<String>? category,
    Expression<int>? amountMinor,
    Expression<String>? currencyCode,
    Expression<String>? walletId,
    Expression<String>? orderId,
    Expression<String>? purchaseBatchId,
    Expression<String>? notes,
    Expression<DateTime>? occurredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (walletId != null) 'wallet_id': walletId,
      if (orderId != null) 'order_id': orderId,
      if (purchaseBatchId != null) 'purchase_batch_id': purchaseBatchId,
      if (notes != null) 'notes': notes,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? category,
    Value<int>? amountMinor,
    Value<String>? currencyCode,
    Value<String>? walletId,
    Value<String?>? orderId,
    Value<String?>? purchaseBatchId,
    Value<String?>? notes,
    Value<DateTime>? occurredAt,
    Value<int>? rowid,
  }) {
    return ExpensesTableCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      amountMinor: amountMinor ?? this.amountMinor,
      currencyCode: currencyCode ?? this.currencyCode,
      walletId: walletId ?? this.walletId,
      orderId: orderId ?? this.orderId,
      purchaseBatchId: purchaseBatchId ?? this.purchaseBatchId,
      notes: notes ?? this.notes,
      occurredAt: occurredAt ?? this.occurredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (walletId.present) {
      map['wallet_id'] = Variable<String>(walletId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (purchaseBatchId.present) {
      map['purchase_batch_id'] = Variable<String>(purchaseBatchId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTableCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('walletId: $walletId, ')
          ..write('orderId: $orderId, ')
          ..write('purchaseBatchId: $purchaseBatchId, ')
          ..write('notes: $notes, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CurrenciesTableTable currenciesTable = $CurrenciesTableTable(
    this,
  );
  late final $WalletsTableTable walletsTable = $WalletsTableTable(this);
  late final $WalletBalancesTableTable walletBalancesTable =
      $WalletBalancesTableTable(this);
  late final $CustomersTableTable customersTable = $CustomersTableTable(this);
  late final $ProductsTableTable productsTable = $ProductsTableTable(this);
  late final $CustomerOrdersTableTable customerOrdersTable =
      $CustomerOrdersTableTable(this);
  late final $OrderItemsTableTable orderItemsTable = $OrderItemsTableTable(
    this,
  );
  late final $PurchaseBatchesTableTable purchaseBatchesTable =
      $PurchaseBatchesTableTable(this);
  late final $PurchaseBatchItemsTableTable purchaseBatchItemsTable =
      $PurchaseBatchItemsTableTable(this);
  late final $FinancialTransactionsTableTable financialTransactionsTable =
      $FinancialTransactionsTableTable(this);
  late final $PaymentsTableTable paymentsTable = $PaymentsTableTable(this);
  late final $PaymentAllocationsTableTable paymentAllocationsTable =
      $PaymentAllocationsTableTable(this);
  late final $ExchangeRatesTableTable exchangeRatesTable =
      $ExchangeRatesTableTable(this);
  late final $ExpensesTableTable expensesTable = $ExpensesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    currenciesTable,
    walletsTable,
    walletBalancesTable,
    customersTable,
    productsTable,
    customerOrdersTable,
    orderItemsTable,
    purchaseBatchesTable,
    purchaseBatchItemsTable,
    financialTransactionsTable,
    paymentsTable,
    paymentAllocationsTable,
    exchangeRatesTable,
    expensesTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'wallets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('wallet_balances', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'customer_orders',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('order_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'purchase_batches',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('purchase_batch_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'payments',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('payment_allocations', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CurrenciesTableTableCreateCompanionBuilder =
    CurrenciesTableCompanion Function({
      required String code,
      required String nameAr,
      required String symbolAr,
      Value<int> minorUnitDigits,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$CurrenciesTableTableUpdateCompanionBuilder =
    CurrenciesTableCompanion Function({
      Value<String> code,
      Value<String> nameAr,
      Value<String> symbolAr,
      Value<int> minorUnitDigits,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$CurrenciesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CurrenciesTableTable,
          CurrenciesTableData
        > {
  $$CurrenciesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $WalletBalancesTableTable,
    List<WalletBalancesTableData>
  >
  _walletBalancesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.walletBalancesTable,
        aliasName: $_aliasNameGenerator(
          db.currenciesTable.code,
          db.walletBalancesTable.currencyCode,
        ),
      );

  $$WalletBalancesTableTableProcessedTableManager get walletBalancesTableRefs {
    final manager =
        $$WalletBalancesTableTableTableManager(
          $_db,
          $_db.walletBalancesTable,
        ).filter(
          (f) => f.currencyCode.code.sqlEquals($_itemColumn<String>('code')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _walletBalancesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CustomersTableTable, List<CustomersTableData>>
  _customersTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.customersTable,
    aliasName: $_aliasNameGenerator(
      db.currenciesTable.code,
      db.customersTable.defaultCurrencyCode,
    ),
  );

  $$CustomersTableTableProcessedTableManager get customersTableRefs {
    final manager = $$CustomersTableTableTableManager($_db, $_db.customersTable)
        .filter(
          (f) => f.defaultCurrencyCode.code.sqlEquals(
            $_itemColumn<String>('code')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_customersTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CustomerOrdersTableTable,
    List<CustomerOrdersTableData>
  >
  _customerOrdersTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.customerOrdersTable,
        aliasName: $_aliasNameGenerator(
          db.currenciesTable.code,
          db.customerOrdersTable.currencyCode,
        ),
      );

  $$CustomerOrdersTableTableProcessedTableManager get customerOrdersTableRefs {
    final manager =
        $$CustomerOrdersTableTableTableManager(
          $_db,
          $_db.customerOrdersTable,
        ).filter(
          (f) => f.currencyCode.code.sqlEquals($_itemColumn<String>('code')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _customerOrdersTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PurchaseBatchesTableTable,
    List<PurchaseBatchesTableData>
  >
  _purchaseBatchesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.purchaseBatchesTable,
        aliasName: $_aliasNameGenerator(
          db.currenciesTable.code,
          db.purchaseBatchesTable.currencyCode,
        ),
      );

  $$PurchaseBatchesTableTableProcessedTableManager
  get purchaseBatchesTableRefs {
    final manager =
        $$PurchaseBatchesTableTableTableManager(
          $_db,
          $_db.purchaseBatchesTable,
        ).filter(
          (f) => f.currencyCode.code.sqlEquals($_itemColumn<String>('code')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _purchaseBatchesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $FinancialTransactionsTableTable,
    List<FinancialTransactionsTableData>
  >
  _financialTransactionsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.financialTransactionsTable,
        aliasName: $_aliasNameGenerator(
          db.currenciesTable.code,
          db.financialTransactionsTable.currencyCode,
        ),
      );

  $$FinancialTransactionsTableTableProcessedTableManager
  get financialTransactionsTableRefs {
    final manager =
        $$FinancialTransactionsTableTableTableManager(
          $_db,
          $_db.financialTransactionsTable,
        ).filter(
          (f) => f.currencyCode.code.sqlEquals($_itemColumn<String>('code')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _financialTransactionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTableTable, List<PaymentsTableData>>
  _paymentsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.paymentsTable,
    aliasName: $_aliasNameGenerator(
      db.currenciesTable.code,
      db.paymentsTable.currencyCode,
    ),
  );

  $$PaymentsTableTableProcessedTableManager get paymentsTableRefs {
    final manager = $$PaymentsTableTableTableManager($_db, $_db.paymentsTable)
        .filter(
          (f) => f.currencyCode.code.sqlEquals($_itemColumn<String>('code')!),
        );

    final cache = $_typedResult.readTableOrNull(_paymentsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PaymentAllocationsTableTable,
    List<PaymentAllocationsTableData>
  >
  _paymentAllocationsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.paymentAllocationsTable,
        aliasName: $_aliasNameGenerator(
          db.currenciesTable.code,
          db.paymentAllocationsTable.currencyCode,
        ),
      );

  $$PaymentAllocationsTableTableProcessedTableManager
  get paymentAllocationsTableRefs {
    final manager =
        $$PaymentAllocationsTableTableTableManager(
          $_db,
          $_db.paymentAllocationsTable,
        ).filter(
          (f) => f.currencyCode.code.sqlEquals($_itemColumn<String>('code')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _paymentAllocationsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ExchangeRatesTableTable,
    List<ExchangeRatesTableData>
  >
  _ratesFromTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exchangeRatesTable,
    aliasName: $_aliasNameGenerator(
      db.currenciesTable.code,
      db.exchangeRatesTable.fromCurrency,
    ),
  );

  $$ExchangeRatesTableTableProcessedTableManager get ratesFrom {
    final manager =
        $$ExchangeRatesTableTableTableManager(
          $_db,
          $_db.exchangeRatesTable,
        ).filter(
          (f) => f.fromCurrency.code.sqlEquals($_itemColumn<String>('code')!),
        );

    final cache = $_typedResult.readTableOrNull(_ratesFromTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ExchangeRatesTableTable,
    List<ExchangeRatesTableData>
  >
  _ratesToTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exchangeRatesTable,
    aliasName: $_aliasNameGenerator(
      db.currenciesTable.code,
      db.exchangeRatesTable.toCurrency,
    ),
  );

  $$ExchangeRatesTableTableProcessedTableManager get ratesTo {
    final manager = $$ExchangeRatesTableTableTableManager(
      $_db,
      $_db.exchangeRatesTable,
    ).filter((f) => f.toCurrency.code.sqlEquals($_itemColumn<String>('code')!));

    final cache = $_typedResult.readTableOrNull(_ratesToTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTableTable, List<ExpensesTableData>>
  _expensesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expensesTable,
    aliasName: $_aliasNameGenerator(
      db.currenciesTable.code,
      db.expensesTable.currencyCode,
    ),
  );

  $$ExpensesTableTableProcessedTableManager get expensesTableRefs {
    final manager = $$ExpensesTableTableTableManager($_db, $_db.expensesTable)
        .filter(
          (f) => f.currencyCode.code.sqlEquals($_itemColumn<String>('code')!),
        );

    final cache = $_typedResult.readTableOrNull(_expensesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CurrenciesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CurrenciesTableTable> {
  $$CurrenciesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbolAr => $composableBuilder(
    column: $table.symbolAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minorUnitDigits => $composableBuilder(
    column: $table.minorUnitDigits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> walletBalancesTableRefs(
    Expression<bool> Function($$WalletBalancesTableTableFilterComposer f) f,
  ) {
    final $$WalletBalancesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.walletBalancesTable,
      getReferencedColumn: (t) => t.currencyCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletBalancesTableTableFilterComposer(
            $db: $db,
            $table: $db.walletBalancesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customersTableRefs(
    Expression<bool> Function($$CustomersTableTableFilterComposer f) f,
  ) {
    final $$CustomersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.customersTable,
      getReferencedColumn: (t) => t.defaultCurrencyCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableTableFilterComposer(
            $db: $db,
            $table: $db.customersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customerOrdersTableRefs(
    Expression<bool> Function($$CustomerOrdersTableTableFilterComposer f) f,
  ) {
    final $$CustomerOrdersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.customerOrdersTable,
      getReferencedColumn: (t) => t.currencyCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerOrdersTableTableFilterComposer(
            $db: $db,
            $table: $db.customerOrdersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchaseBatchesTableRefs(
    Expression<bool> Function($$PurchaseBatchesTableTableFilterComposer f) f,
  ) {
    final $$PurchaseBatchesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.purchaseBatchesTable,
      getReferencedColumn: (t) => t.currencyCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseBatchesTableTableFilterComposer(
            $db: $db,
            $table: $db.purchaseBatchesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> financialTransactionsTableRefs(
    Expression<bool> Function($$FinancialTransactionsTableTableFilterComposer f)
    f,
  ) {
    final $$FinancialTransactionsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.code,
          referencedTable: $db.financialTransactionsTable,
          getReferencedColumn: (t) => t.currencyCode,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialTransactionsTableTableFilterComposer(
                $db: $db,
                $table: $db.financialTransactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> paymentsTableRefs(
    Expression<bool> Function($$PaymentsTableTableFilterComposer f) f,
  ) {
    final $$PaymentsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.paymentsTable,
      getReferencedColumn: (t) => t.currencyCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableTableFilterComposer(
            $db: $db,
            $table: $db.paymentsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentAllocationsTableRefs(
    Expression<bool> Function($$PaymentAllocationsTableTableFilterComposer f) f,
  ) {
    final $$PaymentAllocationsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.code,
          referencedTable: $db.paymentAllocationsTable,
          getReferencedColumn: (t) => t.currencyCode,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAllocationsTableTableFilterComposer(
                $db: $db,
                $table: $db.paymentAllocationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> ratesFrom(
    Expression<bool> Function($$ExchangeRatesTableTableFilterComposer f) f,
  ) {
    final $$ExchangeRatesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.exchangeRatesTable,
      getReferencedColumn: (t) => t.fromCurrency,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExchangeRatesTableTableFilterComposer(
            $db: $db,
            $table: $db.exchangeRatesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ratesTo(
    Expression<bool> Function($$ExchangeRatesTableTableFilterComposer f) f,
  ) {
    final $$ExchangeRatesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.exchangeRatesTable,
      getReferencedColumn: (t) => t.toCurrency,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExchangeRatesTableTableFilterComposer(
            $db: $db,
            $table: $db.exchangeRatesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesTableRefs(
    Expression<bool> Function($$ExpensesTableTableFilterComposer f) f,
  ) {
    final $$ExpensesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.currencyCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableFilterComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CurrenciesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CurrenciesTableTable> {
  $$CurrenciesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbolAr => $composableBuilder(
    column: $table.symbolAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minorUnitDigits => $composableBuilder(
    column: $table.minorUnitDigits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CurrenciesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CurrenciesTableTable> {
  $$CurrenciesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get symbolAr =>
      $composableBuilder(column: $table.symbolAr, builder: (column) => column);

  GeneratedColumn<int> get minorUnitDigits => $composableBuilder(
    column: $table.minorUnitDigits,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> walletBalancesTableRefs<T extends Object>(
    Expression<T> Function($$WalletBalancesTableTableAnnotationComposer a) f,
  ) {
    final $$WalletBalancesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.code,
          referencedTable: $db.walletBalancesTable,
          getReferencedColumn: (t) => t.currencyCode,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WalletBalancesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.walletBalancesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> customersTableRefs<T extends Object>(
    Expression<T> Function($$CustomersTableTableAnnotationComposer a) f,
  ) {
    final $$CustomersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.customersTable,
      getReferencedColumn: (t) => t.defaultCurrencyCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.customersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> customerOrdersTableRefs<T extends Object>(
    Expression<T> Function($$CustomerOrdersTableTableAnnotationComposer a) f,
  ) {
    final $$CustomerOrdersTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.code,
          referencedTable: $db.customerOrdersTable,
          getReferencedColumn: (t) => t.currencyCode,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CustomerOrdersTableTableAnnotationComposer(
                $db: $db,
                $table: $db.customerOrdersTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> purchaseBatchesTableRefs<T extends Object>(
    Expression<T> Function($$PurchaseBatchesTableTableAnnotationComposer a) f,
  ) {
    final $$PurchaseBatchesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.code,
          referencedTable: $db.purchaseBatchesTable,
          getReferencedColumn: (t) => t.currencyCode,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseBatchesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseBatchesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> financialTransactionsTableRefs<T extends Object>(
    Expression<T> Function(
      $$FinancialTransactionsTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$FinancialTransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.code,
          referencedTable: $db.financialTransactionsTable,
          getReferencedColumn: (t) => t.currencyCode,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialTransactionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.financialTransactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> paymentsTableRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.paymentsTable,
      getReferencedColumn: (t) => t.currencyCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentAllocationsTableRefs<T extends Object>(
    Expression<T> Function($$PaymentAllocationsTableTableAnnotationComposer a)
    f,
  ) {
    final $$PaymentAllocationsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.code,
          referencedTable: $db.paymentAllocationsTable,
          getReferencedColumn: (t) => t.currencyCode,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAllocationsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.paymentAllocationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> ratesFrom<T extends Object>(
    Expression<T> Function($$ExchangeRatesTableTableAnnotationComposer a) f,
  ) {
    final $$ExchangeRatesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.code,
          referencedTable: $db.exchangeRatesTable,
          getReferencedColumn: (t) => t.fromCurrency,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExchangeRatesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.exchangeRatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> ratesTo<T extends Object>(
    Expression<T> Function($$ExchangeRatesTableTableAnnotationComposer a) f,
  ) {
    final $$ExchangeRatesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.code,
          referencedTable: $db.exchangeRatesTable,
          getReferencedColumn: (t) => t.toCurrency,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExchangeRatesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.exchangeRatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> expensesTableRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.currencyCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CurrenciesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CurrenciesTableTable,
          CurrenciesTableData,
          $$CurrenciesTableTableFilterComposer,
          $$CurrenciesTableTableOrderingComposer,
          $$CurrenciesTableTableAnnotationComposer,
          $$CurrenciesTableTableCreateCompanionBuilder,
          $$CurrenciesTableTableUpdateCompanionBuilder,
          (CurrenciesTableData, $$CurrenciesTableTableReferences),
          CurrenciesTableData,
          PrefetchHooks Function({
            bool walletBalancesTableRefs,
            bool customersTableRefs,
            bool customerOrdersTableRefs,
            bool purchaseBatchesTableRefs,
            bool financialTransactionsTableRefs,
            bool paymentsTableRefs,
            bool paymentAllocationsTableRefs,
            bool ratesFrom,
            bool ratesTo,
            bool expensesTableRefs,
          })
        > {
  $$CurrenciesTableTableTableManager(
    _$AppDatabase db,
    $CurrenciesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CurrenciesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CurrenciesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CurrenciesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<String> nameAr = const Value.absent(),
                Value<String> symbolAr = const Value.absent(),
                Value<int> minorUnitDigits = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CurrenciesTableCompanion(
                code: code,
                nameAr: nameAr,
                symbolAr: symbolAr,
                minorUnitDigits: minorUnitDigits,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required String nameAr,
                required String symbolAr,
                Value<int> minorUnitDigits = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CurrenciesTableCompanion.insert(
                code: code,
                nameAr: nameAr,
                symbolAr: symbolAr,
                minorUnitDigits: minorUnitDigits,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CurrenciesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                walletBalancesTableRefs = false,
                customersTableRefs = false,
                customerOrdersTableRefs = false,
                purchaseBatchesTableRefs = false,
                financialTransactionsTableRefs = false,
                paymentsTableRefs = false,
                paymentAllocationsTableRefs = false,
                ratesFrom = false,
                ratesTo = false,
                expensesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (walletBalancesTableRefs) db.walletBalancesTable,
                    if (customersTableRefs) db.customersTable,
                    if (customerOrdersTableRefs) db.customerOrdersTable,
                    if (purchaseBatchesTableRefs) db.purchaseBatchesTable,
                    if (financialTransactionsTableRefs)
                      db.financialTransactionsTable,
                    if (paymentsTableRefs) db.paymentsTable,
                    if (paymentAllocationsTableRefs) db.paymentAllocationsTable,
                    if (ratesFrom) db.exchangeRatesTable,
                    if (ratesTo) db.exchangeRatesTable,
                    if (expensesTableRefs) db.expensesTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (walletBalancesTableRefs)
                        await $_getPrefetchedData<
                          CurrenciesTableData,
                          $CurrenciesTableTable,
                          WalletBalancesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CurrenciesTableTableReferences
                              ._walletBalancesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CurrenciesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).walletBalancesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.currencyCode == item.code,
                              ),
                          typedResults: items,
                        ),
                      if (customersTableRefs)
                        await $_getPrefetchedData<
                          CurrenciesTableData,
                          $CurrenciesTableTable,
                          CustomersTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CurrenciesTableTableReferences
                              ._customersTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CurrenciesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).customersTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.defaultCurrencyCode == item.code,
                              ),
                          typedResults: items,
                        ),
                      if (customerOrdersTableRefs)
                        await $_getPrefetchedData<
                          CurrenciesTableData,
                          $CurrenciesTableTable,
                          CustomerOrdersTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CurrenciesTableTableReferences
                              ._customerOrdersTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CurrenciesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).customerOrdersTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.currencyCode == item.code,
                              ),
                          typedResults: items,
                        ),
                      if (purchaseBatchesTableRefs)
                        await $_getPrefetchedData<
                          CurrenciesTableData,
                          $CurrenciesTableTable,
                          PurchaseBatchesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CurrenciesTableTableReferences
                              ._purchaseBatchesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CurrenciesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseBatchesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.currencyCode == item.code,
                              ),
                          typedResults: items,
                        ),
                      if (financialTransactionsTableRefs)
                        await $_getPrefetchedData<
                          CurrenciesTableData,
                          $CurrenciesTableTable,
                          FinancialTransactionsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CurrenciesTableTableReferences
                              ._financialTransactionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CurrenciesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).financialTransactionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.currencyCode == item.code,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsTableRefs)
                        await $_getPrefetchedData<
                          CurrenciesTableData,
                          $CurrenciesTableTable,
                          PaymentsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CurrenciesTableTableReferences
                              ._paymentsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CurrenciesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.currencyCode == item.code,
                              ),
                          typedResults: items,
                        ),
                      if (paymentAllocationsTableRefs)
                        await $_getPrefetchedData<
                          CurrenciesTableData,
                          $CurrenciesTableTable,
                          PaymentAllocationsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CurrenciesTableTableReferences
                              ._paymentAllocationsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CurrenciesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentAllocationsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.currencyCode == item.code,
                              ),
                          typedResults: items,
                        ),
                      if (ratesFrom)
                        await $_getPrefetchedData<
                          CurrenciesTableData,
                          $CurrenciesTableTable,
                          ExchangeRatesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CurrenciesTableTableReferences
                              ._ratesFromTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CurrenciesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).ratesFrom,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fromCurrency == item.code,
                              ),
                          typedResults: items,
                        ),
                      if (ratesTo)
                        await $_getPrefetchedData<
                          CurrenciesTableData,
                          $CurrenciesTableTable,
                          ExchangeRatesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CurrenciesTableTableReferences
                              ._ratesToTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CurrenciesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).ratesTo,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.toCurrency == item.code,
                              ),
                          typedResults: items,
                        ),
                      if (expensesTableRefs)
                        await $_getPrefetchedData<
                          CurrenciesTableData,
                          $CurrenciesTableTable,
                          ExpensesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CurrenciesTableTableReferences
                              ._expensesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CurrenciesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.currencyCode == item.code,
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

typedef $$CurrenciesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CurrenciesTableTable,
      CurrenciesTableData,
      $$CurrenciesTableTableFilterComposer,
      $$CurrenciesTableTableOrderingComposer,
      $$CurrenciesTableTableAnnotationComposer,
      $$CurrenciesTableTableCreateCompanionBuilder,
      $$CurrenciesTableTableUpdateCompanionBuilder,
      (CurrenciesTableData, $$CurrenciesTableTableReferences),
      CurrenciesTableData,
      PrefetchHooks Function({
        bool walletBalancesTableRefs,
        bool customersTableRefs,
        bool customerOrdersTableRefs,
        bool purchaseBatchesTableRefs,
        bool financialTransactionsTableRefs,
        bool paymentsTableRefs,
        bool paymentAllocationsTableRefs,
        bool ratesFrom,
        bool ratesTo,
        bool expensesTableRefs,
      })
    >;
typedef $$WalletsTableTableCreateCompanionBuilder =
    WalletsTableCompanion Function({
      required String id,
      required String name,
      required String type,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$WalletsTableTableUpdateCompanionBuilder =
    WalletsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$WalletsTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $WalletsTableTable, WalletsTableData> {
  $$WalletsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $WalletBalancesTableTable,
    List<WalletBalancesTableData>
  >
  _walletBalancesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.walletBalancesTable,
        aliasName: $_aliasNameGenerator(
          db.walletsTable.id,
          db.walletBalancesTable.walletId,
        ),
      );

  $$WalletBalancesTableTableProcessedTableManager get walletBalancesTableRefs {
    final manager = $$WalletBalancesTableTableTableManager(
      $_db,
      $_db.walletBalancesTable,
    ).filter((f) => f.walletId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _walletBalancesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $FinancialTransactionsTableTable,
    List<FinancialTransactionsTableData>
  >
  _financialTransactionsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.financialTransactionsTable,
        aliasName: $_aliasNameGenerator(
          db.walletsTable.id,
          db.financialTransactionsTable.walletId,
        ),
      );

  $$FinancialTransactionsTableTableProcessedTableManager
  get financialTransactionsTableRefs {
    final manager = $$FinancialTransactionsTableTableTableManager(
      $_db,
      $_db.financialTransactionsTable,
    ).filter((f) => f.walletId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _financialTransactionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTableTable, List<PaymentsTableData>>
  _paymentsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.paymentsTable,
    aliasName: $_aliasNameGenerator(
      db.walletsTable.id,
      db.paymentsTable.walletId,
    ),
  );

  $$PaymentsTableTableProcessedTableManager get paymentsTableRefs {
    final manager = $$PaymentsTableTableTableManager(
      $_db,
      $_db.paymentsTable,
    ).filter((f) => f.walletId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTableTable, List<ExpensesTableData>>
  _expensesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expensesTable,
    aliasName: $_aliasNameGenerator(
      db.walletsTable.id,
      db.expensesTable.walletId,
    ),
  );

  $$ExpensesTableTableProcessedTableManager get expensesTableRefs {
    final manager = $$ExpensesTableTableTableManager(
      $_db,
      $_db.expensesTable,
    ).filter((f) => f.walletId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WalletsTableTableFilterComposer
    extends Composer<_$AppDatabase, $WalletsTableTable> {
  $$WalletsTableTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
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

  Expression<bool> walletBalancesTableRefs(
    Expression<bool> Function($$WalletBalancesTableTableFilterComposer f) f,
  ) {
    final $$WalletBalancesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.walletBalancesTable,
      getReferencedColumn: (t) => t.walletId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletBalancesTableTableFilterComposer(
            $db: $db,
            $table: $db.walletBalancesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> financialTransactionsTableRefs(
    Expression<bool> Function($$FinancialTransactionsTableTableFilterComposer f)
    f,
  ) {
    final $$FinancialTransactionsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.financialTransactionsTable,
          getReferencedColumn: (t) => t.walletId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialTransactionsTableTableFilterComposer(
                $db: $db,
                $table: $db.financialTransactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> paymentsTableRefs(
    Expression<bool> Function($$PaymentsTableTableFilterComposer f) f,
  ) {
    final $$PaymentsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentsTable,
      getReferencedColumn: (t) => t.walletId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableTableFilterComposer(
            $db: $db,
            $table: $db.paymentsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesTableRefs(
    Expression<bool> Function($$ExpensesTableTableFilterComposer f) f,
  ) {
    final $$ExpensesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.walletId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableFilterComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WalletsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WalletsTableTable> {
  $$WalletsTableTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
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

class $$WalletsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalletsTableTable> {
  $$WalletsTableTableAnnotationComposer({
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

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> walletBalancesTableRefs<T extends Object>(
    Expression<T> Function($$WalletBalancesTableTableAnnotationComposer a) f,
  ) {
    final $$WalletBalancesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.walletBalancesTable,
          getReferencedColumn: (t) => t.walletId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WalletBalancesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.walletBalancesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> financialTransactionsTableRefs<T extends Object>(
    Expression<T> Function(
      $$FinancialTransactionsTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$FinancialTransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.financialTransactionsTable,
          getReferencedColumn: (t) => t.walletId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialTransactionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.financialTransactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> paymentsTableRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentsTable,
      getReferencedColumn: (t) => t.walletId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expensesTableRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.walletId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WalletsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalletsTableTable,
          WalletsTableData,
          $$WalletsTableTableFilterComposer,
          $$WalletsTableTableOrderingComposer,
          $$WalletsTableTableAnnotationComposer,
          $$WalletsTableTableCreateCompanionBuilder,
          $$WalletsTableTableUpdateCompanionBuilder,
          (WalletsTableData, $$WalletsTableTableReferences),
          WalletsTableData,
          PrefetchHooks Function({
            bool walletBalancesTableRefs,
            bool financialTransactionsTableRefs,
            bool paymentsTableRefs,
            bool expensesTableRefs,
          })
        > {
  $$WalletsTableTableTableManager(_$AppDatabase db, $WalletsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalletsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalletsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalletsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalletsTableCompanion(
                id: id,
                name: name,
                type: type,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalletsTableCompanion.insert(
                id: id,
                name: name,
                type: type,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WalletsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                walletBalancesTableRefs = false,
                financialTransactionsTableRefs = false,
                paymentsTableRefs = false,
                expensesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (walletBalancesTableRefs) db.walletBalancesTable,
                    if (financialTransactionsTableRefs)
                      db.financialTransactionsTable,
                    if (paymentsTableRefs) db.paymentsTable,
                    if (expensesTableRefs) db.expensesTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (walletBalancesTableRefs)
                        await $_getPrefetchedData<
                          WalletsTableData,
                          $WalletsTableTable,
                          WalletBalancesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$WalletsTableTableReferences
                              ._walletBalancesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WalletsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).walletBalancesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.walletId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (financialTransactionsTableRefs)
                        await $_getPrefetchedData<
                          WalletsTableData,
                          $WalletsTableTable,
                          FinancialTransactionsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$WalletsTableTableReferences
                              ._financialTransactionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WalletsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).financialTransactionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.walletId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsTableRefs)
                        await $_getPrefetchedData<
                          WalletsTableData,
                          $WalletsTableTable,
                          PaymentsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$WalletsTableTableReferences
                              ._paymentsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WalletsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.walletId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expensesTableRefs)
                        await $_getPrefetchedData<
                          WalletsTableData,
                          $WalletsTableTable,
                          ExpensesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$WalletsTableTableReferences
                              ._expensesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WalletsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.walletId == item.id,
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

typedef $$WalletsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalletsTableTable,
      WalletsTableData,
      $$WalletsTableTableFilterComposer,
      $$WalletsTableTableOrderingComposer,
      $$WalletsTableTableAnnotationComposer,
      $$WalletsTableTableCreateCompanionBuilder,
      $$WalletsTableTableUpdateCompanionBuilder,
      (WalletsTableData, $$WalletsTableTableReferences),
      WalletsTableData,
      PrefetchHooks Function({
        bool walletBalancesTableRefs,
        bool financialTransactionsTableRefs,
        bool paymentsTableRefs,
        bool expensesTableRefs,
      })
    >;
typedef $$WalletBalancesTableTableCreateCompanionBuilder =
    WalletBalancesTableCompanion Function({
      required String walletId,
      required String currencyCode,
      Value<int> balanceMinor,
      Value<int> rowid,
    });
typedef $$WalletBalancesTableTableUpdateCompanionBuilder =
    WalletBalancesTableCompanion Function({
      Value<String> walletId,
      Value<String> currencyCode,
      Value<int> balanceMinor,
      Value<int> rowid,
    });

final class $$WalletBalancesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WalletBalancesTableTable,
          WalletBalancesTableData
        > {
  $$WalletBalancesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WalletsTableTable _walletIdTable(_$AppDatabase db) =>
      db.walletsTable.createAlias(
        $_aliasNameGenerator(
          db.walletBalancesTable.walletId,
          db.walletsTable.id,
        ),
      );

  $$WalletsTableTableProcessedTableManager get walletId {
    final $_column = $_itemColumn<String>('wallet_id')!;

    final manager = $$WalletsTableTableTableManager(
      $_db,
      $_db.walletsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_walletIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CurrenciesTableTable _currencyCodeTable(_$AppDatabase db) =>
      db.currenciesTable.createAlias(
        $_aliasNameGenerator(
          db.walletBalancesTable.currencyCode,
          db.currenciesTable.code,
        ),
      );

  $$CurrenciesTableTableProcessedTableManager get currencyCode {
    final $_column = $_itemColumn<String>('currency_code')!;

    final manager = $$CurrenciesTableTableTableManager(
      $_db,
      $_db.currenciesTable,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_currencyCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WalletBalancesTableTableFilterComposer
    extends Composer<_$AppDatabase, $WalletBalancesTableTable> {
  $$WalletBalancesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get balanceMinor => $composableBuilder(
    column: $table.balanceMinor,
    builder: (column) => ColumnFilters(column),
  );

  $$WalletsTableTableFilterComposer get walletId {
    final $$WalletsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletsTableTableFilterComposer(
            $db: $db,
            $table: $db.walletsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableFilterComposer get currencyCode {
    final $$CurrenciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableFilterComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WalletBalancesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WalletBalancesTableTable> {
  $$WalletBalancesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get balanceMinor => $composableBuilder(
    column: $table.balanceMinor,
    builder: (column) => ColumnOrderings(column),
  );

  $$WalletsTableTableOrderingComposer get walletId {
    final $$WalletsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletsTableTableOrderingComposer(
            $db: $db,
            $table: $db.walletsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableOrderingComposer get currencyCode {
    final $$CurrenciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WalletBalancesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalletBalancesTableTable> {
  $$WalletBalancesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get balanceMinor => $composableBuilder(
    column: $table.balanceMinor,
    builder: (column) => column,
  );

  $$WalletsTableTableAnnotationComposer get walletId {
    final $$WalletsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.walletsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableAnnotationComposer get currencyCode {
    final $$CurrenciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WalletBalancesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalletBalancesTableTable,
          WalletBalancesTableData,
          $$WalletBalancesTableTableFilterComposer,
          $$WalletBalancesTableTableOrderingComposer,
          $$WalletBalancesTableTableAnnotationComposer,
          $$WalletBalancesTableTableCreateCompanionBuilder,
          $$WalletBalancesTableTableUpdateCompanionBuilder,
          (WalletBalancesTableData, $$WalletBalancesTableTableReferences),
          WalletBalancesTableData,
          PrefetchHooks Function({bool walletId, bool currencyCode})
        > {
  $$WalletBalancesTableTableTableManager(
    _$AppDatabase db,
    $WalletBalancesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalletBalancesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalletBalancesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WalletBalancesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> walletId = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> balanceMinor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalletBalancesTableCompanion(
                walletId: walletId,
                currencyCode: currencyCode,
                balanceMinor: balanceMinor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String walletId,
                required String currencyCode,
                Value<int> balanceMinor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalletBalancesTableCompanion.insert(
                walletId: walletId,
                currencyCode: currencyCode,
                balanceMinor: balanceMinor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WalletBalancesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({walletId = false, currencyCode = false}) {
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
                    if (walletId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.walletId,
                                referencedTable:
                                    $$WalletBalancesTableTableReferences
                                        ._walletIdTable(db),
                                referencedColumn:
                                    $$WalletBalancesTableTableReferences
                                        ._walletIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (currencyCode) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.currencyCode,
                                referencedTable:
                                    $$WalletBalancesTableTableReferences
                                        ._currencyCodeTable(db),
                                referencedColumn:
                                    $$WalletBalancesTableTableReferences
                                        ._currencyCodeTable(db)
                                        .code,
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

typedef $$WalletBalancesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalletBalancesTableTable,
      WalletBalancesTableData,
      $$WalletBalancesTableTableFilterComposer,
      $$WalletBalancesTableTableOrderingComposer,
      $$WalletBalancesTableTableAnnotationComposer,
      $$WalletBalancesTableTableCreateCompanionBuilder,
      $$WalletBalancesTableTableUpdateCompanionBuilder,
      (WalletBalancesTableData, $$WalletBalancesTableTableReferences),
      WalletBalancesTableData,
      PrefetchHooks Function({bool walletId, bool currencyCode})
    >;
typedef $$CustomersTableTableCreateCompanionBuilder =
    CustomersTableCompanion Function({
      required String id,
      required String name,
      required String phone,
      required String defaultCurrencyCode,
      Value<String?> notes,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$CustomersTableTableUpdateCompanionBuilder =
    CustomersTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> phone,
      Value<String> defaultCurrencyCode,
      Value<String?> notes,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$CustomersTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CustomersTableTable,
          CustomersTableData
        > {
  $$CustomersTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CurrenciesTableTable _defaultCurrencyCodeTable(_$AppDatabase db) =>
      db.currenciesTable.createAlias(
        $_aliasNameGenerator(
          db.customersTable.defaultCurrencyCode,
          db.currenciesTable.code,
        ),
      );

  $$CurrenciesTableTableProcessedTableManager get defaultCurrencyCode {
    final $_column = $_itemColumn<String>('default_currency_code')!;

    final manager = $$CurrenciesTableTableTableManager(
      $_db,
      $_db.currenciesTable,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_defaultCurrencyCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $CustomerOrdersTableTable,
    List<CustomerOrdersTableData>
  >
  _customerOrdersTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.customerOrdersTable,
        aliasName: $_aliasNameGenerator(
          db.customersTable.id,
          db.customerOrdersTable.customerId,
        ),
      );

  $$CustomerOrdersTableTableProcessedTableManager get customerOrdersTableRefs {
    final manager = $$CustomerOrdersTableTableTableManager(
      $_db,
      $_db.customerOrdersTable,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _customerOrdersTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTableTable, List<PaymentsTableData>>
  _paymentsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.paymentsTable,
    aliasName: $_aliasNameGenerator(
      db.customersTable.id,
      db.paymentsTable.customerId,
    ),
  );

  $$PaymentsTableTableProcessedTableManager get paymentsTableRefs {
    final manager = $$PaymentsTableTableTableManager(
      $_db,
      $_db.paymentsTable,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTableTable> {
  $$CustomersTableTableFilterComposer({
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

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CurrenciesTableTableFilterComposer get defaultCurrencyCode {
    final $$CurrenciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCurrencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableFilterComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> customerOrdersTableRefs(
    Expression<bool> Function($$CustomerOrdersTableTableFilterComposer f) f,
  ) {
    final $$CustomerOrdersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerOrdersTable,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerOrdersTableTableFilterComposer(
            $db: $db,
            $table: $db.customerOrdersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsTableRefs(
    Expression<bool> Function($$PaymentsTableTableFilterComposer f) f,
  ) {
    final $$PaymentsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentsTable,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableTableFilterComposer(
            $db: $db,
            $table: $db.paymentsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTableTable> {
  $$CustomersTableTableOrderingComposer({
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

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CurrenciesTableTableOrderingComposer get defaultCurrencyCode {
    final $$CurrenciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCurrencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTableTable> {
  $$CustomersTableTableAnnotationComposer({
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

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CurrenciesTableTableAnnotationComposer get defaultCurrencyCode {
    final $$CurrenciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCurrencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> customerOrdersTableRefs<T extends Object>(
    Expression<T> Function($$CustomerOrdersTableTableAnnotationComposer a) f,
  ) {
    final $$CustomerOrdersTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.customerOrdersTable,
          getReferencedColumn: (t) => t.customerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CustomerOrdersTableTableAnnotationComposer(
                $db: $db,
                $table: $db.customerOrdersTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> paymentsTableRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentsTable,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTableTable,
          CustomersTableData,
          $$CustomersTableTableFilterComposer,
          $$CustomersTableTableOrderingComposer,
          $$CustomersTableTableAnnotationComposer,
          $$CustomersTableTableCreateCompanionBuilder,
          $$CustomersTableTableUpdateCompanionBuilder,
          (CustomersTableData, $$CustomersTableTableReferences),
          CustomersTableData,
          PrefetchHooks Function({
            bool defaultCurrencyCode,
            bool customerOrdersTableRefs,
            bool paymentsTableRefs,
          })
        > {
  $$CustomersTableTableTableManager(
    _$AppDatabase db,
    $CustomersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> defaultCurrencyCode = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersTableCompanion(
                id: id,
                name: name,
                phone: phone,
                defaultCurrencyCode: defaultCurrencyCode,
                notes: notes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String phone,
                required String defaultCurrencyCode,
                Value<String?> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersTableCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                defaultCurrencyCode: defaultCurrencyCode,
                notes: notes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomersTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                defaultCurrencyCode = false,
                customerOrdersTableRefs = false,
                paymentsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (customerOrdersTableRefs) db.customerOrdersTable,
                    if (paymentsTableRefs) db.paymentsTable,
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
                        if (defaultCurrencyCode) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.defaultCurrencyCode,
                                    referencedTable:
                                        $$CustomersTableTableReferences
                                            ._defaultCurrencyCodeTable(db),
                                    referencedColumn:
                                        $$CustomersTableTableReferences
                                            ._defaultCurrencyCodeTable(db)
                                            .code,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (customerOrdersTableRefs)
                        await $_getPrefetchedData<
                          CustomersTableData,
                          $CustomersTableTable,
                          CustomerOrdersTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CustomersTableTableReferences
                              ._customerOrdersTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).customerOrdersTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsTableRefs)
                        await $_getPrefetchedData<
                          CustomersTableData,
                          $CustomersTableTable,
                          PaymentsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CustomersTableTableReferences
                              ._paymentsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
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

typedef $$CustomersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTableTable,
      CustomersTableData,
      $$CustomersTableTableFilterComposer,
      $$CustomersTableTableOrderingComposer,
      $$CustomersTableTableAnnotationComposer,
      $$CustomersTableTableCreateCompanionBuilder,
      $$CustomersTableTableUpdateCompanionBuilder,
      (CustomersTableData, $$CustomersTableTableReferences),
      CustomersTableData,
      PrefetchHooks Function({
        bool defaultCurrencyCode,
        bool customerOrdersTableRefs,
        bool paymentsTableRefs,
      })
    >;
typedef $$ProductsTableTableCreateCompanionBuilder =
    ProductsTableCompanion Function({
      required String id,
      required String name,
      Value<String?> imagePath,
      Value<String?> color,
      Value<String?> size,
      Value<String?> purchaseUrl,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ProductsTableTableUpdateCompanionBuilder =
    ProductsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> imagePath,
      Value<String?> color,
      Value<String?> size,
      Value<String?> purchaseUrl,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ProductsTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $ProductsTableTable, ProductsTableData> {
  $$ProductsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$OrderItemsTableTable, List<OrderItemsTableData>>
  _orderItemsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.orderItemsTable,
    aliasName: $_aliasNameGenerator(
      db.productsTable.id,
      db.orderItemsTable.productId,
    ),
  );

  $$OrderItemsTableTableProcessedTableManager get orderItemsTableRefs {
    final manager = $$OrderItemsTableTableTableManager(
      $_db,
      $_db.orderItemsTable,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _orderItemsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableFilterComposer({
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

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseUrl => $composableBuilder(
    column: $table.purchaseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> orderItemsTableRefs(
    Expression<bool> Function($$OrderItemsTableTableFilterComposer f) f,
  ) {
    final $$OrderItemsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItemsTable,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableTableFilterComposer(
            $db: $db,
            $table: $db.orderItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableOrderingComposer({
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

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseUrl => $composableBuilder(
    column: $table.purchaseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTableTable> {
  $$ProductsTableTableAnnotationComposer({
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

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<String> get purchaseUrl => $composableBuilder(
    column: $table.purchaseUrl,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> orderItemsTableRefs<T extends Object>(
    Expression<T> Function($$OrderItemsTableTableAnnotationComposer a) f,
  ) {
    final $$OrderItemsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItemsTable,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.orderItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTableTable,
          ProductsTableData,
          $$ProductsTableTableFilterComposer,
          $$ProductsTableTableOrderingComposer,
          $$ProductsTableTableAnnotationComposer,
          $$ProductsTableTableCreateCompanionBuilder,
          $$ProductsTableTableUpdateCompanionBuilder,
          (ProductsTableData, $$ProductsTableTableReferences),
          ProductsTableData,
          PrefetchHooks Function({bool orderItemsTableRefs})
        > {
  $$ProductsTableTableTableManager(_$AppDatabase db, $ProductsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> size = const Value.absent(),
                Value<String?> purchaseUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsTableCompanion(
                id: id,
                name: name,
                imagePath: imagePath,
                color: color,
                size: size,
                purchaseUrl: purchaseUrl,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> imagePath = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> size = const Value.absent(),
                Value<String?> purchaseUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsTableCompanion.insert(
                id: id,
                name: name,
                imagePath: imagePath,
                color: color,
                size: size,
                purchaseUrl: purchaseUrl,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({orderItemsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (orderItemsTableRefs) db.orderItemsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (orderItemsTableRefs)
                    await $_getPrefetchedData<
                      ProductsTableData,
                      $ProductsTableTable,
                      OrderItemsTableData
                    >(
                      currentTable: table,
                      referencedTable: $$ProductsTableTableReferences
                          ._orderItemsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProductsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).orderItemsTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.productId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProductsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTableTable,
      ProductsTableData,
      $$ProductsTableTableFilterComposer,
      $$ProductsTableTableOrderingComposer,
      $$ProductsTableTableAnnotationComposer,
      $$ProductsTableTableCreateCompanionBuilder,
      $$ProductsTableTableUpdateCompanionBuilder,
      (ProductsTableData, $$ProductsTableTableReferences),
      ProductsTableData,
      PrefetchHooks Function({bool orderItemsTableRefs})
    >;
typedef $$CustomerOrdersTableTableCreateCompanionBuilder =
    CustomerOrdersTableCompanion Function({
      required String id,
      required String customerId,
      required String orderNumber,
      required String executionStatus,
      required String paymentStatus,
      required String currencyCode,
      Value<int> paidAmountMinor,
      Value<int> discountAmountMinor,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$CustomerOrdersTableTableUpdateCompanionBuilder =
    CustomerOrdersTableCompanion Function({
      Value<String> id,
      Value<String> customerId,
      Value<String> orderNumber,
      Value<String> executionStatus,
      Value<String> paymentStatus,
      Value<String> currencyCode,
      Value<int> paidAmountMinor,
      Value<int> discountAmountMinor,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$CustomerOrdersTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CustomerOrdersTableTable,
          CustomerOrdersTableData
        > {
  $$CustomerOrdersTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CustomersTableTable _customerIdTable(_$AppDatabase db) =>
      db.customersTable.createAlias(
        $_aliasNameGenerator(
          db.customerOrdersTable.customerId,
          db.customersTable.id,
        ),
      );

  $$CustomersTableTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<String>('customer_id')!;

    final manager = $$CustomersTableTableTableManager(
      $_db,
      $_db.customersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CurrenciesTableTable _currencyCodeTable(_$AppDatabase db) =>
      db.currenciesTable.createAlias(
        $_aliasNameGenerator(
          db.customerOrdersTable.currencyCode,
          db.currenciesTable.code,
        ),
      );

  $$CurrenciesTableTableProcessedTableManager get currencyCode {
    final $_column = $_itemColumn<String>('currency_code')!;

    final manager = $$CurrenciesTableTableTableManager(
      $_db,
      $_db.currenciesTable,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_currencyCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$OrderItemsTableTable, List<OrderItemsTableData>>
  _orderItemsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.orderItemsTable,
    aliasName: $_aliasNameGenerator(
      db.customerOrdersTable.id,
      db.orderItemsTable.orderId,
    ),
  );

  $$OrderItemsTableTableProcessedTableManager get orderItemsTableRefs {
    final manager = $$OrderItemsTableTableTableManager(
      $_db,
      $_db.orderItemsTable,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _orderItemsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PaymentAllocationsTableTable,
    List<PaymentAllocationsTableData>
  >
  _paymentAllocationsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.paymentAllocationsTable,
        aliasName: $_aliasNameGenerator(
          db.customerOrdersTable.id,
          db.paymentAllocationsTable.orderId,
        ),
      );

  $$PaymentAllocationsTableTableProcessedTableManager
  get paymentAllocationsTableRefs {
    final manager = $$PaymentAllocationsTableTableTableManager(
      $_db,
      $_db.paymentAllocationsTable,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _paymentAllocationsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTableTable, List<ExpensesTableData>>
  _expensesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expensesTable,
    aliasName: $_aliasNameGenerator(
      db.customerOrdersTable.id,
      db.expensesTable.orderId,
    ),
  );

  $$ExpensesTableTableProcessedTableManager get expensesTableRefs {
    final manager = $$ExpensesTableTableTableManager(
      $_db,
      $_db.expensesTable,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomerOrdersTableTableFilterComposer
    extends Composer<_$AppDatabase, $CustomerOrdersTableTable> {
  $$CustomerOrdersTableTableFilterComposer({
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

  ColumnFilters<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get executionStatus => $composableBuilder(
    column: $table.executionStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paidAmountMinor => $composableBuilder(
    column: $table.paidAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountAmountMinor => $composableBuilder(
    column: $table.discountAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableTableFilterComposer get customerId {
    final $$CustomersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableTableFilterComposer(
            $db: $db,
            $table: $db.customersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableFilterComposer get currencyCode {
    final $$CurrenciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableFilterComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> orderItemsTableRefs(
    Expression<bool> Function($$OrderItemsTableTableFilterComposer f) f,
  ) {
    final $$OrderItemsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItemsTable,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableTableFilterComposer(
            $db: $db,
            $table: $db.orderItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentAllocationsTableRefs(
    Expression<bool> Function($$PaymentAllocationsTableTableFilterComposer f) f,
  ) {
    final $$PaymentAllocationsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paymentAllocationsTable,
          getReferencedColumn: (t) => t.orderId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAllocationsTableTableFilterComposer(
                $db: $db,
                $table: $db.paymentAllocationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> expensesTableRefs(
    Expression<bool> Function($$ExpensesTableTableFilterComposer f) f,
  ) {
    final $$ExpensesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableFilterComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomerOrdersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomerOrdersTableTable> {
  $$CustomerOrdersTableTableOrderingComposer({
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

  ColumnOrderings<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get executionStatus => $composableBuilder(
    column: $table.executionStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paidAmountMinor => $composableBuilder(
    column: $table.paidAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountAmountMinor => $composableBuilder(
    column: $table.discountAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableTableOrderingComposer get customerId {
    final $$CustomersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableTableOrderingComposer(
            $db: $db,
            $table: $db.customersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableOrderingComposer get currencyCode {
    final $$CurrenciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomerOrdersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomerOrdersTableTable> {
  $$CustomerOrdersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get executionStatus => $composableBuilder(
    column: $table.executionStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paidAmountMinor => $composableBuilder(
    column: $table.paidAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discountAmountMinor => $composableBuilder(
    column: $table.discountAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CustomersTableTableAnnotationComposer get customerId {
    final $$CustomersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.customersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableAnnotationComposer get currencyCode {
    final $$CurrenciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> orderItemsTableRefs<T extends Object>(
    Expression<T> Function($$OrderItemsTableTableAnnotationComposer a) f,
  ) {
    final $$OrderItemsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItemsTable,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.orderItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentAllocationsTableRefs<T extends Object>(
    Expression<T> Function($$PaymentAllocationsTableTableAnnotationComposer a)
    f,
  ) {
    final $$PaymentAllocationsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paymentAllocationsTable,
          getReferencedColumn: (t) => t.orderId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAllocationsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.paymentAllocationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> expensesTableRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomerOrdersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomerOrdersTableTable,
          CustomerOrdersTableData,
          $$CustomerOrdersTableTableFilterComposer,
          $$CustomerOrdersTableTableOrderingComposer,
          $$CustomerOrdersTableTableAnnotationComposer,
          $$CustomerOrdersTableTableCreateCompanionBuilder,
          $$CustomerOrdersTableTableUpdateCompanionBuilder,
          (CustomerOrdersTableData, $$CustomerOrdersTableTableReferences),
          CustomerOrdersTableData,
          PrefetchHooks Function({
            bool customerId,
            bool currencyCode,
            bool orderItemsTableRefs,
            bool paymentAllocationsTableRefs,
            bool expensesTableRefs,
          })
        > {
  $$CustomerOrdersTableTableTableManager(
    _$AppDatabase db,
    $CustomerOrdersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomerOrdersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomerOrdersTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CustomerOrdersTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<String> orderNumber = const Value.absent(),
                Value<String> executionStatus = const Value.absent(),
                Value<String> paymentStatus = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> paidAmountMinor = const Value.absent(),
                Value<int> discountAmountMinor = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomerOrdersTableCompanion(
                id: id,
                customerId: customerId,
                orderNumber: orderNumber,
                executionStatus: executionStatus,
                paymentStatus: paymentStatus,
                currencyCode: currencyCode,
                paidAmountMinor: paidAmountMinor,
                discountAmountMinor: discountAmountMinor,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String customerId,
                required String orderNumber,
                required String executionStatus,
                required String paymentStatus,
                required String currencyCode,
                Value<int> paidAmountMinor = const Value.absent(),
                Value<int> discountAmountMinor = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomerOrdersTableCompanion.insert(
                id: id,
                customerId: customerId,
                orderNumber: orderNumber,
                executionStatus: executionStatus,
                paymentStatus: paymentStatus,
                currencyCode: currencyCode,
                paidAmountMinor: paidAmountMinor,
                discountAmountMinor: discountAmountMinor,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomerOrdersTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                customerId = false,
                currencyCode = false,
                orderItemsTableRefs = false,
                paymentAllocationsTableRefs = false,
                expensesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (orderItemsTableRefs) db.orderItemsTable,
                    if (paymentAllocationsTableRefs) db.paymentAllocationsTable,
                    if (expensesTableRefs) db.expensesTable,
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
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable:
                                        $$CustomerOrdersTableTableReferences
                                            ._customerIdTable(db),
                                    referencedColumn:
                                        $$CustomerOrdersTableTableReferences
                                            ._customerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (currencyCode) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.currencyCode,
                                    referencedTable:
                                        $$CustomerOrdersTableTableReferences
                                            ._currencyCodeTable(db),
                                    referencedColumn:
                                        $$CustomerOrdersTableTableReferences
                                            ._currencyCodeTable(db)
                                            .code,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (orderItemsTableRefs)
                        await $_getPrefetchedData<
                          CustomerOrdersTableData,
                          $CustomerOrdersTableTable,
                          OrderItemsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CustomerOrdersTableTableReferences
                              ._orderItemsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomerOrdersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).orderItemsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.orderId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentAllocationsTableRefs)
                        await $_getPrefetchedData<
                          CustomerOrdersTableData,
                          $CustomerOrdersTableTable,
                          PaymentAllocationsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CustomerOrdersTableTableReferences
                              ._paymentAllocationsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomerOrdersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentAllocationsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.orderId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expensesTableRefs)
                        await $_getPrefetchedData<
                          CustomerOrdersTableData,
                          $CustomerOrdersTableTable,
                          ExpensesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CustomerOrdersTableTableReferences
                              ._expensesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomerOrdersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.orderId == item.id,
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

typedef $$CustomerOrdersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomerOrdersTableTable,
      CustomerOrdersTableData,
      $$CustomerOrdersTableTableFilterComposer,
      $$CustomerOrdersTableTableOrderingComposer,
      $$CustomerOrdersTableTableAnnotationComposer,
      $$CustomerOrdersTableTableCreateCompanionBuilder,
      $$CustomerOrdersTableTableUpdateCompanionBuilder,
      (CustomerOrdersTableData, $$CustomerOrdersTableTableReferences),
      CustomerOrdersTableData,
      PrefetchHooks Function({
        bool customerId,
        bool currencyCode,
        bool orderItemsTableRefs,
        bool paymentAllocationsTableRefs,
        bool expensesTableRefs,
      })
    >;
typedef $$OrderItemsTableTableCreateCompanionBuilder =
    OrderItemsTableCompanion Function({
      required String id,
      required String orderId,
      Value<String?> productId,
      required String title,
      Value<String?> color,
      Value<String?> size,
      Value<int> quantity,
      required int saleUnitPriceMinor,
      Value<int?> unitCostMinor,
      Value<int?> allocatedExtraCostMinor,
      Value<int> rowid,
    });
typedef $$OrderItemsTableTableUpdateCompanionBuilder =
    OrderItemsTableCompanion Function({
      Value<String> id,
      Value<String> orderId,
      Value<String?> productId,
      Value<String> title,
      Value<String?> color,
      Value<String?> size,
      Value<int> quantity,
      Value<int> saleUnitPriceMinor,
      Value<int?> unitCostMinor,
      Value<int?> allocatedExtraCostMinor,
      Value<int> rowid,
    });

final class $$OrderItemsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $OrderItemsTableTable,
          OrderItemsTableData
        > {
  $$OrderItemsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CustomerOrdersTableTable _orderIdTable(_$AppDatabase db) =>
      db.customerOrdersTable.createAlias(
        $_aliasNameGenerator(
          db.orderItemsTable.orderId,
          db.customerOrdersTable.id,
        ),
      );

  $$CustomerOrdersTableTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<String>('order_id')!;

    final manager = $$CustomerOrdersTableTableTableManager(
      $_db,
      $_db.customerOrdersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTableTable _productIdTable(_$AppDatabase db) =>
      db.productsTable.createAlias(
        $_aliasNameGenerator(db.orderItemsTable.productId, db.productsTable.id),
      );

  $$ProductsTableTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<String>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductsTableTableTableManager(
      $_db,
      $_db.productsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $PurchaseBatchItemsTableTable,
    List<PurchaseBatchItemsTableData>
  >
  _purchaseBatchItemsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.purchaseBatchItemsTable,
        aliasName: $_aliasNameGenerator(
          db.orderItemsTable.id,
          db.purchaseBatchItemsTable.orderItemId,
        ),
      );

  $$PurchaseBatchItemsTableTableProcessedTableManager
  get purchaseBatchItemsTableRefs {
    final manager = $$PurchaseBatchItemsTableTableTableManager(
      $_db,
      $_db.purchaseBatchItemsTable,
    ).filter((f) => f.orderItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseBatchItemsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OrderItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $OrderItemsTableTable> {
  $$OrderItemsTableTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saleUnitPriceMinor => $composableBuilder(
    column: $table.saleUnitPriceMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitCostMinor => $composableBuilder(
    column: $table.unitCostMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get allocatedExtraCostMinor => $composableBuilder(
    column: $table.allocatedExtraCostMinor,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomerOrdersTableTableFilterComposer get orderId {
    final $$CustomerOrdersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.customerOrdersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerOrdersTableTableFilterComposer(
            $db: $db,
            $table: $db.customerOrdersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableTableFilterComposer get productId {
    final $$ProductsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableTableFilterComposer(
            $db: $db,
            $table: $db.productsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchaseBatchItemsTableRefs(
    Expression<bool> Function($$PurchaseBatchItemsTableTableFilterComposer f) f,
  ) {
    final $$PurchaseBatchItemsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.purchaseBatchItemsTable,
          getReferencedColumn: (t) => t.orderItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseBatchItemsTableTableFilterComposer(
                $db: $db,
                $table: $db.purchaseBatchItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$OrderItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderItemsTableTable> {
  $$OrderItemsTableTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saleUnitPriceMinor => $composableBuilder(
    column: $table.saleUnitPriceMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitCostMinor => $composableBuilder(
    column: $table.unitCostMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get allocatedExtraCostMinor => $composableBuilder(
    column: $table.allocatedExtraCostMinor,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomerOrdersTableTableOrderingComposer get orderId {
    final $$CustomerOrdersTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.orderId,
          referencedTable: $db.customerOrdersTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CustomerOrdersTableTableOrderingComposer(
                $db: $db,
                $table: $db.customerOrdersTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ProductsTableTableOrderingComposer get productId {
    final $$ProductsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableTableOrderingComposer(
            $db: $db,
            $table: $db.productsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderItemsTableTable> {
  $$OrderItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get saleUnitPriceMinor => $composableBuilder(
    column: $table.saleUnitPriceMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unitCostMinor => $composableBuilder(
    column: $table.unitCostMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get allocatedExtraCostMinor => $composableBuilder(
    column: $table.allocatedExtraCostMinor,
    builder: (column) => column,
  );

  $$CustomerOrdersTableTableAnnotationComposer get orderId {
    final $$CustomerOrdersTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.orderId,
          referencedTable: $db.customerOrdersTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CustomerOrdersTableTableAnnotationComposer(
                $db: $db,
                $table: $db.customerOrdersTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ProductsTableTableAnnotationComposer get productId {
    final $$ProductsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.productsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.productsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchaseBatchItemsTableRefs<T extends Object>(
    Expression<T> Function($$PurchaseBatchItemsTableTableAnnotationComposer a)
    f,
  ) {
    final $$PurchaseBatchItemsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.purchaseBatchItemsTable,
          getReferencedColumn: (t) => t.orderItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseBatchItemsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseBatchItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$OrderItemsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrderItemsTableTable,
          OrderItemsTableData,
          $$OrderItemsTableTableFilterComposer,
          $$OrderItemsTableTableOrderingComposer,
          $$OrderItemsTableTableAnnotationComposer,
          $$OrderItemsTableTableCreateCompanionBuilder,
          $$OrderItemsTableTableUpdateCompanionBuilder,
          (OrderItemsTableData, $$OrderItemsTableTableReferences),
          OrderItemsTableData,
          PrefetchHooks Function({
            bool orderId,
            bool productId,
            bool purchaseBatchItemsTableRefs,
          })
        > {
  $$OrderItemsTableTableTableManager(
    _$AppDatabase db,
    $OrderItemsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderItemsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderItemsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<String?> productId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> size = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> saleUnitPriceMinor = const Value.absent(),
                Value<int?> unitCostMinor = const Value.absent(),
                Value<int?> allocatedExtraCostMinor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrderItemsTableCompanion(
                id: id,
                orderId: orderId,
                productId: productId,
                title: title,
                color: color,
                size: size,
                quantity: quantity,
                saleUnitPriceMinor: saleUnitPriceMinor,
                unitCostMinor: unitCostMinor,
                allocatedExtraCostMinor: allocatedExtraCostMinor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String orderId,
                Value<String?> productId = const Value.absent(),
                required String title,
                Value<String?> color = const Value.absent(),
                Value<String?> size = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                required int saleUnitPriceMinor,
                Value<int?> unitCostMinor = const Value.absent(),
                Value<int?> allocatedExtraCostMinor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrderItemsTableCompanion.insert(
                id: id,
                orderId: orderId,
                productId: productId,
                title: title,
                color: color,
                size: size,
                quantity: quantity,
                saleUnitPriceMinor: saleUnitPriceMinor,
                unitCostMinor: unitCostMinor,
                allocatedExtraCostMinor: allocatedExtraCostMinor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OrderItemsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                orderId = false,
                productId = false,
                purchaseBatchItemsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchaseBatchItemsTableRefs) db.purchaseBatchItemsTable,
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
                        if (orderId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.orderId,
                                    referencedTable:
                                        $$OrderItemsTableTableReferences
                                            ._orderIdTable(db),
                                    referencedColumn:
                                        $$OrderItemsTableTableReferences
                                            ._orderIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (productId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productId,
                                    referencedTable:
                                        $$OrderItemsTableTableReferences
                                            ._productIdTable(db),
                                    referencedColumn:
                                        $$OrderItemsTableTableReferences
                                            ._productIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchaseBatchItemsTableRefs)
                        await $_getPrefetchedData<
                          OrderItemsTableData,
                          $OrderItemsTableTable,
                          PurchaseBatchItemsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$OrderItemsTableTableReferences
                              ._purchaseBatchItemsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrderItemsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseBatchItemsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.orderItemId == item.id,
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

typedef $$OrderItemsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrderItemsTableTable,
      OrderItemsTableData,
      $$OrderItemsTableTableFilterComposer,
      $$OrderItemsTableTableOrderingComposer,
      $$OrderItemsTableTableAnnotationComposer,
      $$OrderItemsTableTableCreateCompanionBuilder,
      $$OrderItemsTableTableUpdateCompanionBuilder,
      (OrderItemsTableData, $$OrderItemsTableTableReferences),
      OrderItemsTableData,
      PrefetchHooks Function({
        bool orderId,
        bool productId,
        bool purchaseBatchItemsTableRefs,
      })
    >;
typedef $$PurchaseBatchesTableTableCreateCompanionBuilder =
    PurchaseBatchesTableCompanion Function({
      required String id,
      required String storeName,
      Value<String?> invoiceReference,
      required String currencyCode,
      Value<int> extraCostsMinor,
      Value<int> discountsMinor,
      required String status,
      required DateTime purchasedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PurchaseBatchesTableTableUpdateCompanionBuilder =
    PurchaseBatchesTableCompanion Function({
      Value<String> id,
      Value<String> storeName,
      Value<String?> invoiceReference,
      Value<String> currencyCode,
      Value<int> extraCostsMinor,
      Value<int> discountsMinor,
      Value<String> status,
      Value<DateTime> purchasedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PurchaseBatchesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PurchaseBatchesTableTable,
          PurchaseBatchesTableData
        > {
  $$PurchaseBatchesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CurrenciesTableTable _currencyCodeTable(_$AppDatabase db) =>
      db.currenciesTable.createAlias(
        $_aliasNameGenerator(
          db.purchaseBatchesTable.currencyCode,
          db.currenciesTable.code,
        ),
      );

  $$CurrenciesTableTableProcessedTableManager get currencyCode {
    final $_column = $_itemColumn<String>('currency_code')!;

    final manager = $$CurrenciesTableTableTableManager(
      $_db,
      $_db.currenciesTable,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_currencyCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $PurchaseBatchItemsTableTable,
    List<PurchaseBatchItemsTableData>
  >
  _purchaseBatchItemsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.purchaseBatchItemsTable,
        aliasName: $_aliasNameGenerator(
          db.purchaseBatchesTable.id,
          db.purchaseBatchItemsTable.batchId,
        ),
      );

  $$PurchaseBatchItemsTableTableProcessedTableManager
  get purchaseBatchItemsTableRefs {
    final manager = $$PurchaseBatchItemsTableTableTableManager(
      $_db,
      $_db.purchaseBatchItemsTable,
    ).filter((f) => f.batchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchaseBatchItemsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTableTable, List<ExpensesTableData>>
  _expensesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expensesTable,
    aliasName: $_aliasNameGenerator(
      db.purchaseBatchesTable.id,
      db.expensesTable.purchaseBatchId,
    ),
  );

  $$ExpensesTableTableProcessedTableManager get expensesTableRefs {
    final manager = $$ExpensesTableTableTableManager($_db, $_db.expensesTable)
        .filter(
          (f) => f.purchaseBatchId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_expensesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PurchaseBatchesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseBatchesTableTable> {
  $$PurchaseBatchesTableTableFilterComposer({
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

  ColumnFilters<String> get storeName => $composableBuilder(
    column: $table.storeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceReference => $composableBuilder(
    column: $table.invoiceReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get extraCostsMinor => $composableBuilder(
    column: $table.extraCostsMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountsMinor => $composableBuilder(
    column: $table.discountsMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CurrenciesTableTableFilterComposer get currencyCode {
    final $$CurrenciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableFilterComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchaseBatchItemsTableRefs(
    Expression<bool> Function($$PurchaseBatchItemsTableTableFilterComposer f) f,
  ) {
    final $$PurchaseBatchItemsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.purchaseBatchItemsTable,
          getReferencedColumn: (t) => t.batchId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseBatchItemsTableTableFilterComposer(
                $db: $db,
                $table: $db.purchaseBatchItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> expensesTableRefs(
    Expression<bool> Function($$ExpensesTableTableFilterComposer f) f,
  ) {
    final $$ExpensesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.purchaseBatchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableFilterComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchaseBatchesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseBatchesTableTable> {
  $$PurchaseBatchesTableTableOrderingComposer({
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

  ColumnOrderings<String> get storeName => $composableBuilder(
    column: $table.storeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceReference => $composableBuilder(
    column: $table.invoiceReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get extraCostsMinor => $composableBuilder(
    column: $table.extraCostsMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountsMinor => $composableBuilder(
    column: $table.discountsMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CurrenciesTableTableOrderingComposer get currencyCode {
    final $$CurrenciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseBatchesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseBatchesTableTable> {
  $$PurchaseBatchesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storeName =>
      $composableBuilder(column: $table.storeName, builder: (column) => column);

  GeneratedColumn<String> get invoiceReference => $composableBuilder(
    column: $table.invoiceReference,
    builder: (column) => column,
  );

  GeneratedColumn<int> get extraCostsMinor => $composableBuilder(
    column: $table.extraCostsMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discountsMinor => $composableBuilder(
    column: $table.discountsMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CurrenciesTableTableAnnotationComposer get currencyCode {
    final $$CurrenciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchaseBatchItemsTableRefs<T extends Object>(
    Expression<T> Function($$PurchaseBatchItemsTableTableAnnotationComposer a)
    f,
  ) {
    final $$PurchaseBatchItemsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.purchaseBatchItemsTable,
          getReferencedColumn: (t) => t.batchId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseBatchItemsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseBatchItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> expensesTableRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.purchaseBatchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchaseBatchesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseBatchesTableTable,
          PurchaseBatchesTableData,
          $$PurchaseBatchesTableTableFilterComposer,
          $$PurchaseBatchesTableTableOrderingComposer,
          $$PurchaseBatchesTableTableAnnotationComposer,
          $$PurchaseBatchesTableTableCreateCompanionBuilder,
          $$PurchaseBatchesTableTableUpdateCompanionBuilder,
          (PurchaseBatchesTableData, $$PurchaseBatchesTableTableReferences),
          PurchaseBatchesTableData,
          PrefetchHooks Function({
            bool currencyCode,
            bool purchaseBatchItemsTableRefs,
            bool expensesTableRefs,
          })
        > {
  $$PurchaseBatchesTableTableTableManager(
    _$AppDatabase db,
    $PurchaseBatchesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseBatchesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseBatchesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PurchaseBatchesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> storeName = const Value.absent(),
                Value<String?> invoiceReference = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> extraCostsMinor = const Value.absent(),
                Value<int> discountsMinor = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> purchasedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseBatchesTableCompanion(
                id: id,
                storeName: storeName,
                invoiceReference: invoiceReference,
                currencyCode: currencyCode,
                extraCostsMinor: extraCostsMinor,
                discountsMinor: discountsMinor,
                status: status,
                purchasedAt: purchasedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String storeName,
                Value<String?> invoiceReference = const Value.absent(),
                required String currencyCode,
                Value<int> extraCostsMinor = const Value.absent(),
                Value<int> discountsMinor = const Value.absent(),
                required String status,
                required DateTime purchasedAt,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseBatchesTableCompanion.insert(
                id: id,
                storeName: storeName,
                invoiceReference: invoiceReference,
                currencyCode: currencyCode,
                extraCostsMinor: extraCostsMinor,
                discountsMinor: discountsMinor,
                status: status,
                purchasedAt: purchasedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseBatchesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                currencyCode = false,
                purchaseBatchItemsTableRefs = false,
                expensesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchaseBatchItemsTableRefs) db.purchaseBatchItemsTable,
                    if (expensesTableRefs) db.expensesTable,
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
                        if (currencyCode) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.currencyCode,
                                    referencedTable:
                                        $$PurchaseBatchesTableTableReferences
                                            ._currencyCodeTable(db),
                                    referencedColumn:
                                        $$PurchaseBatchesTableTableReferences
                                            ._currencyCodeTable(db)
                                            .code,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchaseBatchItemsTableRefs)
                        await $_getPrefetchedData<
                          PurchaseBatchesTableData,
                          $PurchaseBatchesTableTable,
                          PurchaseBatchItemsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$PurchaseBatchesTableTableReferences
                              ._purchaseBatchItemsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PurchaseBatchesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseBatchItemsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.batchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expensesTableRefs)
                        await $_getPrefetchedData<
                          PurchaseBatchesTableData,
                          $PurchaseBatchesTableTable,
                          ExpensesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$PurchaseBatchesTableTableReferences
                              ._expensesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PurchaseBatchesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.purchaseBatchId == item.id,
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

typedef $$PurchaseBatchesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseBatchesTableTable,
      PurchaseBatchesTableData,
      $$PurchaseBatchesTableTableFilterComposer,
      $$PurchaseBatchesTableTableOrderingComposer,
      $$PurchaseBatchesTableTableAnnotationComposer,
      $$PurchaseBatchesTableTableCreateCompanionBuilder,
      $$PurchaseBatchesTableTableUpdateCompanionBuilder,
      (PurchaseBatchesTableData, $$PurchaseBatchesTableTableReferences),
      PurchaseBatchesTableData,
      PrefetchHooks Function({
        bool currencyCode,
        bool purchaseBatchItemsTableRefs,
        bool expensesTableRefs,
      })
    >;
typedef $$PurchaseBatchItemsTableTableCreateCompanionBuilder =
    PurchaseBatchItemsTableCompanion Function({
      required String id,
      required String batchId,
      required String orderItemId,
      required int quantity,
      required int unitCostMinor,
      Value<int> allocatedExtraCostMinor,
      Value<String?> manualOverrideReason,
      Value<int> rowid,
    });
typedef $$PurchaseBatchItemsTableTableUpdateCompanionBuilder =
    PurchaseBatchItemsTableCompanion Function({
      Value<String> id,
      Value<String> batchId,
      Value<String> orderItemId,
      Value<int> quantity,
      Value<int> unitCostMinor,
      Value<int> allocatedExtraCostMinor,
      Value<String?> manualOverrideReason,
      Value<int> rowid,
    });

final class $$PurchaseBatchItemsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PurchaseBatchItemsTableTable,
          PurchaseBatchItemsTableData
        > {
  $$PurchaseBatchItemsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PurchaseBatchesTableTable _batchIdTable(_$AppDatabase db) =>
      db.purchaseBatchesTable.createAlias(
        $_aliasNameGenerator(
          db.purchaseBatchItemsTable.batchId,
          db.purchaseBatchesTable.id,
        ),
      );

  $$PurchaseBatchesTableTableProcessedTableManager get batchId {
    final $_column = $_itemColumn<String>('batch_id')!;

    final manager = $$PurchaseBatchesTableTableTableManager(
      $_db,
      $_db.purchaseBatchesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $OrderItemsTableTable _orderItemIdTable(_$AppDatabase db) =>
      db.orderItemsTable.createAlias(
        $_aliasNameGenerator(
          db.purchaseBatchItemsTable.orderItemId,
          db.orderItemsTable.id,
        ),
      );

  $$OrderItemsTableTableProcessedTableManager get orderItemId {
    final $_column = $_itemColumn<String>('order_item_id')!;

    final manager = $$OrderItemsTableTableTableManager(
      $_db,
      $_db.orderItemsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PurchaseBatchItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseBatchItemsTableTable> {
  $$PurchaseBatchItemsTableTableFilterComposer({
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

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitCostMinor => $composableBuilder(
    column: $table.unitCostMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get allocatedExtraCostMinor => $composableBuilder(
    column: $table.allocatedExtraCostMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get manualOverrideReason => $composableBuilder(
    column: $table.manualOverrideReason,
    builder: (column) => ColumnFilters(column),
  );

  $$PurchaseBatchesTableTableFilterComposer get batchId {
    final $$PurchaseBatchesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.purchaseBatchesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseBatchesTableTableFilterComposer(
            $db: $db,
            $table: $db.purchaseBatchesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$OrderItemsTableTableFilterComposer get orderItemId {
    final $$OrderItemsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderItemId,
      referencedTable: $db.orderItemsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableTableFilterComposer(
            $db: $db,
            $table: $db.orderItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseBatchItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseBatchItemsTableTable> {
  $$PurchaseBatchItemsTableTableOrderingComposer({
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

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitCostMinor => $composableBuilder(
    column: $table.unitCostMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get allocatedExtraCostMinor => $composableBuilder(
    column: $table.allocatedExtraCostMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manualOverrideReason => $composableBuilder(
    column: $table.manualOverrideReason,
    builder: (column) => ColumnOrderings(column),
  );

  $$PurchaseBatchesTableTableOrderingComposer get batchId {
    final $$PurchaseBatchesTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.batchId,
          referencedTable: $db.purchaseBatchesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseBatchesTableTableOrderingComposer(
                $db: $db,
                $table: $db.purchaseBatchesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$OrderItemsTableTableOrderingComposer get orderItemId {
    final $$OrderItemsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderItemId,
      referencedTable: $db.orderItemsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableTableOrderingComposer(
            $db: $db,
            $table: $db.orderItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseBatchItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseBatchItemsTableTable> {
  $$PurchaseBatchItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get unitCostMinor => $composableBuilder(
    column: $table.unitCostMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get allocatedExtraCostMinor => $composableBuilder(
    column: $table.allocatedExtraCostMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get manualOverrideReason => $composableBuilder(
    column: $table.manualOverrideReason,
    builder: (column) => column,
  );

  $$PurchaseBatchesTableTableAnnotationComposer get batchId {
    final $$PurchaseBatchesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.batchId,
          referencedTable: $db.purchaseBatchesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseBatchesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseBatchesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$OrderItemsTableTableAnnotationComposer get orderItemId {
    final $$OrderItemsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderItemId,
      referencedTable: $db.orderItemsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.orderItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseBatchItemsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseBatchItemsTableTable,
          PurchaseBatchItemsTableData,
          $$PurchaseBatchItemsTableTableFilterComposer,
          $$PurchaseBatchItemsTableTableOrderingComposer,
          $$PurchaseBatchItemsTableTableAnnotationComposer,
          $$PurchaseBatchItemsTableTableCreateCompanionBuilder,
          $$PurchaseBatchItemsTableTableUpdateCompanionBuilder,
          (
            PurchaseBatchItemsTableData,
            $$PurchaseBatchItemsTableTableReferences,
          ),
          PurchaseBatchItemsTableData,
          PrefetchHooks Function({bool batchId, bool orderItemId})
        > {
  $$PurchaseBatchItemsTableTableTableManager(
    _$AppDatabase db,
    $PurchaseBatchItemsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseBatchItemsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PurchaseBatchItemsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PurchaseBatchItemsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> batchId = const Value.absent(),
                Value<String> orderItemId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> unitCostMinor = const Value.absent(),
                Value<int> allocatedExtraCostMinor = const Value.absent(),
                Value<String?> manualOverrideReason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseBatchItemsTableCompanion(
                id: id,
                batchId: batchId,
                orderItemId: orderItemId,
                quantity: quantity,
                unitCostMinor: unitCostMinor,
                allocatedExtraCostMinor: allocatedExtraCostMinor,
                manualOverrideReason: manualOverrideReason,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String batchId,
                required String orderItemId,
                required int quantity,
                required int unitCostMinor,
                Value<int> allocatedExtraCostMinor = const Value.absent(),
                Value<String?> manualOverrideReason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseBatchItemsTableCompanion.insert(
                id: id,
                batchId: batchId,
                orderItemId: orderItemId,
                quantity: quantity,
                unitCostMinor: unitCostMinor,
                allocatedExtraCostMinor: allocatedExtraCostMinor,
                manualOverrideReason: manualOverrideReason,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseBatchItemsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({batchId = false, orderItemId = false}) {
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
                    if (batchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.batchId,
                                referencedTable:
                                    $$PurchaseBatchItemsTableTableReferences
                                        ._batchIdTable(db),
                                referencedColumn:
                                    $$PurchaseBatchItemsTableTableReferences
                                        ._batchIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (orderItemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.orderItemId,
                                referencedTable:
                                    $$PurchaseBatchItemsTableTableReferences
                                        ._orderItemIdTable(db),
                                referencedColumn:
                                    $$PurchaseBatchItemsTableTableReferences
                                        ._orderItemIdTable(db)
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

typedef $$PurchaseBatchItemsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseBatchItemsTableTable,
      PurchaseBatchItemsTableData,
      $$PurchaseBatchItemsTableTableFilterComposer,
      $$PurchaseBatchItemsTableTableOrderingComposer,
      $$PurchaseBatchItemsTableTableAnnotationComposer,
      $$PurchaseBatchItemsTableTableCreateCompanionBuilder,
      $$PurchaseBatchItemsTableTableUpdateCompanionBuilder,
      (PurchaseBatchItemsTableData, $$PurchaseBatchItemsTableTableReferences),
      PurchaseBatchItemsTableData,
      PrefetchHooks Function({bool batchId, bool orderItemId})
    >;
typedef $$FinancialTransactionsTableTableCreateCompanionBuilder =
    FinancialTransactionsTableCompanion Function({
      required String id,
      required String type,
      required String walletId,
      required int amountMinor,
      required String currencyCode,
      required DateTime occurredAt,
      Value<String?> referenceId,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$FinancialTransactionsTableTableUpdateCompanionBuilder =
    FinancialTransactionsTableCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<String> walletId,
      Value<int> amountMinor,
      Value<String> currencyCode,
      Value<DateTime> occurredAt,
      Value<String?> referenceId,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$FinancialTransactionsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FinancialTransactionsTableTable,
          FinancialTransactionsTableData
        > {
  $$FinancialTransactionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WalletsTableTable _walletIdTable(_$AppDatabase db) =>
      db.walletsTable.createAlias(
        $_aliasNameGenerator(
          db.financialTransactionsTable.walletId,
          db.walletsTable.id,
        ),
      );

  $$WalletsTableTableProcessedTableManager get walletId {
    final $_column = $_itemColumn<String>('wallet_id')!;

    final manager = $$WalletsTableTableTableManager(
      $_db,
      $_db.walletsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_walletIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CurrenciesTableTable _currencyCodeTable(_$AppDatabase db) =>
      db.currenciesTable.createAlias(
        $_aliasNameGenerator(
          db.financialTransactionsTable.currencyCode,
          db.currenciesTable.code,
        ),
      );

  $$CurrenciesTableTableProcessedTableManager get currencyCode {
    final $_column = $_itemColumn<String>('currency_code')!;

    final manager = $$CurrenciesTableTableTableManager(
      $_db,
      $_db.currenciesTable,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_currencyCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FinancialTransactionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialTransactionsTableTable> {
  $$FinancialTransactionsTableTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WalletsTableTableFilterComposer get walletId {
    final $$WalletsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletsTableTableFilterComposer(
            $db: $db,
            $table: $db.walletsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableFilterComposer get currencyCode {
    final $$CurrenciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableFilterComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancialTransactionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialTransactionsTableTable> {
  $$FinancialTransactionsTableTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WalletsTableTableOrderingComposer get walletId {
    final $$WalletsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletsTableTableOrderingComposer(
            $db: $db,
            $table: $db.walletsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableOrderingComposer get currencyCode {
    final $$CurrenciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancialTransactionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialTransactionsTableTable> {
  $$FinancialTransactionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$WalletsTableTableAnnotationComposer get walletId {
    final $$WalletsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.walletsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableAnnotationComposer get currencyCode {
    final $$CurrenciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancialTransactionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinancialTransactionsTableTable,
          FinancialTransactionsTableData,
          $$FinancialTransactionsTableTableFilterComposer,
          $$FinancialTransactionsTableTableOrderingComposer,
          $$FinancialTransactionsTableTableAnnotationComposer,
          $$FinancialTransactionsTableTableCreateCompanionBuilder,
          $$FinancialTransactionsTableTableUpdateCompanionBuilder,
          (
            FinancialTransactionsTableData,
            $$FinancialTransactionsTableTableReferences,
          ),
          FinancialTransactionsTableData,
          PrefetchHooks Function({bool walletId, bool currencyCode})
        > {
  $$FinancialTransactionsTableTableTableManager(
    _$AppDatabase db,
    $FinancialTransactionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialTransactionsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$FinancialTransactionsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FinancialTransactionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> walletId = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinancialTransactionsTableCompanion(
                id: id,
                type: type,
                walletId: walletId,
                amountMinor: amountMinor,
                currencyCode: currencyCode,
                occurredAt: occurredAt,
                referenceId: referenceId,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required String walletId,
                required int amountMinor,
                required String currencyCode,
                required DateTime occurredAt,
                Value<String?> referenceId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinancialTransactionsTableCompanion.insert(
                id: id,
                type: type,
                walletId: walletId,
                amountMinor: amountMinor,
                currencyCode: currencyCode,
                occurredAt: occurredAt,
                referenceId: referenceId,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FinancialTransactionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({walletId = false, currencyCode = false}) {
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
                    if (walletId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.walletId,
                                referencedTable:
                                    $$FinancialTransactionsTableTableReferences
                                        ._walletIdTable(db),
                                referencedColumn:
                                    $$FinancialTransactionsTableTableReferences
                                        ._walletIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (currencyCode) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.currencyCode,
                                referencedTable:
                                    $$FinancialTransactionsTableTableReferences
                                        ._currencyCodeTable(db),
                                referencedColumn:
                                    $$FinancialTransactionsTableTableReferences
                                        ._currencyCodeTable(db)
                                        .code,
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

typedef $$FinancialTransactionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinancialTransactionsTableTable,
      FinancialTransactionsTableData,
      $$FinancialTransactionsTableTableFilterComposer,
      $$FinancialTransactionsTableTableOrderingComposer,
      $$FinancialTransactionsTableTableAnnotationComposer,
      $$FinancialTransactionsTableTableCreateCompanionBuilder,
      $$FinancialTransactionsTableTableUpdateCompanionBuilder,
      (
        FinancialTransactionsTableData,
        $$FinancialTransactionsTableTableReferences,
      ),
      FinancialTransactionsTableData,
      PrefetchHooks Function({bool walletId, bool currencyCode})
    >;
typedef $$PaymentsTableTableCreateCompanionBuilder =
    PaymentsTableCompanion Function({
      required String id,
      required String customerId,
      required String direction,
      required int amountMinor,
      required String currencyCode,
      required String walletId,
      required DateTime occurredAt,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$PaymentsTableTableUpdateCompanionBuilder =
    PaymentsTableCompanion Function({
      Value<String> id,
      Value<String> customerId,
      Value<String> direction,
      Value<int> amountMinor,
      Value<String> currencyCode,
      Value<String> walletId,
      Value<DateTime> occurredAt,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$PaymentsTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $PaymentsTableTable, PaymentsTableData> {
  $$PaymentsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CustomersTableTable _customerIdTable(_$AppDatabase db) =>
      db.customersTable.createAlias(
        $_aliasNameGenerator(db.paymentsTable.customerId, db.customersTable.id),
      );

  $$CustomersTableTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<String>('customer_id')!;

    final manager = $$CustomersTableTableTableManager(
      $_db,
      $_db.customersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CurrenciesTableTable _currencyCodeTable(_$AppDatabase db) =>
      db.currenciesTable.createAlias(
        $_aliasNameGenerator(
          db.paymentsTable.currencyCode,
          db.currenciesTable.code,
        ),
      );

  $$CurrenciesTableTableProcessedTableManager get currencyCode {
    final $_column = $_itemColumn<String>('currency_code')!;

    final manager = $$CurrenciesTableTableTableManager(
      $_db,
      $_db.currenciesTable,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_currencyCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WalletsTableTable _walletIdTable(_$AppDatabase db) =>
      db.walletsTable.createAlias(
        $_aliasNameGenerator(db.paymentsTable.walletId, db.walletsTable.id),
      );

  $$WalletsTableTableProcessedTableManager get walletId {
    final $_column = $_itemColumn<String>('wallet_id')!;

    final manager = $$WalletsTableTableTableManager(
      $_db,
      $_db.walletsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_walletIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $PaymentAllocationsTableTable,
    List<PaymentAllocationsTableData>
  >
  _paymentAllocationsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.paymentAllocationsTable,
        aliasName: $_aliasNameGenerator(
          db.paymentsTable.id,
          db.paymentAllocationsTable.paymentId,
        ),
      );

  $$PaymentAllocationsTableTableProcessedTableManager
  get paymentAllocationsTableRefs {
    final manager = $$PaymentAllocationsTableTableTableManager(
      $_db,
      $_db.paymentAllocationsTable,
    ).filter((f) => f.paymentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _paymentAllocationsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PaymentsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTableTable> {
  $$PaymentsTableTableFilterComposer({
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

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableTableFilterComposer get customerId {
    final $$CustomersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableTableFilterComposer(
            $db: $db,
            $table: $db.customersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableFilterComposer get currencyCode {
    final $$CurrenciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableFilterComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WalletsTableTableFilterComposer get walletId {
    final $$WalletsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletsTableTableFilterComposer(
            $db: $db,
            $table: $db.walletsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> paymentAllocationsTableRefs(
    Expression<bool> Function($$PaymentAllocationsTableTableFilterComposer f) f,
  ) {
    final $$PaymentAllocationsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paymentAllocationsTable,
          getReferencedColumn: (t) => t.paymentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAllocationsTableTableFilterComposer(
                $db: $db,
                $table: $db.paymentAllocationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PaymentsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTableTable> {
  $$PaymentsTableTableOrderingComposer({
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

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableTableOrderingComposer get customerId {
    final $$CustomersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableTableOrderingComposer(
            $db: $db,
            $table: $db.customersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableOrderingComposer get currencyCode {
    final $$CurrenciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WalletsTableTableOrderingComposer get walletId {
    final $$WalletsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletsTableTableOrderingComposer(
            $db: $db,
            $table: $db.walletsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTableTable> {
  $$PaymentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$CustomersTableTableAnnotationComposer get customerId {
    final $$CustomersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.customersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableAnnotationComposer get currencyCode {
    final $$CurrenciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WalletsTableTableAnnotationComposer get walletId {
    final $$WalletsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.walletsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> paymentAllocationsTableRefs<T extends Object>(
    Expression<T> Function($$PaymentAllocationsTableTableAnnotationComposer a)
    f,
  ) {
    final $$PaymentAllocationsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paymentAllocationsTable,
          getReferencedColumn: (t) => t.paymentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAllocationsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.paymentAllocationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PaymentsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTableTable,
          PaymentsTableData,
          $$PaymentsTableTableFilterComposer,
          $$PaymentsTableTableOrderingComposer,
          $$PaymentsTableTableAnnotationComposer,
          $$PaymentsTableTableCreateCompanionBuilder,
          $$PaymentsTableTableUpdateCompanionBuilder,
          (PaymentsTableData, $$PaymentsTableTableReferences),
          PaymentsTableData,
          PrefetchHooks Function({
            bool customerId,
            bool currencyCode,
            bool walletId,
            bool paymentAllocationsTableRefs,
          })
        > {
  $$PaymentsTableTableTableManager(_$AppDatabase db, $PaymentsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> walletId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsTableCompanion(
                id: id,
                customerId: customerId,
                direction: direction,
                amountMinor: amountMinor,
                currencyCode: currencyCode,
                walletId: walletId,
                occurredAt: occurredAt,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String customerId,
                required String direction,
                required int amountMinor,
                required String currencyCode,
                required String walletId,
                required DateTime occurredAt,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsTableCompanion.insert(
                id: id,
                customerId: customerId,
                direction: direction,
                amountMinor: amountMinor,
                currencyCode: currencyCode,
                walletId: walletId,
                occurredAt: occurredAt,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                customerId = false,
                currencyCode = false,
                walletId = false,
                paymentAllocationsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (paymentAllocationsTableRefs) db.paymentAllocationsTable,
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
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable:
                                        $$PaymentsTableTableReferences
                                            ._customerIdTable(db),
                                    referencedColumn:
                                        $$PaymentsTableTableReferences
                                            ._customerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (currencyCode) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.currencyCode,
                                    referencedTable:
                                        $$PaymentsTableTableReferences
                                            ._currencyCodeTable(db),
                                    referencedColumn:
                                        $$PaymentsTableTableReferences
                                            ._currencyCodeTable(db)
                                            .code,
                                  )
                                  as T;
                        }
                        if (walletId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.walletId,
                                    referencedTable:
                                        $$PaymentsTableTableReferences
                                            ._walletIdTable(db),
                                    referencedColumn:
                                        $$PaymentsTableTableReferences
                                            ._walletIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (paymentAllocationsTableRefs)
                        await $_getPrefetchedData<
                          PaymentsTableData,
                          $PaymentsTableTable,
                          PaymentAllocationsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$PaymentsTableTableReferences
                              ._paymentAllocationsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PaymentsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentAllocationsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.paymentId == item.id,
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

typedef $$PaymentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTableTable,
      PaymentsTableData,
      $$PaymentsTableTableFilterComposer,
      $$PaymentsTableTableOrderingComposer,
      $$PaymentsTableTableAnnotationComposer,
      $$PaymentsTableTableCreateCompanionBuilder,
      $$PaymentsTableTableUpdateCompanionBuilder,
      (PaymentsTableData, $$PaymentsTableTableReferences),
      PaymentsTableData,
      PrefetchHooks Function({
        bool customerId,
        bool currencyCode,
        bool walletId,
        bool paymentAllocationsTableRefs,
      })
    >;
typedef $$PaymentAllocationsTableTableCreateCompanionBuilder =
    PaymentAllocationsTableCompanion Function({
      required String id,
      required String paymentId,
      required String orderId,
      required int allocatedMinor,
      required String currencyCode,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PaymentAllocationsTableTableUpdateCompanionBuilder =
    PaymentAllocationsTableCompanion Function({
      Value<String> id,
      Value<String> paymentId,
      Value<String> orderId,
      Value<int> allocatedMinor,
      Value<String> currencyCode,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PaymentAllocationsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PaymentAllocationsTableTable,
          PaymentAllocationsTableData
        > {
  $$PaymentAllocationsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PaymentsTableTable _paymentIdTable(_$AppDatabase db) =>
      db.paymentsTable.createAlias(
        $_aliasNameGenerator(
          db.paymentAllocationsTable.paymentId,
          db.paymentsTable.id,
        ),
      );

  $$PaymentsTableTableProcessedTableManager get paymentId {
    final $_column = $_itemColumn<String>('payment_id')!;

    final manager = $$PaymentsTableTableTableManager(
      $_db,
      $_db.paymentsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paymentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomerOrdersTableTable _orderIdTable(_$AppDatabase db) =>
      db.customerOrdersTable.createAlias(
        $_aliasNameGenerator(
          db.paymentAllocationsTable.orderId,
          db.customerOrdersTable.id,
        ),
      );

  $$CustomerOrdersTableTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<String>('order_id')!;

    final manager = $$CustomerOrdersTableTableTableManager(
      $_db,
      $_db.customerOrdersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CurrenciesTableTable _currencyCodeTable(_$AppDatabase db) =>
      db.currenciesTable.createAlias(
        $_aliasNameGenerator(
          db.paymentAllocationsTable.currencyCode,
          db.currenciesTable.code,
        ),
      );

  $$CurrenciesTableTableProcessedTableManager get currencyCode {
    final $_column = $_itemColumn<String>('currency_code')!;

    final manager = $$CurrenciesTableTableTableManager(
      $_db,
      $_db.currenciesTable,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_currencyCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentAllocationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentAllocationsTableTable> {
  $$PaymentAllocationsTableTableFilterComposer({
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

  ColumnFilters<int> get allocatedMinor => $composableBuilder(
    column: $table.allocatedMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PaymentsTableTableFilterComposer get paymentId {
    final $$PaymentsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentId,
      referencedTable: $db.paymentsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableTableFilterComposer(
            $db: $db,
            $table: $db.paymentsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomerOrdersTableTableFilterComposer get orderId {
    final $$CustomerOrdersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.customerOrdersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerOrdersTableTableFilterComposer(
            $db: $db,
            $table: $db.customerOrdersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableFilterComposer get currencyCode {
    final $$CurrenciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableFilterComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentAllocationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentAllocationsTableTable> {
  $$PaymentAllocationsTableTableOrderingComposer({
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

  ColumnOrderings<int> get allocatedMinor => $composableBuilder(
    column: $table.allocatedMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PaymentsTableTableOrderingComposer get paymentId {
    final $$PaymentsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentId,
      referencedTable: $db.paymentsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableTableOrderingComposer(
            $db: $db,
            $table: $db.paymentsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomerOrdersTableTableOrderingComposer get orderId {
    final $$CustomerOrdersTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.orderId,
          referencedTable: $db.customerOrdersTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CustomerOrdersTableTableOrderingComposer(
                $db: $db,
                $table: $db.customerOrdersTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$CurrenciesTableTableOrderingComposer get currencyCode {
    final $$CurrenciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentAllocationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentAllocationsTableTable> {
  $$PaymentAllocationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get allocatedMinor => $composableBuilder(
    column: $table.allocatedMinor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PaymentsTableTableAnnotationComposer get paymentId {
    final $$PaymentsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentId,
      referencedTable: $db.paymentsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomerOrdersTableTableAnnotationComposer get orderId {
    final $$CustomerOrdersTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.orderId,
          referencedTable: $db.customerOrdersTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CustomerOrdersTableTableAnnotationComposer(
                $db: $db,
                $table: $db.customerOrdersTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$CurrenciesTableTableAnnotationComposer get currencyCode {
    final $$CurrenciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentAllocationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentAllocationsTableTable,
          PaymentAllocationsTableData,
          $$PaymentAllocationsTableTableFilterComposer,
          $$PaymentAllocationsTableTableOrderingComposer,
          $$PaymentAllocationsTableTableAnnotationComposer,
          $$PaymentAllocationsTableTableCreateCompanionBuilder,
          $$PaymentAllocationsTableTableUpdateCompanionBuilder,
          (
            PaymentAllocationsTableData,
            $$PaymentAllocationsTableTableReferences,
          ),
          PaymentAllocationsTableData,
          PrefetchHooks Function({
            bool paymentId,
            bool orderId,
            bool currencyCode,
          })
        > {
  $$PaymentAllocationsTableTableTableManager(
    _$AppDatabase db,
    $PaymentAllocationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentAllocationsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PaymentAllocationsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PaymentAllocationsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> paymentId = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<int> allocatedMinor = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentAllocationsTableCompanion(
                id: id,
                paymentId: paymentId,
                orderId: orderId,
                allocatedMinor: allocatedMinor,
                currencyCode: currencyCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String paymentId,
                required String orderId,
                required int allocatedMinor,
                required String currencyCode,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentAllocationsTableCompanion.insert(
                id: id,
                paymentId: paymentId,
                orderId: orderId,
                allocatedMinor: allocatedMinor,
                currencyCode: currencyCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentAllocationsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({paymentId = false, orderId = false, currencyCode = false}) {
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
                        if (paymentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.paymentId,
                                    referencedTable:
                                        $$PaymentAllocationsTableTableReferences
                                            ._paymentIdTable(db),
                                    referencedColumn:
                                        $$PaymentAllocationsTableTableReferences
                                            ._paymentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (orderId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.orderId,
                                    referencedTable:
                                        $$PaymentAllocationsTableTableReferences
                                            ._orderIdTable(db),
                                    referencedColumn:
                                        $$PaymentAllocationsTableTableReferences
                                            ._orderIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (currencyCode) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.currencyCode,
                                    referencedTable:
                                        $$PaymentAllocationsTableTableReferences
                                            ._currencyCodeTable(db),
                                    referencedColumn:
                                        $$PaymentAllocationsTableTableReferences
                                            ._currencyCodeTable(db)
                                            .code,
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

typedef $$PaymentAllocationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentAllocationsTableTable,
      PaymentAllocationsTableData,
      $$PaymentAllocationsTableTableFilterComposer,
      $$PaymentAllocationsTableTableOrderingComposer,
      $$PaymentAllocationsTableTableAnnotationComposer,
      $$PaymentAllocationsTableTableCreateCompanionBuilder,
      $$PaymentAllocationsTableTableUpdateCompanionBuilder,
      (PaymentAllocationsTableData, $$PaymentAllocationsTableTableReferences),
      PaymentAllocationsTableData,
      PrefetchHooks Function({bool paymentId, bool orderId, bool currencyCode})
    >;
typedef $$ExchangeRatesTableTableCreateCompanionBuilder =
    ExchangeRatesTableCompanion Function({
      required String id,
      required String fromCurrency,
      required String toCurrency,
      required double rateDecimal,
      required DateTime effectiveAt,
      Value<String?> source,
      Value<int> rowid,
    });
typedef $$ExchangeRatesTableTableUpdateCompanionBuilder =
    ExchangeRatesTableCompanion Function({
      Value<String> id,
      Value<String> fromCurrency,
      Value<String> toCurrency,
      Value<double> rateDecimal,
      Value<DateTime> effectiveAt,
      Value<String?> source,
      Value<int> rowid,
    });

final class $$ExchangeRatesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExchangeRatesTableTable,
          ExchangeRatesTableData
        > {
  $$ExchangeRatesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CurrenciesTableTable _fromCurrencyTable(_$AppDatabase db) =>
      db.currenciesTable.createAlias(
        $_aliasNameGenerator(
          db.exchangeRatesTable.fromCurrency,
          db.currenciesTable.code,
        ),
      );

  $$CurrenciesTableTableProcessedTableManager get fromCurrency {
    final $_column = $_itemColumn<String>('from_currency')!;

    final manager = $$CurrenciesTableTableTableManager(
      $_db,
      $_db.currenciesTable,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromCurrencyTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CurrenciesTableTable _toCurrencyTable(_$AppDatabase db) =>
      db.currenciesTable.createAlias(
        $_aliasNameGenerator(
          db.exchangeRatesTable.toCurrency,
          db.currenciesTable.code,
        ),
      );

  $$CurrenciesTableTableProcessedTableManager get toCurrency {
    final $_column = $_itemColumn<String>('to_currency')!;

    final manager = $$CurrenciesTableTableTableManager(
      $_db,
      $_db.currenciesTable,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toCurrencyTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExchangeRatesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTableTable> {
  $$ExchangeRatesTableTableFilterComposer({
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

  ColumnFilters<double> get rateDecimal => $composableBuilder(
    column: $table.rateDecimal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get effectiveAt => $composableBuilder(
    column: $table.effectiveAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  $$CurrenciesTableTableFilterComposer get fromCurrency {
    final $$CurrenciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromCurrency,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableFilterComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableFilterComposer get toCurrency {
    final $$CurrenciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toCurrency,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableFilterComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExchangeRatesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTableTable> {
  $$ExchangeRatesTableTableOrderingComposer({
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

  ColumnOrderings<double> get rateDecimal => $composableBuilder(
    column: $table.rateDecimal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get effectiveAt => $composableBuilder(
    column: $table.effectiveAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  $$CurrenciesTableTableOrderingComposer get fromCurrency {
    final $$CurrenciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromCurrency,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableOrderingComposer get toCurrency {
    final $$CurrenciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toCurrency,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExchangeRatesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTableTable> {
  $$ExchangeRatesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get rateDecimal => $composableBuilder(
    column: $table.rateDecimal,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get effectiveAt => $composableBuilder(
    column: $table.effectiveAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$CurrenciesTableTableAnnotationComposer get fromCurrency {
    final $$CurrenciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromCurrency,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CurrenciesTableTableAnnotationComposer get toCurrency {
    final $$CurrenciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toCurrency,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExchangeRatesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExchangeRatesTableTable,
          ExchangeRatesTableData,
          $$ExchangeRatesTableTableFilterComposer,
          $$ExchangeRatesTableTableOrderingComposer,
          $$ExchangeRatesTableTableAnnotationComposer,
          $$ExchangeRatesTableTableCreateCompanionBuilder,
          $$ExchangeRatesTableTableUpdateCompanionBuilder,
          (ExchangeRatesTableData, $$ExchangeRatesTableTableReferences),
          ExchangeRatesTableData,
          PrefetchHooks Function({bool fromCurrency, bool toCurrency})
        > {
  $$ExchangeRatesTableTableTableManager(
    _$AppDatabase db,
    $ExchangeRatesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExchangeRatesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExchangeRatesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExchangeRatesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fromCurrency = const Value.absent(),
                Value<String> toCurrency = const Value.absent(),
                Value<double> rateDecimal = const Value.absent(),
                Value<DateTime> effectiveAt = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExchangeRatesTableCompanion(
                id: id,
                fromCurrency: fromCurrency,
                toCurrency: toCurrency,
                rateDecimal: rateDecimal,
                effectiveAt: effectiveAt,
                source: source,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fromCurrency,
                required String toCurrency,
                required double rateDecimal,
                required DateTime effectiveAt,
                Value<String?> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExchangeRatesTableCompanion.insert(
                id: id,
                fromCurrency: fromCurrency,
                toCurrency: toCurrency,
                rateDecimal: rateDecimal,
                effectiveAt: effectiveAt,
                source: source,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExchangeRatesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fromCurrency = false, toCurrency = false}) {
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
                    if (fromCurrency) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fromCurrency,
                                referencedTable:
                                    $$ExchangeRatesTableTableReferences
                                        ._fromCurrencyTable(db),
                                referencedColumn:
                                    $$ExchangeRatesTableTableReferences
                                        ._fromCurrencyTable(db)
                                        .code,
                              )
                              as T;
                    }
                    if (toCurrency) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.toCurrency,
                                referencedTable:
                                    $$ExchangeRatesTableTableReferences
                                        ._toCurrencyTable(db),
                                referencedColumn:
                                    $$ExchangeRatesTableTableReferences
                                        ._toCurrencyTable(db)
                                        .code,
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

typedef $$ExchangeRatesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExchangeRatesTableTable,
      ExchangeRatesTableData,
      $$ExchangeRatesTableTableFilterComposer,
      $$ExchangeRatesTableTableOrderingComposer,
      $$ExchangeRatesTableTableAnnotationComposer,
      $$ExchangeRatesTableTableCreateCompanionBuilder,
      $$ExchangeRatesTableTableUpdateCompanionBuilder,
      (ExchangeRatesTableData, $$ExchangeRatesTableTableReferences),
      ExchangeRatesTableData,
      PrefetchHooks Function({bool fromCurrency, bool toCurrency})
    >;
typedef $$ExpensesTableTableCreateCompanionBuilder =
    ExpensesTableCompanion Function({
      required String id,
      required String category,
      required int amountMinor,
      required String currencyCode,
      required String walletId,
      Value<String?> orderId,
      Value<String?> purchaseBatchId,
      Value<String?> notes,
      required DateTime occurredAt,
      Value<int> rowid,
    });
typedef $$ExpensesTableTableUpdateCompanionBuilder =
    ExpensesTableCompanion Function({
      Value<String> id,
      Value<String> category,
      Value<int> amountMinor,
      Value<String> currencyCode,
      Value<String> walletId,
      Value<String?> orderId,
      Value<String?> purchaseBatchId,
      Value<String?> notes,
      Value<DateTime> occurredAt,
      Value<int> rowid,
    });

final class $$ExpensesTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $ExpensesTableTable, ExpensesTableData> {
  $$ExpensesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CurrenciesTableTable _currencyCodeTable(_$AppDatabase db) =>
      db.currenciesTable.createAlias(
        $_aliasNameGenerator(
          db.expensesTable.currencyCode,
          db.currenciesTable.code,
        ),
      );

  $$CurrenciesTableTableProcessedTableManager get currencyCode {
    final $_column = $_itemColumn<String>('currency_code')!;

    final manager = $$CurrenciesTableTableTableManager(
      $_db,
      $_db.currenciesTable,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_currencyCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WalletsTableTable _walletIdTable(_$AppDatabase db) =>
      db.walletsTable.createAlias(
        $_aliasNameGenerator(db.expensesTable.walletId, db.walletsTable.id),
      );

  $$WalletsTableTableProcessedTableManager get walletId {
    final $_column = $_itemColumn<String>('wallet_id')!;

    final manager = $$WalletsTableTableTableManager(
      $_db,
      $_db.walletsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_walletIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomerOrdersTableTable _orderIdTable(_$AppDatabase db) =>
      db.customerOrdersTable.createAlias(
        $_aliasNameGenerator(
          db.expensesTable.orderId,
          db.customerOrdersTable.id,
        ),
      );

  $$CustomerOrdersTableTableProcessedTableManager? get orderId {
    final $_column = $_itemColumn<String>('order_id');
    if ($_column == null) return null;
    final manager = $$CustomerOrdersTableTableTableManager(
      $_db,
      $_db.customerOrdersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PurchaseBatchesTableTable _purchaseBatchIdTable(_$AppDatabase db) =>
      db.purchaseBatchesTable.createAlias(
        $_aliasNameGenerator(
          db.expensesTable.purchaseBatchId,
          db.purchaseBatchesTable.id,
        ),
      );

  $$PurchaseBatchesTableTableProcessedTableManager? get purchaseBatchId {
    final $_column = $_itemColumn<String>('purchase_batch_id');
    if ($_column == null) return null;
    final manager = $$PurchaseBatchesTableTableTableManager(
      $_db,
      $_db.purchaseBatchesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseBatchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpensesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableFilterComposer({
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

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CurrenciesTableTableFilterComposer get currencyCode {
    final $$CurrenciesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableFilterComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WalletsTableTableFilterComposer get walletId {
    final $$WalletsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletsTableTableFilterComposer(
            $db: $db,
            $table: $db.walletsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomerOrdersTableTableFilterComposer get orderId {
    final $$CustomerOrdersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.customerOrdersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomerOrdersTableTableFilterComposer(
            $db: $db,
            $table: $db.customerOrdersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PurchaseBatchesTableTableFilterComposer get purchaseBatchId {
    final $$PurchaseBatchesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseBatchId,
      referencedTable: $db.purchaseBatchesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseBatchesTableTableFilterComposer(
            $db: $db,
            $table: $db.purchaseBatchesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableOrderingComposer({
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

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CurrenciesTableTableOrderingComposer get currencyCode {
    final $$CurrenciesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableOrderingComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WalletsTableTableOrderingComposer get walletId {
    final $$WalletsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletsTableTableOrderingComposer(
            $db: $db,
            $table: $db.walletsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomerOrdersTableTableOrderingComposer get orderId {
    final $$CustomerOrdersTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.orderId,
          referencedTable: $db.customerOrdersTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CustomerOrdersTableTableOrderingComposer(
                $db: $db,
                $table: $db.customerOrdersTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PurchaseBatchesTableTableOrderingComposer get purchaseBatchId {
    final $$PurchaseBatchesTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.purchaseBatchId,
          referencedTable: $db.purchaseBatchesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseBatchesTableTableOrderingComposer(
                $db: $db,
                $table: $db.purchaseBatchesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ExpensesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  $$CurrenciesTableTableAnnotationComposer get currencyCode {
    final $$CurrenciesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currencyCode,
      referencedTable: $db.currenciesTable,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurrenciesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.currenciesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WalletsTableTableAnnotationComposer get walletId {
    final $$WalletsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.walletId,
      referencedTable: $db.walletsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WalletsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.walletsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomerOrdersTableTableAnnotationComposer get orderId {
    final $$CustomerOrdersTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.orderId,
          referencedTable: $db.customerOrdersTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CustomerOrdersTableTableAnnotationComposer(
                $db: $db,
                $table: $db.customerOrdersTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PurchaseBatchesTableTableAnnotationComposer get purchaseBatchId {
    final $$PurchaseBatchesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.purchaseBatchId,
          referencedTable: $db.purchaseBatchesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PurchaseBatchesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.purchaseBatchesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ExpensesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTableTable,
          ExpensesTableData,
          $$ExpensesTableTableFilterComposer,
          $$ExpensesTableTableOrderingComposer,
          $$ExpensesTableTableAnnotationComposer,
          $$ExpensesTableTableCreateCompanionBuilder,
          $$ExpensesTableTableUpdateCompanionBuilder,
          (ExpensesTableData, $$ExpensesTableTableReferences),
          ExpensesTableData,
          PrefetchHooks Function({
            bool currencyCode,
            bool walletId,
            bool orderId,
            bool purchaseBatchId,
          })
        > {
  $$ExpensesTableTableTableManager(_$AppDatabase db, $ExpensesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> walletId = const Value.absent(),
                Value<String?> orderId = const Value.absent(),
                Value<String?> purchaseBatchId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesTableCompanion(
                id: id,
                category: category,
                amountMinor: amountMinor,
                currencyCode: currencyCode,
                walletId: walletId,
                orderId: orderId,
                purchaseBatchId: purchaseBatchId,
                notes: notes,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String category,
                required int amountMinor,
                required String currencyCode,
                required String walletId,
                Value<String?> orderId = const Value.absent(),
                Value<String?> purchaseBatchId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime occurredAt,
                Value<int> rowid = const Value.absent(),
              }) => ExpensesTableCompanion.insert(
                id: id,
                category: category,
                amountMinor: amountMinor,
                currencyCode: currencyCode,
                walletId: walletId,
                orderId: orderId,
                purchaseBatchId: purchaseBatchId,
                notes: notes,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpensesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                currencyCode = false,
                walletId = false,
                orderId = false,
                purchaseBatchId = false,
              }) {
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
                        if (currencyCode) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.currencyCode,
                                    referencedTable:
                                        $$ExpensesTableTableReferences
                                            ._currencyCodeTable(db),
                                    referencedColumn:
                                        $$ExpensesTableTableReferences
                                            ._currencyCodeTable(db)
                                            .code,
                                  )
                                  as T;
                        }
                        if (walletId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.walletId,
                                    referencedTable:
                                        $$ExpensesTableTableReferences
                                            ._walletIdTable(db),
                                    referencedColumn:
                                        $$ExpensesTableTableReferences
                                            ._walletIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (orderId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.orderId,
                                    referencedTable:
                                        $$ExpensesTableTableReferences
                                            ._orderIdTable(db),
                                    referencedColumn:
                                        $$ExpensesTableTableReferences
                                            ._orderIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (purchaseBatchId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.purchaseBatchId,
                                    referencedTable:
                                        $$ExpensesTableTableReferences
                                            ._purchaseBatchIdTable(db),
                                    referencedColumn:
                                        $$ExpensesTableTableReferences
                                            ._purchaseBatchIdTable(db)
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

typedef $$ExpensesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTableTable,
      ExpensesTableData,
      $$ExpensesTableTableFilterComposer,
      $$ExpensesTableTableOrderingComposer,
      $$ExpensesTableTableAnnotationComposer,
      $$ExpensesTableTableCreateCompanionBuilder,
      $$ExpensesTableTableUpdateCompanionBuilder,
      (ExpensesTableData, $$ExpensesTableTableReferences),
      ExpensesTableData,
      PrefetchHooks Function({
        bool currencyCode,
        bool walletId,
        bool orderId,
        bool purchaseBatchId,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CurrenciesTableTableTableManager get currenciesTable =>
      $$CurrenciesTableTableTableManager(_db, _db.currenciesTable);
  $$WalletsTableTableTableManager get walletsTable =>
      $$WalletsTableTableTableManager(_db, _db.walletsTable);
  $$WalletBalancesTableTableTableManager get walletBalancesTable =>
      $$WalletBalancesTableTableTableManager(_db, _db.walletBalancesTable);
  $$CustomersTableTableTableManager get customersTable =>
      $$CustomersTableTableTableManager(_db, _db.customersTable);
  $$ProductsTableTableTableManager get productsTable =>
      $$ProductsTableTableTableManager(_db, _db.productsTable);
  $$CustomerOrdersTableTableTableManager get customerOrdersTable =>
      $$CustomerOrdersTableTableTableManager(_db, _db.customerOrdersTable);
  $$OrderItemsTableTableTableManager get orderItemsTable =>
      $$OrderItemsTableTableTableManager(_db, _db.orderItemsTable);
  $$PurchaseBatchesTableTableTableManager get purchaseBatchesTable =>
      $$PurchaseBatchesTableTableTableManager(_db, _db.purchaseBatchesTable);
  $$PurchaseBatchItemsTableTableTableManager get purchaseBatchItemsTable =>
      $$PurchaseBatchItemsTableTableTableManager(
        _db,
        _db.purchaseBatchItemsTable,
      );
  $$FinancialTransactionsTableTableTableManager
  get financialTransactionsTable =>
      $$FinancialTransactionsTableTableTableManager(
        _db,
        _db.financialTransactionsTable,
      );
  $$PaymentsTableTableTableManager get paymentsTable =>
      $$PaymentsTableTableTableManager(_db, _db.paymentsTable);
  $$PaymentAllocationsTableTableTableManager get paymentAllocationsTable =>
      $$PaymentAllocationsTableTableTableManager(
        _db,
        _db.paymentAllocationsTable,
      );
  $$ExchangeRatesTableTableTableManager get exchangeRatesTable =>
      $$ExchangeRatesTableTableTableManager(_db, _db.exchangeRatesTable);
  $$ExpensesTableTableTableManager get expensesTable =>
      $$ExpensesTableTableTableManager(_db, _db.expensesTable);
}
