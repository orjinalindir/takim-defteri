class GiftType {
  final int id;
  final String name;
  final String category;
  final String unit;
  final bool isActive;

  const GiftType({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    this.isActive = true,
  });

  static const List<GiftType> defaultTypes = [
    GiftType(id: 1, name: 'Bilezik', category: 'gold', unit: 'adet'),
    GiftType(id: 2, name: 'Çeyrek Altın', category: 'gold', unit: 'adet'),
    GiftType(id: 3, name: 'Yarım Altın', category: 'gold', unit: 'adet'),
    GiftType(id: 4, name: 'Tam Altın', category: 'gold', unit: 'adet'),
    GiftType(id: 5, name: 'Cumhuriyet', category: 'gold', unit: 'adet'),
    GiftType(id: 6, name: 'TL Nakit', category: 'cash', unit: 'TL'),
    GiftType(id: 7, name: 'Döviz', category: 'foreign_currency', unit: 'adet'),
    GiftType(id: 8, name: 'Diğer', category: 'other', unit: 'adet'),
  ];

  String get icon {
    switch (category) {
      case 'gold':
        return '💍';
      case 'cash':
        return '💵';
      case 'foreign_currency':
        return '💱';
      default:
        return '🎁';
    }
  }
}
