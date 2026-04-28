class AdCampaign {
  final String id;
  final String advertiserId;
  final String businessName;
  final String title;
  final String? description;
  final String? imageUrl;
  final String? couponCode;
  final String? discountText;
  final List<String> targetCities;
  final String placement;
  final String? phone;
  final String? logoUrl;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  const AdCampaign({
    required this.id,
    required this.advertiserId,
    required this.businessName,
    required this.title,
    this.description,
    this.imageUrl,
    this.couponCode,
    this.discountText,
    this.targetCities = const [],
    required this.placement,
    this.phone,
    this.logoUrl,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
  });
}
