import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/network/network_info.dart';
import '../../data/local/drift/app_database.dart';
import '../../data/local/sync_queue/sync_service.dart';
import '../../data/remote/supabase/supabase_data_source.dart';
import '../../data/repositories/ad_repository_impl.dart';
import '../../data/repositories/gift_repository_impl.dart';
import '../../data/repositories/guest_repository_impl.dart';
import '../../data/repositories/wedding_repository_impl.dart';
import '../../domain/repositories/ad_repository.dart';
import '../../domain/repositories/gift_repository.dart';
import '../../domain/repositories/guest_repository.dart';
import '../../domain/repositories/wedding_repository.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Core
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>()),
  );

  // Database
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Supabase
  getIt.registerLazySingleton<SupabaseDataSource>(
    () => SupabaseDataSource(Supabase.instance.client),
  );

  // Sync
  getIt.registerLazySingleton<SyncService>(
    () => SyncService(
      db: getIt<AppDatabase>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // Repositories
  getIt.registerLazySingleton<AdRepository>(
    () => AdRepositoryImpl(getIt<SupabaseDataSource>()),
  );
}

void setupUserScopedDependencies(String userId) {
  if (getIt.isRegistered<WeddingRepository>()) {
    getIt.unregister<WeddingRepository>();
  }
  if (getIt.isRegistered<GuestRepository>()) {
    getIt.unregister<GuestRepository>();
  }
  if (getIt.isRegistered<GiftRepository>()) {
    getIt.unregister<GiftRepository>();
  }

  getIt.registerLazySingleton<WeddingRepository>(
    () => WeddingRepositoryImpl(
      db: getIt<AppDatabase>(),
      syncService: getIt<SyncService>(),
      userId: userId,
    ),
  );

  getIt.registerLazySingleton<GuestRepository>(
    () => GuestRepositoryImpl(
      db: getIt<AppDatabase>(),
      syncService: getIt<SyncService>(),
      userId: userId,
    ),
  );

  getIt.registerLazySingleton<GiftRepository>(
    () => GiftRepositoryImpl(
      db: getIt<AppDatabase>(),
      syncService: getIt<SyncService>(),
      userId: userId,
    ),
  );
}
