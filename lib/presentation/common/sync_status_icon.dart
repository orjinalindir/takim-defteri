import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../data/local/sync_queue/sync_service.dart';
import '../providers/app_providers.dart';

class SyncStatusIcon extends ConsumerWidget {
  const SyncStatusIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncService = ref.watch(syncStatusProvider);

    IconData icon;
    Color color;
    String tooltip;

    switch (syncService.status) {
      case SyncStatus.idle:
        icon = Icons.cloud_done;
        color = AppColors.success;
        tooltip = 'Senkronize';
        break;
      case SyncStatus.syncing:
        icon = Icons.sync;
        color = AppColors.primaryGold;
        tooltip = 'Senkronize ediliyor...';
        break;
      case SyncStatus.error:
        icon = Icons.cloud_off;
        color = AppColors.errorRed;
        tooltip = 'Senkronizasyon hatası';
        break;
      case SyncStatus.offline:
        icon = Icons.wifi_off;
        color = AppColors.warning;
        tooltip = 'Çevrimdışı';
        break;
    }

    return Tooltip(
      message: tooltip,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, color: color),
          if (syncService.pendingCount > 0)
            Positioned(
              right: -6,
              top: -6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.errorRed,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Text(
                  '${syncService.pendingCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
