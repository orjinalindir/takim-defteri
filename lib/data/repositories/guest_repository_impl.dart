import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/guest.dart';
import '../../domain/repositories/guest_repository.dart';
import '../local/drift/app_database.dart';
import '../local/sync_queue/sync_service.dart';

class GuestRepositoryImpl implements GuestRepository {
  final AppDatabase _db;
  final SyncService _syncService;
  final String _userId;

  GuestRepositoryImpl({
    required AppDatabase db,
    required SyncService syncService,
    required String userId,
  })  : _db = db,
        _syncService = syncService,
        _userId = userId;

  Guest _mapFromLocal(LocalGuest local) {
    return Guest(
      id: local.id,
      userId: local.userId,
      fullName: local.fullName,
      phone: local.phone,
      city: local.city,
      relationship: local.relationship,
      notes: local.notes,
      syncStatus: local.syncStatus,
    );
  }

  @override
  Future<List<Guest>> getGuests() async {
    final locals = await _db.getAllGuests();
    return locals.map(_mapFromLocal).toList();
  }

  @override
  Future<Guest?> getGuestById(String id) async {
    final local = await _db.getGuestById(id);
    return local != null ? _mapFromLocal(local) : null;
  }

  @override
  Future<List<Guest>> searchGuests(String query) async {
    final locals = await _db.searchGuests(query);
    return locals.map(_mapFromLocal).toList();
  }

  @override
  Future<List<Guest>> getGuestsByCity(String city) async {
    final all = await _db.getAllGuests();
    return all
        .where((g) => g.city?.toLowerCase() == city.toLowerCase())
        .map(_mapFromLocal)
        .toList();
  }

  @override
  Future<List<Guest>> getGuestsByRelationship(String relationship) async {
    final all = await _db.getAllGuests();
    return all
        .where((g) => g.relationship == relationship)
        .map(_mapFromLocal)
        .toList();
  }

  @override
  Future<void> addGuest(Guest guest) async {
    final id = guest.id.isEmpty ? const Uuid().v4() : guest.id;
    final companion = LocalGuestsCompanion(
      id: Value(id),
      userId: Value(_userId),
      fullName: Value(guest.fullName),
      phone: Value(guest.phone),
      city: Value(guest.city),
      relationship: Value(guest.relationship),
      notes: Value(guest.notes),
      syncStatus: const Value(0),
    );
    await _db.insertGuest(companion);

    await _syncService.addToQueue(
      tableName: 'wedding_guests',
      operation: 'INSERT',
      localId: id,
      payload: {
        'id': id,
        'user_id': _userId,
        'full_name': guest.fullName,
        'phone': guest.phone,
        'city': guest.city,
        'relationship': guest.relationship,
        'notes': guest.notes,
      },
    );
  }

  @override
  Future<void> updateGuest(Guest guest) async {
    final companion = LocalGuestsCompanion(
      id: Value(guest.id),
      userId: Value(_userId),
      fullName: Value(guest.fullName),
      phone: Value(guest.phone),
      city: Value(guest.city),
      relationship: Value(guest.relationship),
      notes: Value(guest.notes),
      syncStatus: const Value(0),
    );
    await _db.updateGuest(companion);

    await _syncService.addToQueue(
      tableName: 'wedding_guests',
      operation: 'UPDATE',
      localId: guest.id,
      payload: {
        'id': guest.id,
        'full_name': guest.fullName,
        'phone': guest.phone,
        'city': guest.city,
        'relationship': guest.relationship,
        'notes': guest.notes,
      },
    );
  }

  @override
  Future<void> deleteGuest(String id) async {
    await _db.deleteGuestById(id);

    await _syncService.addToQueue(
      tableName: 'wedding_guests',
      operation: 'DELETE',
      localId: id,
      payload: {'id': id},
    );
  }

  @override
  Stream<List<Guest>> watchGuests() {
    return _db.watchAllGuests().map(
          (locals) => locals.map(_mapFromLocal).toList(),
        );
  }
}
