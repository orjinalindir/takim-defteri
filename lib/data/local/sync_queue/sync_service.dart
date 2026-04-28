import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/network/network_info.dart';
import '../drift/app_database.dart';

enum SyncStatus { idle, syncing, error, offline }

class SyncService extends ChangeNotifier {
  final AppDatabase _db;
  final NetworkInfo _networkInfo;
  StreamSubscription<bool>? _connectivitySubscription;
  SyncStatus _status = SyncStatus.idle;
  int _pendingCount = 0;

  SyncService({
    required AppDatabase db,
    required NetworkInfo networkInfo,
  })  : _db = db,
        _networkInfo = networkInfo;

  SyncStatus get status => _status;
  int get pendingCount => _pendingCount;

  void initialize() {
    _connectivitySubscription = _networkInfo.onConnectivityChanged.listen(
      (isConnected) {
        if (isConnected) {
          syncAll();
        } else {
          _status = SyncStatus.offline;
          notifyListeners();
        }
      },
    );
    _updatePendingCount();
  }

  Future<void> _updatePendingCount() async {
    _pendingCount = await _db.getPendingSyncCount();
    notifyListeners();
  }

  Future<void> syncAll() async {
    final isConnected = await _networkInfo.isConnected;
    if (!isConnected) {
      _status = SyncStatus.offline;
      notifyListeners();
      return;
    }

    _status = SyncStatus.syncing;
    notifyListeners();

    try {
      final items = await _db.getPendingSyncItems();
      for (final item in items) {
        await _processItem(item);
      }
      _status = SyncStatus.idle;
    } catch (e) {
      _status = SyncStatus.error;
    }

    await _updatePendingCount();
  }

  Future<void> _processItem(LocalSyncQueueData item) async {
    try {
      final payload = jsonDecode(item.payload) as Map<String, dynamic>;
      final supabase = Supabase.instance.client;

      switch (item.operation) {
        case 'INSERT':
          await supabase.from(item.targetTable).insert(payload);
          break;
        case 'UPDATE':
          final id = payload['id'];
          if (id != null) {
            await supabase.from(item.targetTable).update(payload).eq('id', id);
          }
          break;
        case 'DELETE':
          final id = payload['id'];
          if (id != null) {
            await supabase.from(item.targetTable).delete().eq('id', id);
          }
          break;
      }

      await _db.deleteSyncItem(item.id);
      await _markLocalRecordSynced(item.targetTable, item.localId);
    } catch (e) {
      final newRetry = item.retryCount + 1;
      await _db.updateSyncItemRetry(item.id, newRetry, e.toString());
    }
  }

  Future<void> _markLocalRecordSynced(String tableName, String localId) async {
    switch (tableName) {
      case 'weddings':
        await (_db.update(_db.localWeddings)
              ..where((t) => t.id.equals(localId)))
            .write(const LocalWeddingsCompanion(syncStatus: Value(1)));
        break;
      case 'gifts':
        await (_db.update(_db.localGifts)
              ..where((t) => t.id.equals(localId)))
            .write(const LocalGiftsCompanion(syncStatus: Value(1)));
        break;
      case 'wedding_guests':
        await (_db.update(_db.localGuests)
              ..where((t) => t.id.equals(localId)))
            .write(const LocalGuestsCompanion(syncStatus: Value(1)));
        break;
    }
  }

  Future<void> addToQueue({
    required String tableName,
    required String operation,
    required String localId,
    required Map<String, dynamic> payload,
  }) async {
    await _db.insertSyncItem(
      LocalSyncQueueCompanion(
        targetTable: Value(tableName),
        operation: Value(operation),
        localId: Value(localId),
        payload: Value(jsonEncode(payload)),
        createdAt: Value(DateTime.now()),
      ),
    );
    await _updatePendingCount();

    final isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      syncAll();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
