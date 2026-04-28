import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/gift.dart';
import '../../domain/repositories/gift_repository.dart';
import '../local/drift/app_database.dart';
import '../local/sync_queue/sync_service.dart';

class GiftRepositoryImpl implements GiftRepository {
  final AppDatabase _db;
  final SyncService _syncService;
  final String _userId;

  GiftRepositoryImpl({
    required AppDatabase db,
    required SyncService syncService,
    required String userId,
  })  : _db = db,
        _syncService = syncService,
        _userId = userId;

  Gift _mapFromLocal(LocalGift local) {
    return Gift(
      id: local.id,
      userId: local.userId,
      weddingId: local.weddingId,
      guestId: local.guestId,
      guestNameSnapshot: local.guestNameSnapshot,
      giftTypeId: local.giftTypeId,
      quantity: local.quantity,
      recordedAmountTry: local.recordedAmountTry,
      notes: local.notes,
      givenAt: local.givenAt,
      syncStatus: local.syncStatus,
      createdAt: local.createdAt,
    );
  }

  @override
  Future<List<Gift>> getGifts() async {
    final locals = await _db.getAllGifts();
    return locals.map(_mapFromLocal).toList();
  }

  @override
  Future<List<Gift>> getGiftsByWedding(String weddingId) async {
    final locals = await _db.getGiftsByWedding(weddingId);
    return locals.map(_mapFromLocal).toList();
  }

  @override
  Future<List<Gift>> getGiftsByGuest(String guestId) async {
    final locals = await _db.getGiftsByGuest(guestId);
    return locals.map(_mapFromLocal).toList();
  }

  @override
  Future<double> getTotalGiftValueByGuest(String guestId) async {
    final gifts = await getGiftsByGuest(guestId);
    double total = 0;
    for (final gift in gifts) {
      total += gift.recordedAmountTry ?? 0;
    }
    return total;
  }

  @override
  Future<void> addGift(Gift gift) async {
    final id = gift.id.isEmpty ? const Uuid().v4() : gift.id;
    final companion = LocalGiftsCompanion(
      id: Value(id),
      userId: Value(_userId),
      weddingId: Value(gift.weddingId),
      guestId: Value(gift.guestId),
      guestNameSnapshot: Value(gift.guestNameSnapshot),
      giftTypeId: Value(gift.giftTypeId),
      quantity: Value(gift.quantity),
      recordedAmountTry: Value(gift.recordedAmountTry),
      notes: Value(gift.notes),
      givenAt: Value(gift.givenAt),
      syncStatus: const Value(0),
      createdAt: Value(DateTime.now()),
    );
    await _db.insertGift(companion);

    await _syncService.addToQueue(
      tableName: 'gifts',
      operation: 'INSERT',
      localId: id,
      payload: {
        'id': id,
        'local_id': id,
        'user_id': _userId,
        'wedding_id': gift.weddingId,
        'guest_id': gift.guestId,
        'guest_name_snapshot': gift.guestNameSnapshot,
        'gift_type_id': gift.giftTypeId,
        'quantity': gift.quantity,
        'recorded_amount_try': gift.recordedAmountTry,
        'notes': gift.notes,
        'given_at': gift.givenAt.toIso8601String(),
      },
    );
  }

  @override
  Future<void> updateGift(Gift gift) async {
    final companion = LocalGiftsCompanion(
      id: Value(gift.id),
      userId: Value(_userId),
      weddingId: Value(gift.weddingId),
      guestId: Value(gift.guestId),
      guestNameSnapshot: Value(gift.guestNameSnapshot),
      giftTypeId: Value(gift.giftTypeId),
      quantity: Value(gift.quantity),
      recordedAmountTry: Value(gift.recordedAmountTry),
      notes: Value(gift.notes),
      givenAt: Value(gift.givenAt),
      syncStatus: const Value(0),
      createdAt: Value(gift.createdAt ?? DateTime.now()),
    );
    await _db.updateGift(companion);

    await _syncService.addToQueue(
      tableName: 'gifts',
      operation: 'UPDATE',
      localId: gift.id,
      payload: {
        'id': gift.id,
        'guest_id': gift.guestId,
        'guest_name_snapshot': gift.guestNameSnapshot,
        'gift_type_id': gift.giftTypeId,
        'quantity': gift.quantity,
        'recorded_amount_try': gift.recordedAmountTry,
        'notes': gift.notes,
        'given_at': gift.givenAt.toIso8601String(),
      },
    );
  }

  @override
  Future<void> deleteGift(String id) async {
    await _db.deleteGiftById(id);

    await _syncService.addToQueue(
      tableName: 'gifts',
      operation: 'DELETE',
      localId: id,
      payload: {'id': id},
    );
  }

  @override
  Stream<List<Gift>> watchGiftsByWedding(String weddingId) {
    return _db.watchGiftsByWedding(weddingId).map(
          (locals) => locals.map(_mapFromLocal).toList(),
        );
  }
}
