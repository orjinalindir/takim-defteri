import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/wedding.dart';
import '../../domain/repositories/wedding_repository.dart';
import '../local/drift/app_database.dart';
import '../local/sync_queue/sync_service.dart';

class WeddingRepositoryImpl implements WeddingRepository {
  final AppDatabase _db;
  final SyncService _syncService;
  final String _userId;

  WeddingRepositoryImpl({
    required AppDatabase db,
    required SyncService syncService,
    required String userId,
  })  : _db = db,
        _syncService = syncService,
        _userId = userId;

  Wedding _mapFromLocal(LocalWedding local) {
    return Wedding(
      id: local.id,
      userId: local.userId,
      title: local.title,
      brideName: local.brideName,
      groomName: local.groomName,
      weddingDate: local.weddingDate,
      venue: local.venue,
      city: local.city,
      notes: local.notes,
      isMyWedding: local.isMine,
      syncStatus: local.syncStatus,
      updatedAt: local.updatedAt,
    );
  }

  @override
  Future<List<Wedding>> getWeddings() async {
    final locals = await _db.getAllWeddings();
    return locals.map(_mapFromLocal).toList();
  }

  @override
  Future<Wedding?> getWeddingById(String id) async {
    final local = await _db.getWeddingById(id);
    return local != null ? _mapFromLocal(local) : null;
  }

  @override
  Future<List<Wedding>> getUpcomingWeddings({int days = 7}) async {
    final locals = await _db.getUpcomingWeddings(days);
    return locals.map(_mapFromLocal).toList();
  }

  @override
  Future<List<Wedding>> getWeddingsByMonth(int year, int month) async {
    final locals = await _db.getWeddingsByMonth(year, month);
    return locals.map(_mapFromLocal).toList();
  }

  @override
  Future<void> addWedding(Wedding wedding) async {
    final id = wedding.id.isEmpty ? const Uuid().v4() : wedding.id;
    final companion = LocalWeddingsCompanion(
      id: Value(id),
      userId: Value(_userId),
      title: Value(wedding.title),
      brideName: Value(wedding.brideName),
      groomName: Value(wedding.groomName),
      weddingDate: Value(wedding.weddingDate),
      venue: Value(wedding.venue),
      city: Value(wedding.city),
      notes: Value(wedding.notes),
      isMine: Value(wedding.isMyWedding),
      syncStatus: const Value(0),
      updatedAt: Value(DateTime.now()),
    );
    await _db.insertWedding(companion);

    await _syncService.addToQueue(
      tableName: 'weddings',
      operation: 'INSERT',
      localId: id,
      payload: {
        'id': id,
        'user_id': _userId,
        'title': wedding.title,
        'bride_name': wedding.brideName,
        'groom_name': wedding.groomName,
        'wedding_date': wedding.weddingDate.toIso8601String().split('T')[0],
        'venue': wedding.venue,
        'city': wedding.city,
        'notes': wedding.notes,
        'is_my_wedding': wedding.isMyWedding,
      },
    );
  }

  @override
  Future<void> updateWedding(Wedding wedding) async {
    final companion = LocalWeddingsCompanion(
      id: Value(wedding.id),
      userId: Value(_userId),
      title: Value(wedding.title),
      brideName: Value(wedding.brideName),
      groomName: Value(wedding.groomName),
      weddingDate: Value(wedding.weddingDate),
      venue: Value(wedding.venue),
      city: Value(wedding.city),
      notes: Value(wedding.notes),
      isMine: Value(wedding.isMyWedding),
      syncStatus: const Value(0),
      updatedAt: Value(DateTime.now()),
    );
    await _db.updateWedding(companion);

    await _syncService.addToQueue(
      tableName: 'weddings',
      operation: 'UPDATE',
      localId: wedding.id,
      payload: {
        'id': wedding.id,
        'title': wedding.title,
        'bride_name': wedding.brideName,
        'groom_name': wedding.groomName,
        'wedding_date': wedding.weddingDate.toIso8601String().split('T')[0],
        'venue': wedding.venue,
        'city': wedding.city,
        'notes': wedding.notes,
        'is_my_wedding': wedding.isMyWedding,
      },
    );
  }

  @override
  Future<void> deleteWedding(String id) async {
    await _db.deleteWeddingById(id);

    await _syncService.addToQueue(
      tableName: 'weddings',
      operation: 'DELETE',
      localId: id,
      payload: {'id': id},
    );
  }

  @override
  Stream<List<Wedding>> watchWeddings() {
    return _db.watchAllWeddings().map(
          (locals) => locals.map(_mapFromLocal).toList(),
        );
  }
}
