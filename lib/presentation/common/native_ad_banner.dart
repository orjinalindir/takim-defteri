import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/ad_campaign.dart';
import '../../domain/repositories/ad_repository.dart';
import '../providers/service_locator.dart';

class NativeAdBanner extends StatefulWidget {
  final String placement;
  final String? userCity;

  const NativeAdBanner({
    super.key,
    required this.placement,
    this.userCity,
  });

  @override
  State<NativeAdBanner> createState() => _NativeAdBannerState();
}

class _NativeAdBannerState extends State<NativeAdBanner> {
  AdCampaign? _campaign;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCampaign();
  }

  Future<void> _loadCampaign() async {
    try {
      final repo = getIt<AdRepository>();
      final campaigns = await repo.getActiveCampaigns(
        placement: widget.placement,
        city: widget.userCity,
      );
      if (mounted && campaigns.isNotEmpty) {
        setState(() {
          _campaign = campaigns.first;
          _loading = false;
        });
        repo.recordImpression(_campaign!.id);
      } else {
        if (mounted) setState(() => _loading = false);
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Shimmer.fromColors(
        baseColor: AppColors.primaryGoldLight.withValues(alpha: 0.3),
        highlightColor: AppColors.primaryGoldLight.withValues(alpha: 0.1),
        child: Container(
          height: AppSizes.adBannerHeight,
          margin: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingM,
            vertical: AppSizes.paddingS,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusL),
          ),
        ),
      );
    }

    if (_campaign == null) return const SizedBox.shrink();

    final campaign = _campaign!;
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: AppSizes.paddingS,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (campaign.logoUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.radiusS),
                    child: Image.network(
                      campaign.logoUrl!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGoldLight,
                          borderRadius: BorderRadius.circular(AppSizes.radiusS),
                        ),
                        child: const Icon(Icons.store, color: AppColors.primaryGold),
                      ),
                    ),
                  )
                else
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGoldLight,
                      borderRadius: BorderRadius.circular(AppSizes.radiusS),
                    ),
                    child: const Icon(Icons.store, color: AppColors.primaryGold),
                  ),
                const SizedBox(width: AppSizes.paddingS),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.businessName,
                        style: const TextStyle(
                          fontSize: AppSizes.fontM,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        AppStrings.sponsored,
                        style: TextStyle(
                          fontSize: AppSizes.fontXS,
                          color: AppColors.textSecondary.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.paddingS),
            Text(
              campaign.title,
              style: const TextStyle(
                fontSize: AppSizes.fontL,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (campaign.description != null) ...[
              const SizedBox(height: AppSizes.paddingXS),
              Text(
                campaign.description!,
                style: const TextStyle(
                  fontSize: AppSizes.fontM,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
            if (campaign.couponCode != null) ...[
              const SizedBox(height: AppSizes.paddingS),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: campaign.couponCode!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Kupon kodu kopyalandı!')),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingM,
                    vertical: AppSizes.paddingS,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryGold,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.radiusS),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        campaign.couponCode!,
                        style: const TextStyle(
                          fontSize: AppSizes.fontL,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryGold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(width: AppSizes.paddingS),
                      const Icon(Icons.copy, size: 16, color: AppColors.primaryGold),
                    ],
                  ),
                ),
              ),
            ],
            if (campaign.discountText != null) ...[
              const SizedBox(height: AppSizes.paddingXS),
              Text(
                campaign.discountText!,
                style: const TextStyle(
                  fontSize: AppSizes.fontM,
                  fontWeight: FontWeight.w600,
                  color: AppColors.success,
                ),
              ),
            ],
            if (campaign.phone != null) ...[
              const SizedBox(height: AppSizes.paddingS),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final repo = getIt<AdRepository>();
                    repo.recordClick(campaign.id);
                    final uri = Uri(scheme: 'tel', path: campaign.phone);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text(AppStrings.callNow),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
