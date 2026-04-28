// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalWeddingsTable extends LocalWeddings
    with TableInfo<$LocalWeddingsTable, LocalWedding> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalWeddingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
  static const VerificationMeta _brideNameMeta = const VerificationMeta(
    'brideName',
  );
  @override
  late final GeneratedColumn<String> brideName = GeneratedColumn<String>(
    'bride_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groomNameMeta = const VerificationMeta(
    'groomName',
  );
  @override
  late final GeneratedColumn<String> groomName = GeneratedColumn<String>(
    'groom_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weddingDateMeta = const VerificationMeta(
    'weddingDate',
  );
  @override
  late final GeneratedColumn<DateTime> weddingDate = GeneratedColumn<DateTime>(
    'wedding_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueMeta = const VerificationMeta('venue');
  @override
  late final GeneratedColumn<String> venue = GeneratedColumn<String>(
    'venue',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
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
  static const VerificationMeta _isMineMeta = const VerificationMeta('isMine');
  @override
  late final GeneratedColumn<bool> isMine = GeneratedColumn<bool>(
    'is_mine',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_mine" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    userId,
    title,
    brideName,
    groomName,
    weddingDate,
    venue,
    city,
    notes,
    isMine,
    syncStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_weddings';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalWedding> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
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
    if (data.containsKey('bride_name')) {
      context.handle(
        _brideNameMeta,
        brideName.isAcceptableOrUnknown(data['bride_name']!, _brideNameMeta),
      );
    } else if (isInserting) {
      context.missing(_brideNameMeta);
    }
    if (data.containsKey('groom_name')) {
      context.handle(
        _groomNameMeta,
        groomName.isAcceptableOrUnknown(data['groom_name']!, _groomNameMeta),
      );
    } else if (isInserting) {
      context.missing(_groomNameMeta);
    }
    if (data.containsKey('wedding_date')) {
      context.handle(
        _weddingDateMeta,
        weddingDate.isAcceptableOrUnknown(
          data['wedding_date']!,
          _weddingDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weddingDateMeta);
    }
    if (data.containsKey('venue')) {
      context.handle(
        _venueMeta,
        venue.isAcceptableOrUnknown(data['venue']!, _venueMeta),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_mine')) {
      context.handle(
        _isMineMeta,
        isMine.isAcceptableOrUnknown(data['is_mine']!, _isMineMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
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
  LocalWedding map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalWedding(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      brideName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bride_name'],
      )!,
      groomName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}groom_name'],
      )!,
      weddingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}wedding_date'],
      )!,
      venue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue'],
      ),
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isMine: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_mine'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocalWeddingsTable createAlias(String alias) {
    return $LocalWeddingsTable(attachedDatabase, alias);
  }
}

class LocalWedding extends DataClass implements Insertable<LocalWedding> {
  final String id;
  final String userId;
  final String title;
  final String brideName;
  final String groomName;
  final DateTime weddingDate;
  final String? venue;
  final String? city;
  final String? notes;
  final bool isMine;
  final int syncStatus;
  final DateTime updatedAt;
  const LocalWedding({
    required this.id,
    required this.userId,
    required this.title,
    required this.brideName,
    required this.groomName,
    required this.weddingDate,
    this.venue,
    this.city,
    this.notes,
    required this.isMine,
    required this.syncStatus,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['title'] = Variable<String>(title);
    map['bride_name'] = Variable<String>(brideName);
    map['groom_name'] = Variable<String>(groomName);
    map['wedding_date'] = Variable<DateTime>(weddingDate);
    if (!nullToAbsent || venue != null) {
      map['venue'] = Variable<String>(venue);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_mine'] = Variable<bool>(isMine);
    map['sync_status'] = Variable<int>(syncStatus);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalWeddingsCompanion toCompanion(bool nullToAbsent) {
    return LocalWeddingsCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      brideName: Value(brideName),
      groomName: Value(groomName),
      weddingDate: Value(weddingDate),
      venue: venue == null && nullToAbsent
          ? const Value.absent()
          : Value(venue),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isMine: Value(isMine),
      syncStatus: Value(syncStatus),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalWedding.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalWedding(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      brideName: serializer.fromJson<String>(json['brideName']),
      groomName: serializer.fromJson<String>(json['groomName']),
      weddingDate: serializer.fromJson<DateTime>(json['weddingDate']),
      venue: serializer.fromJson<String?>(json['venue']),
      city: serializer.fromJson<String?>(json['city']),
      notes: serializer.fromJson<String?>(json['notes']),
      isMine: serializer.fromJson<bool>(json['isMine']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'title': serializer.toJson<String>(title),
      'brideName': serializer.toJson<String>(brideName),
      'groomName': serializer.toJson<String>(groomName),
      'weddingDate': serializer.toJson<DateTime>(weddingDate),
      'venue': serializer.toJson<String?>(venue),
      'city': serializer.toJson<String?>(city),
      'notes': serializer.toJson<String?>(notes),
      'isMine': serializer.toJson<bool>(isMine),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalWedding copyWith({
    String? id,
    String? userId,
    String? title,
    String? brideName,
    String? groomName,
    DateTime? weddingDate,
    Value<String?> venue = const Value.absent(),
    Value<String?> city = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isMine,
    int? syncStatus,
    DateTime? updatedAt,
  }) => LocalWedding(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    brideName: brideName ?? this.brideName,
    groomName: groomName ?? this.groomName,
    weddingDate: weddingDate ?? this.weddingDate,
    venue: venue.present ? venue.value : this.venue,
    city: city.present ? city.value : this.city,
    notes: notes.present ? notes.value : this.notes,
    isMine: isMine ?? this.isMine,
    syncStatus: syncStatus ?? this.syncStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocalWedding copyWithCompanion(LocalWeddingsCompanion data) {
    return LocalWedding(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      brideName: data.brideName.present ? data.brideName.value : this.brideName,
      groomName: data.groomName.present ? data.groomName.value : this.groomName,
      weddingDate: data.weddingDate.present
          ? data.weddingDate.value
          : this.weddingDate,
      venue: data.venue.present ? data.venue.value : this.venue,
      city: data.city.present ? data.city.value : this.city,
      notes: data.notes.present ? data.notes.value : this.notes,
      isMine: data.isMine.present ? data.isMine.value : this.isMine,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalWedding(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('brideName: $brideName, ')
          ..write('groomName: $groomName, ')
          ..write('weddingDate: $weddingDate, ')
          ..write('venue: $venue, ')
          ..write('city: $city, ')
          ..write('notes: $notes, ')
          ..write('isMine: $isMine, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    title,
    brideName,
    groomName,
    weddingDate,
    venue,
    city,
    notes,
    isMine,
    syncStatus,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalWedding &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.brideName == this.brideName &&
          other.groomName == this.groomName &&
          other.weddingDate == this.weddingDate &&
          other.venue == this.venue &&
          other.city == this.city &&
          other.notes == this.notes &&
          other.isMine == this.isMine &&
          other.syncStatus == this.syncStatus &&
          other.updatedAt == this.updatedAt);
}

class LocalWeddingsCompanion extends UpdateCompanion<LocalWedding> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> title;
  final Value<String> brideName;
  final Value<String> groomName;
  final Value<DateTime> weddingDate;
  final Value<String?> venue;
  final Value<String?> city;
  final Value<String?> notes;
  final Value<bool> isMine;
  final Value<int> syncStatus;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalWeddingsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.brideName = const Value.absent(),
    this.groomName = const Value.absent(),
    this.weddingDate = const Value.absent(),
    this.venue = const Value.absent(),
    this.city = const Value.absent(),
    this.notes = const Value.absent(),
    this.isMine = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalWeddingsCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required String title,
    required String brideName,
    required String groomName,
    required DateTime weddingDate,
    this.venue = const Value.absent(),
    this.city = const Value.absent(),
    this.notes = const Value.absent(),
    this.isMine = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       brideName = Value(brideName),
       groomName = Value(groomName),
       weddingDate = Value(weddingDate);
  static Insertable<LocalWedding> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<String>? brideName,
    Expression<String>? groomName,
    Expression<DateTime>? weddingDate,
    Expression<String>? venue,
    Expression<String>? city,
    Expression<String>? notes,
    Expression<bool>? isMine,
    Expression<int>? syncStatus,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (brideName != null) 'bride_name': brideName,
      if (groomName != null) 'groom_name': groomName,
      if (weddingDate != null) 'wedding_date': weddingDate,
      if (venue != null) 'venue': venue,
      if (city != null) 'city': city,
      if (notes != null) 'notes': notes,
      if (isMine != null) 'is_mine': isMine,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalWeddingsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? title,
    Value<String>? brideName,
    Value<String>? groomName,
    Value<DateTime>? weddingDate,
    Value<String?>? venue,
    Value<String?>? city,
    Value<String?>? notes,
    Value<bool>? isMine,
    Value<int>? syncStatus,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return LocalWeddingsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      brideName: brideName ?? this.brideName,
      groomName: groomName ?? this.groomName,
      weddingDate: weddingDate ?? this.weddingDate,
      venue: venue ?? this.venue,
      city: city ?? this.city,
      notes: notes ?? this.notes,
      isMine: isMine ?? this.isMine,
      syncStatus: syncStatus ?? this.syncStatus,
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
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (brideName.present) {
      map['bride_name'] = Variable<String>(brideName.value);
    }
    if (groomName.present) {
      map['groom_name'] = Variable<String>(groomName.value);
    }
    if (weddingDate.present) {
      map['wedding_date'] = Variable<DateTime>(weddingDate.value);
    }
    if (venue.present) {
      map['venue'] = Variable<String>(venue.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isMine.present) {
      map['is_mine'] = Variable<bool>(isMine.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
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
    return (StringBuffer('LocalWeddingsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('brideName: $brideName, ')
          ..write('groomName: $groomName, ')
          ..write('weddingDate: $weddingDate, ')
          ..write('venue: $venue, ')
          ..write('city: $city, ')
          ..write('notes: $notes, ')
          ..write('isMine: $isMine, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalGuestsTable extends LocalGuests
    with TableInfo<$LocalGuestsTable, LocalGuest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalGuestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relationshipMeta = const VerificationMeta(
    'relationship',
  );
  @override
  late final GeneratedColumn<String> relationship = GeneratedColumn<String>(
    'relationship',
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
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    fullName,
    phone,
    city,
    relationship,
    notes,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_guests';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalGuest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('relationship')) {
      context.handle(
        _relationshipMeta,
        relationship.isAcceptableOrUnknown(
          data['relationship']!,
          _relationshipMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalGuest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalGuest(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      ),
      relationship: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relationship'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalGuestsTable createAlias(String alias) {
    return $LocalGuestsTable(attachedDatabase, alias);
  }
}

class LocalGuest extends DataClass implements Insertable<LocalGuest> {
  final String id;
  final String userId;
  final String fullName;
  final String? phone;
  final String? city;
  final String? relationship;
  final String? notes;
  final int syncStatus;
  const LocalGuest({
    required this.id,
    required this.userId,
    required this.fullName,
    this.phone,
    this.city,
    this.relationship,
    this.notes,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || relationship != null) {
      map['relationship'] = Variable<String>(relationship);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['sync_status'] = Variable<int>(syncStatus);
    return map;
  }

  LocalGuestsCompanion toCompanion(bool nullToAbsent) {
    return LocalGuestsCompanion(
      id: Value(id),
      userId: Value(userId),
      fullName: Value(fullName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      relationship: relationship == null && nullToAbsent
          ? const Value.absent()
          : Value(relationship),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalGuest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalGuest(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phone: serializer.fromJson<String?>(json['phone']),
      city: serializer.fromJson<String?>(json['city']),
      relationship: serializer.fromJson<String?>(json['relationship']),
      notes: serializer.fromJson<String?>(json['notes']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'fullName': serializer.toJson<String>(fullName),
      'phone': serializer.toJson<String?>(phone),
      'city': serializer.toJson<String?>(city),
      'relationship': serializer.toJson<String?>(relationship),
      'notes': serializer.toJson<String?>(notes),
      'syncStatus': serializer.toJson<int>(syncStatus),
    };
  }

  LocalGuest copyWith({
    String? id,
    String? userId,
    String? fullName,
    Value<String?> phone = const Value.absent(),
    Value<String?> city = const Value.absent(),
    Value<String?> relationship = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? syncStatus,
  }) => LocalGuest(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    fullName: fullName ?? this.fullName,
    phone: phone.present ? phone.value : this.phone,
    city: city.present ? city.value : this.city,
    relationship: relationship.present ? relationship.value : this.relationship,
    notes: notes.present ? notes.value : this.notes,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalGuest copyWithCompanion(LocalGuestsCompanion data) {
    return LocalGuest(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phone: data.phone.present ? data.phone.value : this.phone,
      city: data.city.present ? data.city.value : this.city,
      relationship: data.relationship.present
          ? data.relationship.value
          : this.relationship,
      notes: data.notes.present ? data.notes.value : this.notes,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalGuest(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('city: $city, ')
          ..write('relationship: $relationship, ')
          ..write('notes: $notes, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    fullName,
    phone,
    city,
    relationship,
    notes,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalGuest &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.fullName == this.fullName &&
          other.phone == this.phone &&
          other.city == this.city &&
          other.relationship == this.relationship &&
          other.notes == this.notes &&
          other.syncStatus == this.syncStatus);
}

class LocalGuestsCompanion extends UpdateCompanion<LocalGuest> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> fullName;
  final Value<String?> phone;
  final Value<String?> city;
  final Value<String?> relationship;
  final Value<String?> notes;
  final Value<int> syncStatus;
  final Value<int> rowid;
  const LocalGuestsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.city = const Value.absent(),
    this.relationship = const Value.absent(),
    this.notes = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalGuestsCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required String fullName,
    this.phone = const Value.absent(),
    this.city = const Value.absent(),
    this.relationship = const Value.absent(),
    this.notes = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fullName = Value(fullName);
  static Insertable<LocalGuest> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? fullName,
    Expression<String>? phone,
    Expression<String>? city,
    Expression<String>? relationship,
    Expression<String>? notes,
    Expression<int>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (fullName != null) 'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (city != null) 'city': city,
      if (relationship != null) 'relationship': relationship,
      if (notes != null) 'notes': notes,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalGuestsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? fullName,
    Value<String?>? phone,
    Value<String?>? city,
    Value<String?>? relationship,
    Value<String?>? notes,
    Value<int>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalGuestsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      relationship: relationship ?? this.relationship,
      notes: notes ?? this.notes,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (relationship.present) {
      map['relationship'] = Variable<String>(relationship.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalGuestsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('city: $city, ')
          ..write('relationship: $relationship, ')
          ..write('notes: $notes, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalGiftsTable extends LocalGifts
    with TableInfo<$LocalGiftsTable, LocalGift> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalGiftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _weddingIdMeta = const VerificationMeta(
    'weddingId',
  );
  @override
  late final GeneratedColumn<String> weddingId = GeneratedColumn<String>(
    'wedding_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _guestIdMeta = const VerificationMeta(
    'guestId',
  );
  @override
  late final GeneratedColumn<String> guestId = GeneratedColumn<String>(
    'guest_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _guestNameSnapshotMeta = const VerificationMeta(
    'guestNameSnapshot',
  );
  @override
  late final GeneratedColumn<String> guestNameSnapshot =
      GeneratedColumn<String>(
        'guest_name_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _giftTypeIdMeta = const VerificationMeta(
    'giftTypeId',
  );
  @override
  late final GeneratedColumn<int> giftTypeId = GeneratedColumn<int>(
    'gift_type_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _recordedAmountTryMeta = const VerificationMeta(
    'recordedAmountTry',
  );
  @override
  late final GeneratedColumn<double> recordedAmountTry =
      GeneratedColumn<double>(
        'recorded_amount_try',
        aliasedName,
        true,
        type: DriftSqlType.double,
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
  static const VerificationMeta _givenAtMeta = const VerificationMeta(
    'givenAt',
  );
  @override
  late final GeneratedColumn<DateTime> givenAt = GeneratedColumn<DateTime>(
    'given_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<int> syncStatus = GeneratedColumn<int>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    userId,
    weddingId,
    guestId,
    guestNameSnapshot,
    giftTypeId,
    quantity,
    recordedAmountTry,
    notes,
    givenAt,
    syncStatus,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_gifts';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalGift> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('wedding_id')) {
      context.handle(
        _weddingIdMeta,
        weddingId.isAcceptableOrUnknown(data['wedding_id']!, _weddingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_weddingIdMeta);
    }
    if (data.containsKey('guest_id')) {
      context.handle(
        _guestIdMeta,
        guestId.isAcceptableOrUnknown(data['guest_id']!, _guestIdMeta),
      );
    }
    if (data.containsKey('guest_name_snapshot')) {
      context.handle(
        _guestNameSnapshotMeta,
        guestNameSnapshot.isAcceptableOrUnknown(
          data['guest_name_snapshot']!,
          _guestNameSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_guestNameSnapshotMeta);
    }
    if (data.containsKey('gift_type_id')) {
      context.handle(
        _giftTypeIdMeta,
        giftTypeId.isAcceptableOrUnknown(
          data['gift_type_id']!,
          _giftTypeIdMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('recorded_amount_try')) {
      context.handle(
        _recordedAmountTryMeta,
        recordedAmountTry.isAcceptableOrUnknown(
          data['recorded_amount_try']!,
          _recordedAmountTryMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('given_at')) {
      context.handle(
        _givenAtMeta,
        givenAt.isAcceptableOrUnknown(data['given_at']!, _givenAtMeta),
      );
    } else if (isInserting) {
      context.missing(_givenAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
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
  LocalGift map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalGift(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      weddingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wedding_id'],
      )!,
      guestId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}guest_id'],
      ),
      guestNameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}guest_name_snapshot'],
      )!,
      giftTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gift_type_id'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      recordedAmountTry: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}recorded_amount_try'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      givenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}given_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocalGiftsTable createAlias(String alias) {
    return $LocalGiftsTable(attachedDatabase, alias);
  }
}

class LocalGift extends DataClass implements Insertable<LocalGift> {
  final String id;
  final String userId;
  final String weddingId;
  final String? guestId;
  final String guestNameSnapshot;
  final int? giftTypeId;
  final double quantity;
  final double? recordedAmountTry;
  final String? notes;
  final DateTime givenAt;
  final int syncStatus;
  final DateTime createdAt;
  const LocalGift({
    required this.id,
    required this.userId,
    required this.weddingId,
    this.guestId,
    required this.guestNameSnapshot,
    this.giftTypeId,
    required this.quantity,
    this.recordedAmountTry,
    this.notes,
    required this.givenAt,
    required this.syncStatus,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['wedding_id'] = Variable<String>(weddingId);
    if (!nullToAbsent || guestId != null) {
      map['guest_id'] = Variable<String>(guestId);
    }
    map['guest_name_snapshot'] = Variable<String>(guestNameSnapshot);
    if (!nullToAbsent || giftTypeId != null) {
      map['gift_type_id'] = Variable<int>(giftTypeId);
    }
    map['quantity'] = Variable<double>(quantity);
    if (!nullToAbsent || recordedAmountTry != null) {
      map['recorded_amount_try'] = Variable<double>(recordedAmountTry);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['given_at'] = Variable<DateTime>(givenAt);
    map['sync_status'] = Variable<int>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocalGiftsCompanion toCompanion(bool nullToAbsent) {
    return LocalGiftsCompanion(
      id: Value(id),
      userId: Value(userId),
      weddingId: Value(weddingId),
      guestId: guestId == null && nullToAbsent
          ? const Value.absent()
          : Value(guestId),
      guestNameSnapshot: Value(guestNameSnapshot),
      giftTypeId: giftTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(giftTypeId),
      quantity: Value(quantity),
      recordedAmountTry: recordedAmountTry == null && nullToAbsent
          ? const Value.absent()
          : Value(recordedAmountTry),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      givenAt: Value(givenAt),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
    );
  }

  factory LocalGift.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalGift(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      weddingId: serializer.fromJson<String>(json['weddingId']),
      guestId: serializer.fromJson<String?>(json['guestId']),
      guestNameSnapshot: serializer.fromJson<String>(json['guestNameSnapshot']),
      giftTypeId: serializer.fromJson<int?>(json['giftTypeId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      recordedAmountTry: serializer.fromJson<double?>(
        json['recordedAmountTry'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      givenAt: serializer.fromJson<DateTime>(json['givenAt']),
      syncStatus: serializer.fromJson<int>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'weddingId': serializer.toJson<String>(weddingId),
      'guestId': serializer.toJson<String?>(guestId),
      'guestNameSnapshot': serializer.toJson<String>(guestNameSnapshot),
      'giftTypeId': serializer.toJson<int?>(giftTypeId),
      'quantity': serializer.toJson<double>(quantity),
      'recordedAmountTry': serializer.toJson<double?>(recordedAmountTry),
      'notes': serializer.toJson<String?>(notes),
      'givenAt': serializer.toJson<DateTime>(givenAt),
      'syncStatus': serializer.toJson<int>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalGift copyWith({
    String? id,
    String? userId,
    String? weddingId,
    Value<String?> guestId = const Value.absent(),
    String? guestNameSnapshot,
    Value<int?> giftTypeId = const Value.absent(),
    double? quantity,
    Value<double?> recordedAmountTry = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? givenAt,
    int? syncStatus,
    DateTime? createdAt,
  }) => LocalGift(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    weddingId: weddingId ?? this.weddingId,
    guestId: guestId.present ? guestId.value : this.guestId,
    guestNameSnapshot: guestNameSnapshot ?? this.guestNameSnapshot,
    giftTypeId: giftTypeId.present ? giftTypeId.value : this.giftTypeId,
    quantity: quantity ?? this.quantity,
    recordedAmountTry: recordedAmountTry.present
        ? recordedAmountTry.value
        : this.recordedAmountTry,
    notes: notes.present ? notes.value : this.notes,
    givenAt: givenAt ?? this.givenAt,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalGift copyWithCompanion(LocalGiftsCompanion data) {
    return LocalGift(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      weddingId: data.weddingId.present ? data.weddingId.value : this.weddingId,
      guestId: data.guestId.present ? data.guestId.value : this.guestId,
      guestNameSnapshot: data.guestNameSnapshot.present
          ? data.guestNameSnapshot.value
          : this.guestNameSnapshot,
      giftTypeId: data.giftTypeId.present
          ? data.giftTypeId.value
          : this.giftTypeId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      recordedAmountTry: data.recordedAmountTry.present
          ? data.recordedAmountTry.value
          : this.recordedAmountTry,
      notes: data.notes.present ? data.notes.value : this.notes,
      givenAt: data.givenAt.present ? data.givenAt.value : this.givenAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalGift(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weddingId: $weddingId, ')
          ..write('guestId: $guestId, ')
          ..write('guestNameSnapshot: $guestNameSnapshot, ')
          ..write('giftTypeId: $giftTypeId, ')
          ..write('quantity: $quantity, ')
          ..write('recordedAmountTry: $recordedAmountTry, ')
          ..write('notes: $notes, ')
          ..write('givenAt: $givenAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    weddingId,
    guestId,
    guestNameSnapshot,
    giftTypeId,
    quantity,
    recordedAmountTry,
    notes,
    givenAt,
    syncStatus,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalGift &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.weddingId == this.weddingId &&
          other.guestId == this.guestId &&
          other.guestNameSnapshot == this.guestNameSnapshot &&
          other.giftTypeId == this.giftTypeId &&
          other.quantity == this.quantity &&
          other.recordedAmountTry == this.recordedAmountTry &&
          other.notes == this.notes &&
          other.givenAt == this.givenAt &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt);
}

class LocalGiftsCompanion extends UpdateCompanion<LocalGift> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> weddingId;
  final Value<String?> guestId;
  final Value<String> guestNameSnapshot;
  final Value<int?> giftTypeId;
  final Value<double> quantity;
  final Value<double?> recordedAmountTry;
  final Value<String?> notes;
  final Value<DateTime> givenAt;
  final Value<int> syncStatus;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocalGiftsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.weddingId = const Value.absent(),
    this.guestId = const Value.absent(),
    this.guestNameSnapshot = const Value.absent(),
    this.giftTypeId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.recordedAmountTry = const Value.absent(),
    this.notes = const Value.absent(),
    this.givenAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalGiftsCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required String weddingId,
    this.guestId = const Value.absent(),
    required String guestNameSnapshot,
    this.giftTypeId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.recordedAmountTry = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime givenAt,
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       weddingId = Value(weddingId),
       guestNameSnapshot = Value(guestNameSnapshot),
       givenAt = Value(givenAt);
  static Insertable<LocalGift> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? weddingId,
    Expression<String>? guestId,
    Expression<String>? guestNameSnapshot,
    Expression<int>? giftTypeId,
    Expression<double>? quantity,
    Expression<double>? recordedAmountTry,
    Expression<String>? notes,
    Expression<DateTime>? givenAt,
    Expression<int>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (weddingId != null) 'wedding_id': weddingId,
      if (guestId != null) 'guest_id': guestId,
      if (guestNameSnapshot != null) 'guest_name_snapshot': guestNameSnapshot,
      if (giftTypeId != null) 'gift_type_id': giftTypeId,
      if (quantity != null) 'quantity': quantity,
      if (recordedAmountTry != null) 'recorded_amount_try': recordedAmountTry,
      if (notes != null) 'notes': notes,
      if (givenAt != null) 'given_at': givenAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalGiftsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? weddingId,
    Value<String?>? guestId,
    Value<String>? guestNameSnapshot,
    Value<int?>? giftTypeId,
    Value<double>? quantity,
    Value<double?>? recordedAmountTry,
    Value<String?>? notes,
    Value<DateTime>? givenAt,
    Value<int>? syncStatus,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LocalGiftsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      weddingId: weddingId ?? this.weddingId,
      guestId: guestId ?? this.guestId,
      guestNameSnapshot: guestNameSnapshot ?? this.guestNameSnapshot,
      giftTypeId: giftTypeId ?? this.giftTypeId,
      quantity: quantity ?? this.quantity,
      recordedAmountTry: recordedAmountTry ?? this.recordedAmountTry,
      notes: notes ?? this.notes,
      givenAt: givenAt ?? this.givenAt,
      syncStatus: syncStatus ?? this.syncStatus,
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
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (weddingId.present) {
      map['wedding_id'] = Variable<String>(weddingId.value);
    }
    if (guestId.present) {
      map['guest_id'] = Variable<String>(guestId.value);
    }
    if (guestNameSnapshot.present) {
      map['guest_name_snapshot'] = Variable<String>(guestNameSnapshot.value);
    }
    if (giftTypeId.present) {
      map['gift_type_id'] = Variable<int>(giftTypeId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (recordedAmountTry.present) {
      map['recorded_amount_try'] = Variable<double>(recordedAmountTry.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (givenAt.present) {
      map['given_at'] = Variable<DateTime>(givenAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<int>(syncStatus.value);
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
    return (StringBuffer('LocalGiftsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weddingId: $weddingId, ')
          ..write('guestId: $guestId, ')
          ..write('guestNameSnapshot: $guestNameSnapshot, ')
          ..write('giftTypeId: $giftTypeId, ')
          ..write('quantity: $quantity, ')
          ..write('recordedAmountTry: $recordedAmountTry, ')
          ..write('notes: $notes, ')
          ..write('givenAt: $givenAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalSyncQueueTable extends LocalSyncQueue
    with TableInfo<$LocalSyncQueueTable, LocalSyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSyncQueueTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _targetTableMeta = const VerificationMeta(
    'targetTable',
  );
  @override
  late final GeneratedColumn<String> targetTable = GeneratedColumn<String>(
    'target_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
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
    targetTable,
    operation,
    localId,
    payload,
    retryCount,
    lastError,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('target_table')) {
      context.handle(
        _targetTableMeta,
        targetTable.isAcceptableOrUnknown(
          data['target_table']!,
          _targetTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetTableMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
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
  LocalSyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      targetTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_table'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocalSyncQueueTable createAlias(String alias) {
    return $LocalSyncQueueTable(attachedDatabase, alias);
  }
}

class LocalSyncQueueData extends DataClass
    implements Insertable<LocalSyncQueueData> {
  final int id;
  final String targetTable;
  final String operation;
  final String localId;
  final String payload;
  final int retryCount;
  final String? lastError;
  final DateTime createdAt;
  const LocalSyncQueueData({
    required this.id,
    required this.targetTable,
    required this.operation,
    required this.localId,
    required this.payload,
    required this.retryCount,
    this.lastError,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['target_table'] = Variable<String>(targetTable);
    map['operation'] = Variable<String>(operation);
    map['local_id'] = Variable<String>(localId);
    map['payload'] = Variable<String>(payload);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocalSyncQueueCompanion toCompanion(bool nullToAbsent) {
    return LocalSyncQueueCompanion(
      id: Value(id),
      targetTable: Value(targetTable),
      operation: Value(operation),
      localId: Value(localId),
      payload: Value(payload),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
    );
  }

  factory LocalSyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      targetTable: serializer.fromJson<String>(json['targetTable']),
      operation: serializer.fromJson<String>(json['operation']),
      localId: serializer.fromJson<String>(json['localId']),
      payload: serializer.fromJson<String>(json['payload']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'targetTable': serializer.toJson<String>(targetTable),
      'operation': serializer.toJson<String>(operation),
      'localId': serializer.toJson<String>(localId),
      'payload': serializer.toJson<String>(payload),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalSyncQueueData copyWith({
    int? id,
    String? targetTable,
    String? operation,
    String? localId,
    String? payload,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
    DateTime? createdAt,
  }) => LocalSyncQueueData(
    id: id ?? this.id,
    targetTable: targetTable ?? this.targetTable,
    operation: operation ?? this.operation,
    localId: localId ?? this.localId,
    payload: payload ?? this.payload,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalSyncQueueData copyWithCompanion(LocalSyncQueueCompanion data) {
    return LocalSyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      targetTable: data.targetTable.present
          ? data.targetTable.value
          : this.targetTable,
      operation: data.operation.present ? data.operation.value : this.operation,
      localId: data.localId.present ? data.localId.value : this.localId,
      payload: data.payload.present ? data.payload.value : this.payload,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSyncQueueData(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('operation: $operation, ')
          ..write('localId: $localId, ')
          ..write('payload: $payload, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    targetTable,
    operation,
    localId,
    payload,
    retryCount,
    lastError,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSyncQueueData &&
          other.id == this.id &&
          other.targetTable == this.targetTable &&
          other.operation == this.operation &&
          other.localId == this.localId &&
          other.payload == this.payload &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt);
}

class LocalSyncQueueCompanion extends UpdateCompanion<LocalSyncQueueData> {
  final Value<int> id;
  final Value<String> targetTable;
  final Value<String> operation;
  final Value<String> localId;
  final Value<String> payload;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  const LocalSyncQueueCompanion({
    this.id = const Value.absent(),
    this.targetTable = const Value.absent(),
    this.operation = const Value.absent(),
    this.localId = const Value.absent(),
    this.payload = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LocalSyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String targetTable,
    required String operation,
    required String localId,
    required String payload,
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : targetTable = Value(targetTable),
       operation = Value(operation),
       localId = Value(localId),
       payload = Value(payload);
  static Insertable<LocalSyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? targetTable,
    Expression<String>? operation,
    Expression<String>? localId,
    Expression<String>? payload,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetTable != null) 'target_table': targetTable,
      if (operation != null) 'operation': operation,
      if (localId != null) 'local_id': localId,
      if (payload != null) 'payload': payload,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LocalSyncQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? targetTable,
    Value<String>? operation,
    Value<String>? localId,
    Value<String>? payload,
    Value<int>? retryCount,
    Value<String?>? lastError,
    Value<DateTime>? createdAt,
  }) {
    return LocalSyncQueueCompanion(
      id: id ?? this.id,
      targetTable: targetTable ?? this.targetTable,
      operation: operation ?? this.operation,
      localId: localId ?? this.localId,
      payload: payload ?? this.payload,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (targetTable.present) {
      map['target_table'] = Variable<String>(targetTable.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('operation: $operation, ')
          ..write('localId: $localId, ')
          ..write('payload: $payload, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalWeddingsTable localWeddings = $LocalWeddingsTable(this);
  late final $LocalGuestsTable localGuests = $LocalGuestsTable(this);
  late final $LocalGiftsTable localGifts = $LocalGiftsTable(this);
  late final $LocalSyncQueueTable localSyncQueue = $LocalSyncQueueTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localWeddings,
    localGuests,
    localGifts,
    localSyncQueue,
  ];
}

typedef $$LocalWeddingsTableCreateCompanionBuilder =
    LocalWeddingsCompanion Function({
      required String id,
      Value<String> userId,
      required String title,
      required String brideName,
      required String groomName,
      required DateTime weddingDate,
      Value<String?> venue,
      Value<String?> city,
      Value<String?> notes,
      Value<bool> isMine,
      Value<int> syncStatus,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$LocalWeddingsTableUpdateCompanionBuilder =
    LocalWeddingsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> title,
      Value<String> brideName,
      Value<String> groomName,
      Value<DateTime> weddingDate,
      Value<String?> venue,
      Value<String?> city,
      Value<String?> notes,
      Value<bool> isMine,
      Value<int> syncStatus,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$LocalWeddingsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalWeddingsTable> {
  $$LocalWeddingsTableFilterComposer({
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

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brideName => $composableBuilder(
    column: $table.brideName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groomName => $composableBuilder(
    column: $table.groomName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get weddingDate => $composableBuilder(
    column: $table.weddingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venue => $composableBuilder(
    column: $table.venue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMine => $composableBuilder(
    column: $table.isMine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalWeddingsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalWeddingsTable> {
  $$LocalWeddingsTableOrderingComposer({
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

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brideName => $composableBuilder(
    column: $table.brideName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groomName => $composableBuilder(
    column: $table.groomName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get weddingDate => $composableBuilder(
    column: $table.weddingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venue => $composableBuilder(
    column: $table.venue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMine => $composableBuilder(
    column: $table.isMine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalWeddingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalWeddingsTable> {
  $$LocalWeddingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get brideName =>
      $composableBuilder(column: $table.brideName, builder: (column) => column);

  GeneratedColumn<String> get groomName =>
      $composableBuilder(column: $table.groomName, builder: (column) => column);

  GeneratedColumn<DateTime> get weddingDate => $composableBuilder(
    column: $table.weddingDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get venue =>
      $composableBuilder(column: $table.venue, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isMine =>
      $composableBuilder(column: $table.isMine, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalWeddingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalWeddingsTable,
          LocalWedding,
          $$LocalWeddingsTableFilterComposer,
          $$LocalWeddingsTableOrderingComposer,
          $$LocalWeddingsTableAnnotationComposer,
          $$LocalWeddingsTableCreateCompanionBuilder,
          $$LocalWeddingsTableUpdateCompanionBuilder,
          (
            LocalWedding,
            BaseReferences<_$AppDatabase, $LocalWeddingsTable, LocalWedding>,
          ),
          LocalWedding,
          PrefetchHooks Function()
        > {
  $$LocalWeddingsTableTableManager(_$AppDatabase db, $LocalWeddingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalWeddingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalWeddingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalWeddingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> brideName = const Value.absent(),
                Value<String> groomName = const Value.absent(),
                Value<DateTime> weddingDate = const Value.absent(),
                Value<String?> venue = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isMine = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalWeddingsCompanion(
                id: id,
                userId: userId,
                title: title,
                brideName: brideName,
                groomName: groomName,
                weddingDate: weddingDate,
                venue: venue,
                city: city,
                notes: notes,
                isMine: isMine,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> userId = const Value.absent(),
                required String title,
                required String brideName,
                required String groomName,
                required DateTime weddingDate,
                Value<String?> venue = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isMine = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalWeddingsCompanion.insert(
                id: id,
                userId: userId,
                title: title,
                brideName: brideName,
                groomName: groomName,
                weddingDate: weddingDate,
                venue: venue,
                city: city,
                notes: notes,
                isMine: isMine,
                syncStatus: syncStatus,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalWeddingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalWeddingsTable,
      LocalWedding,
      $$LocalWeddingsTableFilterComposer,
      $$LocalWeddingsTableOrderingComposer,
      $$LocalWeddingsTableAnnotationComposer,
      $$LocalWeddingsTableCreateCompanionBuilder,
      $$LocalWeddingsTableUpdateCompanionBuilder,
      (
        LocalWedding,
        BaseReferences<_$AppDatabase, $LocalWeddingsTable, LocalWedding>,
      ),
      LocalWedding,
      PrefetchHooks Function()
    >;
typedef $$LocalGuestsTableCreateCompanionBuilder =
    LocalGuestsCompanion Function({
      required String id,
      Value<String> userId,
      required String fullName,
      Value<String?> phone,
      Value<String?> city,
      Value<String?> relationship,
      Value<String?> notes,
      Value<int> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalGuestsTableUpdateCompanionBuilder =
    LocalGuestsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> fullName,
      Value<String?> phone,
      Value<String?> city,
      Value<String?> relationship,
      Value<String?> notes,
      Value<int> syncStatus,
      Value<int> rowid,
    });

class $$LocalGuestsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalGuestsTable> {
  $$LocalGuestsTableFilterComposer({
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

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalGuestsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalGuestsTable> {
  $$LocalGuestsTableOrderingComposer({
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

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalGuestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalGuestsTable> {
  $$LocalGuestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$LocalGuestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalGuestsTable,
          LocalGuest,
          $$LocalGuestsTableFilterComposer,
          $$LocalGuestsTableOrderingComposer,
          $$LocalGuestsTableAnnotationComposer,
          $$LocalGuestsTableCreateCompanionBuilder,
          $$LocalGuestsTableUpdateCompanionBuilder,
          (
            LocalGuest,
            BaseReferences<_$AppDatabase, $LocalGuestsTable, LocalGuest>,
          ),
          LocalGuest,
          PrefetchHooks Function()
        > {
  $$LocalGuestsTableTableManager(_$AppDatabase db, $LocalGuestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalGuestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalGuestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalGuestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> relationship = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalGuestsCompanion(
                id: id,
                userId: userId,
                fullName: fullName,
                phone: phone,
                city: city,
                relationship: relationship,
                notes: notes,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> userId = const Value.absent(),
                required String fullName,
                Value<String?> phone = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> relationship = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalGuestsCompanion.insert(
                id: id,
                userId: userId,
                fullName: fullName,
                phone: phone,
                city: city,
                relationship: relationship,
                notes: notes,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalGuestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalGuestsTable,
      LocalGuest,
      $$LocalGuestsTableFilterComposer,
      $$LocalGuestsTableOrderingComposer,
      $$LocalGuestsTableAnnotationComposer,
      $$LocalGuestsTableCreateCompanionBuilder,
      $$LocalGuestsTableUpdateCompanionBuilder,
      (
        LocalGuest,
        BaseReferences<_$AppDatabase, $LocalGuestsTable, LocalGuest>,
      ),
      LocalGuest,
      PrefetchHooks Function()
    >;
typedef $$LocalGiftsTableCreateCompanionBuilder =
    LocalGiftsCompanion Function({
      required String id,
      Value<String> userId,
      required String weddingId,
      Value<String?> guestId,
      required String guestNameSnapshot,
      Value<int?> giftTypeId,
      Value<double> quantity,
      Value<double?> recordedAmountTry,
      Value<String?> notes,
      required DateTime givenAt,
      Value<int> syncStatus,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$LocalGiftsTableUpdateCompanionBuilder =
    LocalGiftsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> weddingId,
      Value<String?> guestId,
      Value<String> guestNameSnapshot,
      Value<int?> giftTypeId,
      Value<double> quantity,
      Value<double?> recordedAmountTry,
      Value<String?> notes,
      Value<DateTime> givenAt,
      Value<int> syncStatus,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$LocalGiftsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalGiftsTable> {
  $$LocalGiftsTableFilterComposer({
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

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weddingId => $composableBuilder(
    column: $table.weddingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get guestId => $composableBuilder(
    column: $table.guestId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get guestNameSnapshot => $composableBuilder(
    column: $table.guestNameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get giftTypeId => $composableBuilder(
    column: $table.giftTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get recordedAmountTry => $composableBuilder(
    column: $table.recordedAmountTry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get givenAt => $composableBuilder(
    column: $table.givenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalGiftsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalGiftsTable> {
  $$LocalGiftsTableOrderingComposer({
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

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weddingId => $composableBuilder(
    column: $table.weddingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get guestId => $composableBuilder(
    column: $table.guestId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get guestNameSnapshot => $composableBuilder(
    column: $table.guestNameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get giftTypeId => $composableBuilder(
    column: $table.giftTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get recordedAmountTry => $composableBuilder(
    column: $table.recordedAmountTry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get givenAt => $composableBuilder(
    column: $table.givenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalGiftsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalGiftsTable> {
  $$LocalGiftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get weddingId =>
      $composableBuilder(column: $table.weddingId, builder: (column) => column);

  GeneratedColumn<String> get guestId =>
      $composableBuilder(column: $table.guestId, builder: (column) => column);

  GeneratedColumn<String> get guestNameSnapshot => $composableBuilder(
    column: $table.guestNameSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<int> get giftTypeId => $composableBuilder(
    column: $table.giftTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get recordedAmountTry => $composableBuilder(
    column: $table.recordedAmountTry,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get givenAt =>
      $composableBuilder(column: $table.givenAt, builder: (column) => column);

  GeneratedColumn<int> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LocalGiftsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalGiftsTable,
          LocalGift,
          $$LocalGiftsTableFilterComposer,
          $$LocalGiftsTableOrderingComposer,
          $$LocalGiftsTableAnnotationComposer,
          $$LocalGiftsTableCreateCompanionBuilder,
          $$LocalGiftsTableUpdateCompanionBuilder,
          (
            LocalGift,
            BaseReferences<_$AppDatabase, $LocalGiftsTable, LocalGift>,
          ),
          LocalGift,
          PrefetchHooks Function()
        > {
  $$LocalGiftsTableTableManager(_$AppDatabase db, $LocalGiftsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalGiftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalGiftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalGiftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> weddingId = const Value.absent(),
                Value<String?> guestId = const Value.absent(),
                Value<String> guestNameSnapshot = const Value.absent(),
                Value<int?> giftTypeId = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double?> recordedAmountTry = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> givenAt = const Value.absent(),
                Value<int> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalGiftsCompanion(
                id: id,
                userId: userId,
                weddingId: weddingId,
                guestId: guestId,
                guestNameSnapshot: guestNameSnapshot,
                giftTypeId: giftTypeId,
                quantity: quantity,
                recordedAmountTry: recordedAmountTry,
                notes: notes,
                givenAt: givenAt,
                syncStatus: syncStatus,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> userId = const Value.absent(),
                required String weddingId,
                Value<String?> guestId = const Value.absent(),
                required String guestNameSnapshot,
                Value<int?> giftTypeId = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double?> recordedAmountTry = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime givenAt,
                Value<int> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalGiftsCompanion.insert(
                id: id,
                userId: userId,
                weddingId: weddingId,
                guestId: guestId,
                guestNameSnapshot: guestNameSnapshot,
                giftTypeId: giftTypeId,
                quantity: quantity,
                recordedAmountTry: recordedAmountTry,
                notes: notes,
                givenAt: givenAt,
                syncStatus: syncStatus,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalGiftsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalGiftsTable,
      LocalGift,
      $$LocalGiftsTableFilterComposer,
      $$LocalGiftsTableOrderingComposer,
      $$LocalGiftsTableAnnotationComposer,
      $$LocalGiftsTableCreateCompanionBuilder,
      $$LocalGiftsTableUpdateCompanionBuilder,
      (LocalGift, BaseReferences<_$AppDatabase, $LocalGiftsTable, LocalGift>),
      LocalGift,
      PrefetchHooks Function()
    >;
typedef $$LocalSyncQueueTableCreateCompanionBuilder =
    LocalSyncQueueCompanion Function({
      Value<int> id,
      required String targetTable,
      required String operation,
      required String localId,
      required String payload,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<DateTime> createdAt,
    });
typedef $$LocalSyncQueueTableUpdateCompanionBuilder =
    LocalSyncQueueCompanion Function({
      Value<int> id,
      Value<String> targetTable,
      Value<String> operation,
      Value<String> localId,
      Value<String> payload,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<DateTime> createdAt,
    });

class $$LocalSyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSyncQueueTable> {
  $$LocalSyncQueueTableFilterComposer({
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

  ColumnFilters<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalSyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSyncQueueTable> {
  $$LocalSyncQueueTableOrderingComposer({
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

  ColumnOrderings<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalSyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSyncQueueTable> {
  $$LocalSyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LocalSyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalSyncQueueTable,
          LocalSyncQueueData,
          $$LocalSyncQueueTableFilterComposer,
          $$LocalSyncQueueTableOrderingComposer,
          $$LocalSyncQueueTableAnnotationComposer,
          $$LocalSyncQueueTableCreateCompanionBuilder,
          $$LocalSyncQueueTableUpdateCompanionBuilder,
          (
            LocalSyncQueueData,
            BaseReferences<
              _$AppDatabase,
              $LocalSyncQueueTable,
              LocalSyncQueueData
            >,
          ),
          LocalSyncQueueData,
          PrefetchHooks Function()
        > {
  $$LocalSyncQueueTableTableManager(
    _$AppDatabase db,
    $LocalSyncQueueTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> targetTable = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LocalSyncQueueCompanion(
                id: id,
                targetTable: targetTable,
                operation: operation,
                localId: localId,
                payload: payload,
                retryCount: retryCount,
                lastError: lastError,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String targetTable,
                required String operation,
                required String localId,
                required String payload,
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LocalSyncQueueCompanion.insert(
                id: id,
                targetTable: targetTable,
                operation: operation,
                localId: localId,
                payload: payload,
                retryCount: retryCount,
                lastError: lastError,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalSyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalSyncQueueTable,
      LocalSyncQueueData,
      $$LocalSyncQueueTableFilterComposer,
      $$LocalSyncQueueTableOrderingComposer,
      $$LocalSyncQueueTableAnnotationComposer,
      $$LocalSyncQueueTableCreateCompanionBuilder,
      $$LocalSyncQueueTableUpdateCompanionBuilder,
      (
        LocalSyncQueueData,
        BaseReferences<_$AppDatabase, $LocalSyncQueueTable, LocalSyncQueueData>,
      ),
      LocalSyncQueueData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalWeddingsTableTableManager get localWeddings =>
      $$LocalWeddingsTableTableManager(_db, _db.localWeddings);
  $$LocalGuestsTableTableManager get localGuests =>
      $$LocalGuestsTableTableManager(_db, _db.localGuests);
  $$LocalGiftsTableTableManager get localGifts =>
      $$LocalGiftsTableTableManager(_db, _db.localGifts);
  $$LocalSyncQueueTableTableManager get localSyncQueue =>
      $$LocalSyncQueueTableTableManager(_db, _db.localSyncQueue);
}
