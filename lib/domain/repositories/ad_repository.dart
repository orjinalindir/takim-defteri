import '../entities/ad_campaign.dart';

abstract class AdRepository {
  Future<List<AdCampaign>> getActiveCampaigns({
    required String placement,
    String? city,
  });
  Future<void> recordImpression(String campaignId);
  Future<void> recordClick(String campaignId);
}
