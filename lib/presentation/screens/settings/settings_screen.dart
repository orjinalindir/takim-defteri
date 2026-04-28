import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/local/sync_queue/sync_service.dart';
import '../../providers/app_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncService = ref.watch(syncStatusProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: ListView(
        children: [
          // Profile
          _buildSection(
            context,
            title: AppStrings.profile,
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primaryGoldLight,
                  child: Text(
                    user?.phone?.substring(0, 1) ?? 'K',
                    style: const TextStyle(
                      fontSize: AppSizes.fontXL,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondaryNavy,
                    ),
                  ),
                ),
                title: Text(
                  user?.phone ?? 'Kullanıcı',
                  style: const TextStyle(
                    fontSize: AppSizes.fontL,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  user?.email ?? '',
                  style: const TextStyle(fontSize: AppSizes.fontM),
                ),
              ),
            ],
          ),

          // Sync Status
          _buildSection(
            context,
            title: AppStrings.syncStatus,
            children: [
              ListTile(
                leading: Icon(
                  _syncIcon(syncService.status),
                  color: _syncColor(syncService.status),
                  size: 28,
                ),
                title: Text(
                  _syncText(syncService.status),
                  style: const TextStyle(fontSize: AppSizes.fontL),
                ),
                subtitle: Text(
                  'Bekleyen: ${syncService.pendingCount} kayıt',
                  style: const TextStyle(fontSize: AppSizes.fontM),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.refresh, size: 28),
                  onPressed: () => syncService.syncAll(),
                ),
              ),
            ],
          ),

          // Data
          _buildSection(
            context,
            title: AppStrings.dataBackup,
            children: [
              ListTile(
                leading: const Icon(Icons.file_download, size: 28, color: AppColors.secondaryNavy),
                title: const Text(
                  AppStrings.exportCsv,
                  style: TextStyle(fontSize: AppSizes.fontL),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('CSV dışa aktarma yakında eklenecek')),
                  );
                },
              ),
            ],
          ),

          // About
          _buildSection(
            context,
            title: AppStrings.about,
            children: [
              const ListTile(
                leading: Icon(Icons.info_outline, size: 28, color: AppColors.secondaryNavy),
                title: Text(
                  AppStrings.appName,
                  style: TextStyle(fontSize: AppSizes.fontL),
                ),
                subtitle: Text(
                  'Sürüm 1.0.0',
                  style: TextStyle(fontSize: AppSizes.fontM),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined, size: 28, color: AppColors.secondaryNavy),
                title: const Text(
                  AppStrings.privacyPolicy,
                  style: TextStyle(fontSize: AppSizes.fontL),
                ),
                onTap: () {},
              ),
            ],
          ),

          // Sign Out
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: OutlinedButton(
              onPressed: () async {
                await Supabase.instance.client.auth.signOut();
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.errorRed,
                side: const BorderSide(color: AppColors.errorRed),
              ),
              child: const Text(
                'Çıkış Yap',
                style: TextStyle(fontSize: AppSizes.fontL),
              ),
            ),
          ),

          const SizedBox(height: AppSizes.paddingXL),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.paddingM,
            AppSizes.paddingL,
            AppSizes.paddingM,
            AppSizes.paddingS,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  IconData _syncIcon(SyncStatus status) {
    switch (status) {
      case SyncStatus.idle:
        return Icons.cloud_done;
      case SyncStatus.syncing:
        return Icons.sync;
      case SyncStatus.error:
        return Icons.cloud_off;
      case SyncStatus.offline:
        return Icons.wifi_off;
    }
  }

  Color _syncColor(SyncStatus status) {
    switch (status) {
      case SyncStatus.idle:
        return AppColors.success;
      case SyncStatus.syncing:
        return AppColors.primaryGold;
      case SyncStatus.error:
        return AppColors.errorRed;
      case SyncStatus.offline:
        return AppColors.warning;
    }
  }

  String _syncText(SyncStatus status) {
    switch (status) {
      case SyncStatus.idle:
        return AppStrings.synced;
      case SyncStatus.syncing:
        return 'Senkronize ediliyor...';
      case SyncStatus.error:
        return AppStrings.syncError;
      case SyncStatus.offline:
        return AppStrings.offline;
    }
  }
}
