import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/entities/ad_campaign.dart';

class SupabaseDataSource {
  final SupabaseClient _client;

  SupabaseDataSource(this._client);

  SupabaseClient get client => _client;

  // --- Auth ---

  Future<void> signInWithOtp(String phone) async {
    await _client.auth.signInWithOtp(phone: phone);
  }

  Future<AuthResponse> verifyOtp(String phone, String token) async {
    return await _client.auth.verifyOTP(
      phone: phone,
      token: token,
      type: OtpType.sms,
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  String? get currentUserId => _client.auth.currentUser?.id;
  User? get currentUser => _client.auth.currentUser;
  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;

  // --- Users ---

  Future<void> upsertUserProfile(Map<String, dynamic> data) async {
    await _client.from('users').upsert(data);
  }

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await _client.from('users').select().eq('id', userId).maybeSingle();
    return response;
  }

  // --- Weddings ---

  Future<List<Map<String, dynamic>>> getWeddings(String userId) async {
    return await _client.from('weddings').select().eq('user_id', userId).order('wedding_date', ascending: false);
  }

  Future<void> insertWedding(Map<String, dynamic> data) async {
    await _client.from('weddings').insert(data);
  }

  Future<void> updateWedding(Map<String, dynamic> data) async {
    await _client.from('weddings').update(data).eq('id', data['id']);
  }

  Future<void> deleteWedding(String id) async {
    await _client.from('weddings').delete().eq('id', id);
  }

  // --- Guests ---

  Future<List<Map<String, dynamic>>> getGuests(String userId) async {
    return await _client.from('wedding_guests').select().eq('user_id', userId).order('full_name');
  }

  Future<void> insertGuest(Map<String, dynamic> data) async {
    await _client.from('wedding_guests').insert(data);
  }

  Future<void> updateGuest(Map<String, dynamic> data) async {
    await _client.from('wedding_guests').update(data).eq('id', data['id']);
  }

  Future<void> deleteGuest(String id) async {
    await _client.from('wedding_guests').delete().eq('id', id);
  }

  // --- Gifts ---

  Future<List<Map<String, dynamic>>> getGifts(String userId) async {
    return await _client.from('gifts').select().eq('user_id', userId).order('given_at', ascending: false);
  }

  Future<void> insertGift(Map<String, dynamic> data) async {
    await _client.from('gifts').insert(data);
  }

  Future<void> updateGift(Map<String, dynamic> data) async {
    await _client.from('gifts').update(data).eq('id', data['id']);
  }

  Future<void> deleteGift(String id) async {
    await _client.from('gifts').delete().eq('id', id);
  }

  // --- Ads ---

  Future<List<AdCampaign>> getActiveCampaigns({
    required String placement,
    String? city,
  }) async {
    var query = _client
        .from('ad_campaigns')
        .select('*, advertisers!inner(business_name, phone, logo_url)')
        .eq('placement', placement)
        .eq('is_active', true)
        .lte('start_date', DateTime.now().toIso8601String())
        .gte('end_date', DateTime.now().toIso8601String());

    if (city != null) {
      query = query.contains('target_cities', [city]);
    }

    final response = await query;

    return response.map((json) {
      final advertiser = json['advertisers'] as Map<String, dynamic>;
      return AdCampaign(
        id: json['id'] as String,
        advertiserId: json['advertiser_id'] as String,
        businessName: advertiser['business_name'] as String,
        title: json['title'] as String,
        description: json['description'] as String?,
        imageUrl: json['image_url'] as String?,
        couponCode: json['coupon_code'] as String?,
        discountText: json['discount_text'] as String?,
        targetCities: (json['target_cities'] as List?)?.cast<String>() ?? [],
        placement: json['placement'] as String,
        phone: advertiser['phone'] as String?,
        logoUrl: advertiser['logo_url'] as String?,
        startDate: DateTime.parse(json['start_date'] as String),
        endDate: DateTime.parse(json['end_date'] as String),
      );
    }).toList();
  }

  Future<void> recordImpression(String campaignId) async {
    await _client.rpc('increment_impression', params: {'campaign_id': campaignId});
  }

  Future<void> recordClick(String campaignId) async {
    await _client.rpc('increment_click', params: {'campaign_id': campaignId});
  }
}
