import '../../domain/entities/ad_campaign.dart';
import '../../domain/repositories/ad_repository.dart';
import '../remote/supabase/supabase_data_source.dart';

class AdRepositoryImpl implements AdRepository {
  final SupabaseDataSource _dataSource;

  AdRepositoryImpl(this._dataSource);

  @override
  Future<List<AdCampaign>> getActiveCampaigns({
    required String placement,
    String? city,
  }) async {
    try {
      return await _dataSource.getActiveCampaigns(
        placement: placement,
        city: city,
      );
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> recordImpression(String campaignId) async {
    try {
      await _dataSource.recordImpression(campaignId);
    } catch (_) {
      // Silently fail - non-critical
    }
  }

  @override
  Future<void> recordClick(String campaignId) async {
    try {
      await _dataSource.recordClick(campaignId);
    } catch (_) {
      // Silently fail - non-critical
    }
  }
}
