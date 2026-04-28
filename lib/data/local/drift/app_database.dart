import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// --- Table Definitions ---

class LocalWeddings extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().withDefault(const Constant(''))();
  TextColumn get title => text()();
  TextColumn get brideName => text()();
  TextColumn get groomName => text()();
  DateTimeColumn get weddingDate => dateTime()();
  TextColumn get venue => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isMine => boolean().withDefault(const Constant(true))();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalGuests extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().withDefault(const Constant(''))();
  TextColumn get fullName => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get relationship => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalGifts extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().withDefault(const Constant(''))();
  TextColumn get weddingId => text()();
  TextColumn get guestId => text().nullable()();
  TextColumn get guestNameSnapshot => text()();
  IntColumn get giftTypeId => integer().nullable()();
  RealColumn get quantity => real().withDefault(const Constant(1.0))();
  RealColumn get recordedAmountTry => real().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get givenAt => dateTime()();
  IntColumn get syncStatus => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalSyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get targetTable => text()();
  TextColumn get operation => text()();
  TextColumn get localId => text()();
  TextColumn get payload => text()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// --- Database ---

@DriftDatabase(tables: [LocalWeddings, LocalGuests, LocalGifts, LocalSyncQueue])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  // --- Wedding DAO methods ---

  Future<List<LocalWedding>> getAllWeddings() =>
      (select(localWeddings)..orderBy([(t) => OrderingTerm.desc(t.weddingDate)])).get();

  Stream<List<LocalWedding>> watchAllWeddings() =>
      (select(localWeddings)..orderBy([(t) => OrderingTerm.desc(t.weddingDate)])).watch();

  Future<LocalWedding?> getWeddingById(String id) =>
      (select(localWeddings)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<LocalWedding>> getUpcomingWeddings(int days) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final endDate = today.add(Duration(days: days));
    return (select(localWeddings)
          ..where((t) => t.weddingDate.isBiggerOrEqualValue(today) & t.weddingDate.isSmallerOrEqualValue(endDate))
          ..orderBy([(t) => OrderingTerm.asc(t.weddingDate)]))
        .get();
  }

  Future<List<LocalWedding>> getWeddingsByMonth(int year, int month) {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 0, 23, 59, 59);
    return (select(localWeddings)
          ..where((t) => t.weddingDate.isBiggerOrEqualValue(start) & t.weddingDate.isSmallerOrEqualValue(end))
          ..orderBy([(t) => OrderingTerm.asc(t.weddingDate)]))
        .get();
  }

  Future<int> insertWedding(LocalWeddingsCompanion wedding) =>
      into(localWeddings).insert(wedding, mode: InsertMode.insertOrReplace);

  Future<bool> updateWedding(LocalWeddingsCompanion wedding) =>
      update(localWeddings).replace(wedding);

  Future<int> deleteWeddingById(String id) =>
      (delete(localWeddings)..where((t) => t.id.equals(id))).go();

  // --- Guest DAO methods ---

  Future<List<LocalGuest>> getAllGuests() =>
      (select(localGuests)..orderBy([(t) => OrderingTerm.asc(t.fullName)])).get();

  Stream<List<LocalGuest>> watchAllGuests() =>
      (select(localGuests)..orderBy([(t) => OrderingTerm.asc(t.fullName)])).watch();

  Future<LocalGuest?> getGuestById(String id) =>
      (select(localGuests)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<LocalGuest>> searchGuests(String query) {
    final pattern = '%$query%';
    return (select(localGuests)
          ..where((t) => t.fullName.like(pattern))
          ..orderBy([(t) => OrderingTerm.asc(t.fullName)]))
        .get();
  }

  Future<int> insertGuest(LocalGuestsCompanion guest) =>
      into(localGuests).insert(guest, mode: InsertMode.insertOrReplace);

  Future<bool> updateGuest(LocalGuestsCompanion guest) =>
      update(localGuests).replace(guest);

  Future<int> deleteGuestById(String id) =>
      (delete(localGuests)..where((t) => t.id.equals(id))).go();

  // --- Gift DAO methods ---

  Future<List<LocalGift>> getAllGifts() =>
      (select(localGifts)..orderBy([(t) => OrderingTerm.desc(t.givenAt)])).get();

  Future<List<LocalGift>> getGiftsByWedding(String weddingId) =>
      (select(localGifts)
            ..where((t) => t.weddingId.equals(weddingId))
            ..orderBy([(t) => OrderingTerm.desc(t.givenAt)]))
          .get();

  Stream<List<LocalGift>> watchGiftsByWedding(String weddingId) =>
      (select(localGifts)
            ..where((t) => t.weddingId.equals(weddingId))
            ..orderBy([(t) => OrderingTerm.desc(t.givenAt)]))
          .watch();

  Future<List<LocalGift>> getGiftsByGuest(String guestId) =>
      (select(localGifts)..where((t) => t.guestId.equals(guestId))).get();

  Future<int> insertGift(LocalGiftsCompanion gift) =>
      into(localGifts).insert(gift, mode: InsertMode.insertOrReplace);

  Future<bool> updateGift(LocalGiftsCompanion gift) =>
      update(localGifts).replace(gift);

  Future<int> deleteGiftById(String id) =>
      (delete(localGifts)..where((t) => t.id.equals(id))).go();

  // --- Sync Queue DAO methods ---

  Future<List<LocalSyncQueueData>> getPendingSyncItems() =>
      (select(localSyncQueue)
            ..where((t) => t.retryCount.isSmallerThanValue(3))
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .get();

  Future<int> getPendingSyncCount() async {
    final items = await getPendingSyncItems();
    return items.length;
  }

  Future<int> insertSyncItem(LocalSyncQueueCompanion item) =>
      into(localSyncQueue).insert(item);

  Future<int> deleteSyncItem(int id) =>
      (delete(localSyncQueue)..where((t) => t.id.equals(id))).go();

  Future<void> updateSyncItemRetry(int id, int retryCount, String? error) =>
      (update(localSyncQueue)..where((t) => t.id.equals(id))).write(
        LocalSyncQueueCompanion(
          retryCount: Value(retryCount),
          lastError: Value(error),
        ),
      );

  Future<void> clearProcessedSyncItems() =>
      (delete(localSyncQueue)..where((t) => t.retryCount.isBiggerOrEqualValue(3))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'takim_defteri.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
