import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/date_utils.dart';
import '../../../domain/entities/wedding.dart';
import '../../common/native_ad_banner.dart';
import '../../common/sync_status_icon.dart';
import '../../providers/app_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingAsync = ref.watch(upcomingWeddingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: AppSizes.paddingM),
            child: SyncStatusIcon(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(upcomingWeddingsProvider);
          ref.invalidate(weddingsProvider);
        },
        child: ListView(
          children: [
            // Today's wedding highlight
            upcomingAsync.when(
              data: (weddings) {
                final todayWeddings = weddings.where(
                  (w) => AppDateUtils.isToday(w.weddingDate),
                );
                if (todayWeddings.isNotEmpty) {
                  return _buildTodayCard(context, todayWeddings.first);
                }
                return const SizedBox.shrink();
              },
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),

            // Native Ad Banner
            const NativeAdBanner(placement: 'home_banner'),

            // Upcoming weddings
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Text(
                AppStrings.upcomingWeddings,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),

            upcomingAsync.when(
              data: (weddings) {
                if (weddings.isEmpty) {
                  return _buildEmptyState(context);
                }
                return Column(
                  children: weddings.map((w) => _buildWeddingCard(context, w)).toList(),
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.paddingXL),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingXL),
                  child: Text('Hata: $error'),
                ),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/gift-entry'),
        icon: const Icon(Icons.add, size: 28),
        label: const Text(
          AppStrings.quickGiftEntry,
          style: TextStyle(fontSize: AppSizes.fontL, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.primaryGold,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTodayCard(BuildContext context, Wedding wedding) {
    return Container(
      margin: const EdgeInsets.all(AppSizes.paddingM),
      padding: const EdgeInsets.all(AppSizes.paddingL),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryGold, AppColors.secondaryNavy],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.celebration, color: Colors.white, size: 28),
              const SizedBox(width: AppSizes.paddingS),
              Text(
                AppStrings.todayWedding,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingS),
          Text(
            wedding.title,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
          Text(
            '${wedding.brideName} & ${wedding.groomName}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white70,
                ),
          ),
          if (wedding.venue != null)
            Text(
              wedding.venue!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white60,
                  ),
            ),
        ],
      ),
    );
  }

  Widget _buildWeddingCard(BuildContext context, Wedding wedding) {
    final daysText = AppDateUtils.relativeDateText(wedding.weddingDate);
    final isToday = AppDateUtils.isToday(wedding.weddingDate);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: AppSizes.paddingXS,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        onTap: () => context.go('/gift-entry'),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isToday ? AppColors.primaryGold : AppColors.primaryGoldLight,
                  borderRadius: BorderRadius.circular(AppSizes.radiusM),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${wedding.weddingDate.day}',
                      style: TextStyle(
                        fontSize: AppSizes.fontXL,
                        fontWeight: FontWeight.w700,
                        color: isToday ? Colors.white : AppColors.secondaryNavy,
                      ),
                    ),
                    Text(
                      _monthAbbr(wedding.weddingDate.month),
                      style: TextStyle(
                        fontSize: AppSizes.fontXS,
                        fontWeight: FontWeight.w600,
                        color: isToday ? Colors.white70 : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wedding.title,
                      style: const TextStyle(
                        fontSize: AppSizes.fontL,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${wedding.brideName} & ${wedding.groomName}',
                      style: const TextStyle(
                        fontSize: AppSizes.fontM,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingS,
                  vertical: AppSizes.paddingXS,
                ),
                decoration: BoxDecoration(
                  color: isToday ? AppColors.primaryGold : AppColors.primaryGoldLight,
                  borderRadius: BorderRadius.circular(AppSizes.radiusS),
                ),
                child: Text(
                  daysText,
                  style: TextStyle(
                    fontSize: AppSizes.fontS,
                    fontWeight: FontWeight.w600,
                    color: isToday ? Colors.white : AppColors.secondaryNavy,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingXL),
        child: Column(
          children: [
            const Icon(
              Icons.event_available,
              size: 64,
              color: AppColors.primaryGoldLight,
            ),
            const SizedBox(height: AppSizes.paddingM),
            Text(
              AppStrings.noUpcomingWeddings,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _monthAbbr(int month) {
    const months = ['', 'Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz', 'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara'];
    return months[month];
  }
}
