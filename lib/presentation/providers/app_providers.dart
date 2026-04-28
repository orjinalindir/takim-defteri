import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/local/drift/app_database.dart';
import '../../data/local/sync_queue/sync_service.dart';
import '../../domain/entities/gift.dart';
import '../../domain/entities/guest.dart';
import '../../domain/entities/wedding.dart';
import '../../domain/repositories/gift_repository.dart';
import '../../domain/repositories/guest_repository.dart';
import '../../domain/repositories/wedding_repository.dart';
import 'service_locator.dart';

// --- Auth State ---

final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

final currentUserProvider = Provider<User?>((ref) {
  return Supabase.instance.client.auth.currentUser;
});

// --- Sync ---

final syncServiceProvider = Provider<SyncService>((ref) {
  return getIt<SyncService>();
});

final syncStatusProvider = ChangeNotifierProvider<SyncService>((ref) {
  return getIt<SyncService>();
});

// --- Database ---

final databaseProvider = Provider<AppDatabase>((ref) {
  return getIt<AppDatabase>();
});

// --- Weddings ---

final weddingRepositoryProvider = Provider<WeddingRepository?>((ref) {
  if (getIt.isRegistered<WeddingRepository>()) {
    return getIt<WeddingRepository>();
  }
  return null;
});

final weddingsProvider = FutureProvider<List<Wedding>>((ref) async {
  final repo = ref.watch(weddingRepositoryProvider);
  if (repo == null) return [];
  return repo.getWeddings();
});

final upcomingWeddingsProvider = FutureProvider<List<Wedding>>((ref) async {
  final repo = ref.watch(weddingRepositoryProvider);
  if (repo == null) return [];
  return repo.getUpcomingWeddings(days: 7);
});

final weddingsByMonthProvider =
    FutureProvider.family<List<Wedding>, ({int year, int month})>((ref, params) async {
  final repo = ref.watch(weddingRepositoryProvider);
  if (repo == null) return [];
  return repo.getWeddingsByMonth(params.year, params.month);
});

// --- Guests ---

final guestRepositoryProvider = Provider<GuestRepository?>((ref) {
  if (getIt.isRegistered<GuestRepository>()) {
    return getIt<GuestRepository>();
  }
  return null;
});

final guestsProvider = FutureProvider<List<Guest>>((ref) async {
  final repo = ref.watch(guestRepositoryProvider);
  if (repo == null) return [];
  return repo.getGuests();
});

final guestSearchProvider =
    FutureProvider.family<List<Guest>, String>((ref, query) async {
  final repo = ref.watch(guestRepositoryProvider);
  if (repo == null) return [];
  if (query.isEmpty) return repo.getGuests();
  return repo.searchGuests(query);
});

// --- Gifts ---

final giftRepositoryProvider = Provider<GiftRepository?>((ref) {
  if (getIt.isRegistered<GiftRepository>()) {
    return getIt<GiftRepository>();
  }
  return null;
});

final giftsByWeddingProvider =
    FutureProvider.family<List<Gift>, String>((ref, weddingId) async {
  final repo = ref.watch(giftRepositoryProvider);
  if (repo == null) return [];
  return repo.getGiftsByWedding(weddingId);
});

// --- Selected States ---

final selectedWeddingIdProvider = StateProvider<String?>((ref) => null);

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
