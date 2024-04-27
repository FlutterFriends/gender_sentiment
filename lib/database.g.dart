// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ObservationsTable extends Observations
    with TableInfo<$ObservationsTable, Observation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ObservationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumnWithTypeConverter<Gender, String> gender =
      GeneratedColumn<String>('gender', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Gender>($ObservationsTable.$convertergender);
  static const VerificationMeta _sentimentMeta =
      const VerificationMeta('sentiment');
  @override
  late final GeneratedColumnWithTypeConverter<Sentiment, String> sentiment =
      GeneratedColumn<String>('sentiment', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Sentiment>($ObservationsTable.$convertersentiment);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, gender, sentiment, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'observations';
  @override
  VerificationContext validateIntegrity(Insertable<Observation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_genderMeta, const VerificationResult.success());
    context.handle(_sentimentMeta, const VerificationResult.success());
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Observation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Observation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      gender: $ObservationsTable.$convertergender.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!),
      sentiment: $ObservationsTable.$convertersentiment.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sentiment'])!),
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $ObservationsTable createAlias(String alias) {
    return $ObservationsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Gender, String, String> $convertergender =
      const EnumNameConverter<Gender>(Gender.values);
  static JsonTypeConverter2<Sentiment, String, String> $convertersentiment =
      const EnumNameConverter<Sentiment>(Sentiment.values);
}

class Observation extends DataClass implements Insertable<Observation> {
  final int id;
  final Gender gender;
  final Sentiment sentiment;
  final DateTime timestamp;
  const Observation(
      {required this.id,
      required this.gender,
      required this.sentiment,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['gender'] =
          Variable<String>($ObservationsTable.$convertergender.toSql(gender));
    }
    {
      map['sentiment'] = Variable<String>(
          $ObservationsTable.$convertersentiment.toSql(sentiment));
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  ObservationsCompanion toCompanion(bool nullToAbsent) {
    return ObservationsCompanion(
      id: Value(id),
      gender: Value(gender),
      sentiment: Value(sentiment),
      timestamp: Value(timestamp),
    );
  }

  factory Observation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Observation(
      id: serializer.fromJson<int>(json['id']),
      gender: $ObservationsTable.$convertergender
          .fromJson(serializer.fromJson<String>(json['gender'])),
      sentiment: $ObservationsTable.$convertersentiment
          .fromJson(serializer.fromJson<String>(json['sentiment'])),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gender': serializer
          .toJson<String>($ObservationsTable.$convertergender.toJson(gender)),
      'sentiment': serializer.toJson<String>(
          $ObservationsTable.$convertersentiment.toJson(sentiment)),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  Observation copyWith(
          {int? id,
          Gender? gender,
          Sentiment? sentiment,
          DateTime? timestamp}) =>
      Observation(
        id: id ?? this.id,
        gender: gender ?? this.gender,
        sentiment: sentiment ?? this.sentiment,
        timestamp: timestamp ?? this.timestamp,
      );
  @override
  String toString() {
    return (StringBuffer('Observation(')
          ..write('id: $id, ')
          ..write('gender: $gender, ')
          ..write('sentiment: $sentiment, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, gender, sentiment, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Observation &&
          other.id == this.id &&
          other.gender == this.gender &&
          other.sentiment == this.sentiment &&
          other.timestamp == this.timestamp);
}

class ObservationsCompanion extends UpdateCompanion<Observation> {
  final Value<int> id;
  final Value<Gender> gender;
  final Value<Sentiment> sentiment;
  final Value<DateTime> timestamp;
  const ObservationsCompanion({
    this.id = const Value.absent(),
    this.gender = const Value.absent(),
    this.sentiment = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  ObservationsCompanion.insert({
    this.id = const Value.absent(),
    required Gender gender,
    required Sentiment sentiment,
    required DateTime timestamp,
  })  : gender = Value(gender),
        sentiment = Value(sentiment),
        timestamp = Value(timestamp);
  static Insertable<Observation> custom({
    Expression<int>? id,
    Expression<String>? gender,
    Expression<String>? sentiment,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gender != null) 'gender': gender,
      if (sentiment != null) 'sentiment': sentiment,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  ObservationsCompanion copyWith(
      {Value<int>? id,
      Value<Gender>? gender,
      Value<Sentiment>? sentiment,
      Value<DateTime>? timestamp}) {
    return ObservationsCompanion(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      sentiment: sentiment ?? this.sentiment,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(
          $ObservationsTable.$convertergender.toSql(gender.value));
    }
    if (sentiment.present) {
      map['sentiment'] = Variable<String>(
          $ObservationsTable.$convertersentiment.toSql(sentiment.value));
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ObservationsCompanion(')
          ..write('id: $id, ')
          ..write('gender: $gender, ')
          ..write('sentiment: $sentiment, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $ObservationsTable observations = $ObservationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [observations];
}
