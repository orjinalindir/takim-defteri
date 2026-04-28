import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/local/sync_queue/sync_service.dart';
import 'presentation/providers/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('tr_TR', null);

  await Supabase.initialize(
    url: const String.fromEnvironment(
      'SUPABASE_URL',
      defaultValue: 'https://your-project.supabase.co',
    ),
    anonKey: const String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue: 'your-anon-key',
    ),
  );

  await setupServiceLocator();

  final syncService = getIt<SyncService>();
  syncService.initialize();

  final onboardingDone = await isOnboardingCompleted();

  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final session = data.session;
    if (session != null) {
      setupUserScopedDependencies(session.user.id);
    }
  });

  final currentSession = Supabase.instance.client.auth.currentSession;
  if (currentSession != null) {
    setupUserScopedDependencies(currentSession.user.id);
  }

  runApp(
    ProviderScope(
      child: TakimDefteriApp(onboardingCompleted: onboardingDone),
    ),
  );
}

class TakimDefteriApp extends StatelessWidget {
  final bool onboardingCompleted;

  const TakimDefteriApp({super.key, required this.onboardingCompleted});

  @override
  Widget build(BuildContext context) {
    final router = createRouter(onboardingCompleted: onboardingCompleted);

    return MaterialApp.router(
      title: 'Takım Defteri',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
      locale: const Locale('tr', 'TR'),
    );
  }
}
